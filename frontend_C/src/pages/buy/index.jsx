import styles from "./index.less"
import React,{useState,useEffect} from 'react';
import {history} from "umi"
import Header from "@/components/Header"
import Brand from "@/components/Brand"
import Info from "@/components/Info"
import Button from "@/components/Button"
import { typeList } from '@/utils/typeList.js';
import {getAllGames, getGameByGameId, getGameByOwnerAddr, getMintedNFTList, getUserNFTs} from "../../../../flow/scripts"
import {createGame, createGameNFTTemplate, mintGameNFT, mintThemeNFT} from "../../../../flow/transactions"
export default function index(props) {
  const [number,setNumber] = useState()
  const [game,setGame] = useState({})
  useEffect(() => {
    const uid = props.location.query?.uid;
    const number = props.location.query?.number;
    if(uid){
      getGameByGameId(uid).then(item=>{
        setGame(item)
      })
    }
    if(number){
      setNumber(number)
    }
  },[])
  const {uid,gameName,timestamp,slogan,templateType,hostAddr} = game
  const brandInfo = {
    title: slogan,
    topic: gameName,
    type: templateType,
    img: {backgroundImage:'url(https://s1.ax1x.com/2022/08/07/vKVZuR.jpg)'},
  };
  const brand = {
    title: brandInfo.title,
    topic: brandInfo.topic,
    bg: {
      ...brandInfo.img,
      ...typeList[brandInfo.type],
    },
  };
  
  const theme = async ()=>{
    // await mintThemeNFT(hostAddr,uid,'black')
    history.push(`/deal?uid=${uid}&number=${number}`);

  }
  return (
    <div>
      <div className={styles.main}>
        <header>
          <Header></Header>
        </header>
        <main>
          <div className={styles.left}>
          <Brand {...brand} number={number}></Brand>
          </div>
          <div className={styles.right}>
            <div className="mb-8">
            <Info topic={gameName} time={timestamp}></Info>
            </div>
            <div className="flex justify-center">
              <Button content="Mint" mintTheme={number} theme={theme}></Button>
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}
