import {View, Text, SafeAreaView, StyleSheet ,ScrollView} from 'react-native';
import React , { useState, useEffect } from 'react';
import CustomTab from '../../components/CustomTab/CustomTab';
import CustomDateTime from '../../components/CustomDateTime';
import CustomButton from '../../components/CustomButton';
import SyncStorage from 'sync-storage';
import axios from 'axios';
import DatePicker from 'react-native-date-picker';

const WorkingTimesScreen = ({props}) => {

  const [ data , setData ] = useState([])
  SyncStorage.set('start_time', "2022-11-11 00:00:00");
  SyncStorage.set('end_time', "2022-11-12 00:00:00");

  useEffect(() => {
    getWorkingTimes();
  },[])

  function getDateTime(start, end){
    SyncStorage.set('start_time', JSON.stringify(start).replace('"','').replace('"',''));
    SyncStorage.set('end_time', JSON.stringify(end).replace('"','').replace('"',''));
  }



  async function getWorkingTimes () {
    let token = SyncStorage.get('token');
    let userID = Number(SyncStorage.get("userID"))
    let config = {headers: {Authorization: `Bearer ${JSON.parse(token)}`}};

    await axios
      .get('http://localhost:4000/api/workingtimes/'+userID.toString()+"/"+ SyncStorage.get("start_time")+"/"+SyncStorage.get("end_time"),config )
      .then(async res => {
        //console.log(res.data.data[0])
        //createtableworkingtimes(res.data.data)
        //SyncStorage.set('lastClock', res.data.data[0]);
        //setLastClock( res.data.data[0].time.replace('Z', '').split('T'))
        var listWt = [];
        for (var i of res.data.data){
          listWt.push([i.start.replace('Z', '').split('T'), i.end.replace('Z', '').split('T')]);
        }
        setData(listWt);
      });
  }


  //console.log(props);
  return (

    <SafeAreaView style={styles.root}>

      <CustomDateTime func = {getDateTime}  />
      <CustomButton
      onPress={getWorkingTimes}
      text="Search"
      type="Search"
      />
      <ScrollView style={styles.scrollstyle}>
        <CustomTab
          HeadTable={["start","end"]}
          DataTable={data}
        />
      </ScrollView>
    </SafeAreaView>
  );
};





const styles = StyleSheet.create({
  root: {
    backgroundColor: '#1E222D',
    flex: 1,
    justifyContent: 'center',
  },
  dt: {
    backgroundColor: 'white',
  },
  scrollstyle :{
    marginTop:"5%",
    marginBottom: "10%",
    backgroundColor: "transparent",
  },
});

export default WorkingTimesScreen;
