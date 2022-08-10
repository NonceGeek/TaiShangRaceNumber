import React,{useEffect,useState} from 'react'
import styles from "./index.less"

import {user} from "@/utils/user"

import Header from "@/components/Header"
import Brand from "@/components/Brand"
import Info from "@/components/Info"
import Button from "@/components/Button"
import User from "@/components/User"
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
  return (
    <div>
      <div className={styles.main}>
        <header>
          <Header></Header>
        </header>
        <main>
          <div className={styles.left}>
            <Brand {...brand} number={number}></Brand>
            <div className={styles.users}>
                {user.map((user,index)=>{
                    return (
                        <User key={index} {...user}></User>
                    )
                })}
            </div>
            <div className={styles.more}>{'More >'}</div>
          </div>
          <div className={styles.right}>
            <div className="mb-8">
              <Info topic={gameName} time={timestamp}></Info>
            </div>
            <div className="flex justify-center mt-14">
              <Button content="3D-Printed RaceNumber" ></Button>
            </div>
            <div className="flex justify-center mt-14">
                <Button content="Rent"></Button>
                <Button content="Sell"></Button>
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}
