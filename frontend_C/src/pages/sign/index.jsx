import React from 'react'
import styles from "./index.less"

import Rectangle from "@/assets/images/Rectangle.png"

import Header from "@/components/Header"
import Number from "@/components/Number"
import Info from "@/components/Info"
import Button from "@/components/Button";
export default function index(props) {
  return (
    <>
      <div className={styles.main}>
        <header>
          <Header></Header>
        </header>
        <main>
          <div className={styles.left}>
            <div className={styles.enter}>
              <p className={styles.text}>Enter number within 9999</p>
              <img src={Rectangle} alt="" />
            </div>
            <div className={styles.numbers}>
              <Number title="Run! Run! Run!" number="1213" topic="RaceNumber Marathon 2024" price={50} time={30}></Number>
              <Number title="Run! Run! Run!" number="1688" topic="RaceNumber Marathon 2024" price={50} time={26}></Number>
              <Number title="Run! Run! Run!" number="6666" topic="RaceNumber Marathon 2024" price={50} time={30}></Number>
              <Number title="Run! Run! Run!" number="6666" topic="RaceNumber Marathon 2024" price={50} time={30}></Number>
              <Number title="Run! Run! Run!" number="6666" topic="RaceNumber Marathon 2024" price={50} time={30}></Number>
            </div>
          </div>
          <div className={styles.right}>
            <div className="mb-8">
              <Info></Info>
            </div>
            <div className="flex justify-center">
              <Button content="Sign up" url="/choose"></Button>
            </div>
          </div>
        </main>   
      </div>
    </>
  )
}
