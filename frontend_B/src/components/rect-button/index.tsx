import './index.less'
import React from 'react';
import { Button} from "antd"
import { history } from 'umi'

const btnStyles = {
  rect: {
    fontSize: '24px',
    fontWeight: '700',
    color: 'white',
    padding: '0 23px',
    background: 'linear-gradient(180deg, #0048BD 0%, #0027A4 100%)',
    height: '70px',
    width: '100%'
  },
  corner: {
    fontSize: '24px',
    fontWeight: '700',
    color: 'white',
    padding: '0 23px',
    background: 'linear-gradient(180deg, #0048BD 0%, #0027A4 100%)',
    borderRadius: '10px',
    height: '70px'
  },
  freeStyle: {
    fontSize: '24px',
    fontWeight: '700',
    color: 'white',
    padding: '0 23px',
    background: 'linear-gradient(180deg, #0048BD 0%, #0027A4 100%)',
    borderRadius: '10px',
    width: '263px',
    height: '80px'
  }
} as any

export default class CustomTitle extends React.Component<any>{

    constructor(props: any) {
      super(props);
      console.log(props)
    }

    click = () => {
      if (this.props.onClick) {
        this.props.onClick('click')
      } else {
        history.push({
          pathname: '/edit-page'
        })
      }
    }
    
    render() {
      return (
        <div className=''>
          <Button onClick={this.click} style={btnStyles[this.props.type]}><span className='span' style={{transform: this.props.type === 'rect' ? 'skew(30deg)' : ''}}>{this.props.btnText}</span></Button>
        </div>
      )
    }
  }