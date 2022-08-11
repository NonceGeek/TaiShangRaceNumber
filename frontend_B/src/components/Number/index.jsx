import React from 'react'
import styles from "./index.less"
import Vectoc from "@/assets/images/Vector.png"
import dayjs from 'dayjs'

export default function index({title,number,topic,price,time, minted, issues}) {
    const intervalTime = (startTime,endTime) => {
        // var timestamp=new Date().getTime(); //计算当前时间戳
        var timestamp = (Date.parse(new Date()))/1000;//计算当前时间戳 (毫秒级)
         var date1 = ""; //开始时间
        if(timestamp<startTime){
            date1=startTime;
        }else{
            date1 = timestamp; //开始时间
        }
        var date2 = endTime; //结束时间
        // var date3 = date2.getTime() - date1.getTime(); //时间差的毫秒数
        var date3 =  (date2- date1)*1000; //时间差的毫秒数
        //计算出相差天数
        var days = Math.floor(date3 / (24 * 3600 * 1000));
        //计算出小时数
    
        var leave1 = date3 % (24 * 3600 * 1000); //计算天数后剩余的毫秒数
        var hours = Math.floor(leave1 / (3600 * 1000));
        //计算相差分钟数
        var leave2 = leave1 % (3600 * 1000); //计算小时数后剩余的毫秒数
        var minutes = Math.floor(leave2 / (60 * 1000));
    
        //计算相差秒数
    
        var leave3 = leave2 % (60 * 1000); //计算分钟数后剩余的毫秒数
        var seconds = Math.round(leave3 / 1000);
        // return   days + "天 " + hours + "小时 " + minutes + " 分钟" + seconds + " 秒"
        return   {
            days: days,
            hours: hours,
            minutes: minutes
        }
    }
  const today = dayjs()
  const remain = intervalTime(today/1000, time)
  console.log(remain)
  return (
    <div>
        <div className={styles.container}>
            <div className={styles.top}>
                <div className={styles.title}>
                    {title}
                </div>
                <div className={styles.number}>
                    {number}
                </div>
                <div className={styles.topic}>
                    <img src={Vectoc} alt="" />
                    {topic}
                </div>
            </div>
            <div className={styles.bottom}>
                <div className={styles.price}>
                    <span>{topic}</span>
                </div>
                <div className={styles.time}>
                    <div>
                        <div className='ft-s-24 text-dark-blue'>{remain.days}</div>
                        <div>days</div>
                    </div>
                    <div className='text-center'>
                        <div className='ft-s-24 text-dark-blue'>{remain.hours}</div>
                        <div>hours</div>
                    </div>
                    <div className='text-right'>
                        <div className='ft-s-24 text-dark-blue'>{remain.minutes}</div>
                        <div>mins</div>
                    </div>
                </div>
                <div className='ft-s-24 text-dark-blue'>
                    {minted}/{issues}
                </div>
            </div>
        </div>
    </div>
  )
}
