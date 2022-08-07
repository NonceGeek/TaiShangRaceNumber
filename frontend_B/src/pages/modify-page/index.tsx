import { history } from 'umi'
import arrow from '../../assets/icons/arrow.svg'
import text from '../../assets/icons/text.svg'
import { SketchPicker } from 'react-color'
import { BulbFilled, DownOutlined } from '@ant-design/icons'
import RectButton from '../../components/rect-button'
import { create, CID, IPFSHTTPClient } from "ipfs-http-client"
import domtoimage from 'dom-to-image';
import rLogo from '../../assets/icons/r-title.svg'

import './index.less';
import {Button, Popover} from "antd"
import { useEffect, useState } from 'react';



export default function ModifyPage(props: any) {

  const [color, setColor] = useState('#00209E')
  const [showColorPicker, setShowColorPicker] = useState(false)
  const [image, setImage] = useState({cid: '', path: ''})
  const [imageUrl, setImageUrl] = useState('')
  const handleChangeColor = (e: any) => {
    setColor(e.hex)
  }

    const parseValue = (value: string) => {
        return parseInt(value, 10);
    }

  const draw = async () => {
    const dom = document.getElementById('draw') as any
    const box = window.getComputedStyle(dom);
    // DOM 节点计算后宽高
    const width = parseValue(box.width);
    const height = parseValue(box.height);

    domtoimage.toSvg(dom, {width: width, height: height, style: typeList[props.location.query.type]})
    .then(function (dataUrl: string) {
      setImageUrl(dataUrl)
      addFile(dataUrl)
    })
    .catch(function (error: any) {
        console.error('oops, something went wrong!', error);
    });
  }

  const addFile = async (file: any) => {
    // const ipfs = create(new URL('https://ipfs.infura.io:5001'))
    let ipfs: IPFSHTTPClient | undefined;
    try {
      ipfs = create({
        url: "https://ipfs.infura.io:5001",

      });
    } catch (error) {
      console.error("IPFS error ", error);
      ipfs = undefined;
    }
    console.log(ipfs)
    const added = await ipfs?.add(file)
    console.log(added)
  }

  const handleColorPicker = (anchor: boolean) => {
    setShowColorPicker(anchor)
  }
  const handleVisibleChange = (newVisible: boolean) => {
    setShowColorPicker(newVisible)
  }

  const content = (
    <div>
      <SketchPicker onChange={handleChangeColor} color={color} />
    </div>
  )
  let cardStyle = {
    background: 'cadetblue',
  }

  const typeList = {
    rectStyle: {},
    eightBorder: {clipPath: 'polygon(75px 0, calc(100% - 75px) 0, 100% 75px,  100% calc(100% - 75px), calc(100% - 75px) 100%, 75px 100%, 0 calc(100% - 75px), 0 75px)'},
    sixBorder: {clipPath: 'polygon(90px 0, calc(100% - 90px) 0, 100% 50%,  100% calc(100% - 50%), calc(100% - 90px) 100%, 90px 100%, 0 calc(100% - 50%), 0 50%)'},
    oval: {borderRadius: '202.5px'},
    circleCorner: {borderRadius: '60px'},
    rightCorner: {clipPath: 'polygon(0 0, calc(100% - 120px) 0, 100% 90px,  100% 100%, 100% 100%, 0 100%, 0 calc(100% - 50%), 0 50%)'},
    leftCorner: {clipPath: 'polygon(120px 0, 100% 0, 100% 90px,  100% 100%, 100% 100%, 0 100%, 0 calc(100% - 50%), 0 90px)'}
  } as any
  
  useEffect(() => {
    console.log(props.location.query.type)
  }, [props.location.query.type])
  return (
    <div className='modify-page'>
      <div className='modify-left'>
        <div className='top-bar'>
          <div className='text-center'><img className='cursor-pointer' src={arrow} alt="" /></div>
          <div className='text-center relative'>
              <Popover 
                content={content} 
                title="Color Picker"
                trigger="click"
                visible={showColorPicker}
                onVisibleChange={handleVisibleChange}
                placement="bottom">
                  <div className='flex cursor-pointer' onClick={() => handleColorPicker(true)} style={{justifyContent: 'center', alignItems: 'center'}}>
                      <div className='bg-preview mr-4' style={{backgroundColor: color}}></div>
                      <span className='text-lg'><DownOutlined /></span>
                  </div>
              </Popover>
          </div>
          <div className='cursor-pointer text-center'><img className='cursor-pointer' src={text} alt="" /></div>
        </div>
        <div className='flex mt-16 mb-32'>
          <RectButton btnText={'Set to user editable'} type={'freeStyle'} style={{marginRight: '120px'}} />
          <div style={{marginLeft: '120px'}} className='btn-wrap'><RectButton btnText={'Allow user to add material'} type={'freeStyle'} /></div>
        </div>
        <div className='outer-container'>
          <div id='draw' style={{padding: '20px'}}>
            <div 
              className='template-card-container' 
              id='card-dom'
              style={{
                ...typeList[props.location.query.type], 
                backgroundImage: `url(${require('../../assets/images/blue.png')})`}}>
                  <div className='text-center pt-4 text-white ft-s-36'>Run Run Run</div>
                  <div className='text-center ft-s-145 text-white'>1213</div>
                  <div className='flex'>
                    <img src={rLogo} alt="" />
                    <div className='text-white ft-s-32 w-353 ml-2'>RaceNumber Marathon 2024</div>
                  </div>
            </div>
          </div>
        </div>
        <Button onClick={draw}>draw</Button>
      </div>
      <div>
        <img src={imageUrl} alt="" />
      </div>
    </div>
  );
}
