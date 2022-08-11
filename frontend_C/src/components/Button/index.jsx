import React from 'react';
import styles from './index.less';
import { history } from 'umi';
export default function index(props) {
  const { content ,url,mintNFT,mintTheme} = props;
  const mint = (number)=>{
    props.mint(number)
  }
  const theme = (number)=>{
    props.theme(number)
  }
  return (
    <div onClick={()=>{
      mintNFT?
      mint(mintNFT):mintTheme?theme(mintTheme):
      history.push(url)
    }}>
      <div className={styles.button}>
        <div className={styles.buttonLeft}></div>
        <div className={styles.buttonMiddle}>
          <div>{content}</div>
        </div>
        <div className={styles.buttonRight}></div>
      </div>  
    </div>
  );
}
