import React,{useState,useEffect} from 'react';
import styles from './index.less';
import {history} from "umi"
import Rectangle from '@/assets/images/Rectangle.png';
import Group from '@/assets/images/Group.png';
import Price from '@/assets/images/Price.png';

import Header from '@/components/Header';
import Card from '@/components/Card';
import Button from '@/components/Button';

import {getAllGames, getGameByGameId, getGameByOwnerAddr, getMintedNFTList, getUserNFTs} from "../../../../flow/scripts"
import {createGame, createGameNFTTemplate, mintGameNFT, mintThemeNFT} from "../../../../flow/transactions"

export default function index(props) {
  const [RaceNumber,setRaceNumber] = useState("请选择")
  const [mintedList,setMintedList] = useState([])
  const [game,setGame] = useState({})
  useEffect(() => {
    const uid = props.location.query?.uid;
    if(uid){
      getGameByGameId(uid).then(item=>{
        setGame(item)
        getMintedNFTList(item.hostAddr,uid).then(item=>{
          setMintedList(item)
        })
      })
    }
  },[])
  const {issues,hostAddr,uid} = game
  const cards = [];
  for (let i = 0; i < issues; i++) {
    if(mintedList.indexOf(i) == -1){
      cards.push({ number: String(i).padStart(4,'0'), status: true });
    }else{
      cards.push({ number: String(i).padStart(4,'0'), status: false });
    }
  }
  const getNumber = ({number})=>{
    setRaceNumber(number)
  }
  const mint = async (number)=>{
    const mintNumber = Number(number)
    if(isNaN(mintNumber)){
      alert("请选择号码")
    }else{
      const x = await mintGameNFT(hostAddr,uid,number)
      history.push(`/edit?uid=${uid}number=${RaceNumber.padStart(4,'0')}`)
    }
  }
  return (
    <div>
      <div className={styles.main}>
        <header>
          <Header></Header>
        </header>
        <main>
          <div className={styles.left}>
            <div className={styles.enter}>
              <div className={styles.text}>
                <input type="text" placeholder="Enter number within 9999" />
                <img src={Group} alt="" />
              </div>
              <img src={Rectangle} alt="" />
            </div>
            <div className={styles.cards}>
              {cards.map((card) => {
                return <Card key={card.number} number={card.number} status={card.status} getNumber={getNumber}></Card>;
              })}
            </div>
          </div>
          <div className={styles.right}>
            <div className={styles.gameName}>RaceNumber Marathon</div>
            <div className={styles.no}>NO.</div>
            <div className={styles.number}>{RaceNumber?RaceNumber:'0000'}</div>
            <div className={styles.mint}>
              <div className={styles.price}>
                Price
                <img src={Price} alt="" />
                <span>50</span>
              </div>
              <Button content="Mint" mintNFT={RaceNumber} mint={mint}></Button>
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}
