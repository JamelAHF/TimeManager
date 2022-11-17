import {View, Text, SafeAreaView, StyleSheet} from 'react-native';
import CustomButton from '../../components/CustomButton';
import React, {useEffect, useState} from 'react';
import axios from 'axios';
import SyncStorage from 'sync-storage';

const ClockScreen = () => {

  const [lastClock, setLastClock] = useState([]);

  async function clock() {
    let token = SyncStorage.get('token');
    let config = {headers: {'Authorization': `Bearer ${JSON.parse(token)}`}};
    var date = new Date();
    var currentTime = date.getFullYear()+'-'+('0'+(date.getMonth()+1)).slice(-2)+'-'+('0'+date.getDate()).slice(-2)+' '+('0'+date.getHours()).slice(-2)+':'+('0'+date.getMinutes()).slice(-2)+':'+('0'+date.getSeconds()).slice(-2);
    await axios.get("http://localhost:4000/api/clock/", config).then(async (res) => {
        let lastClock = res.data.data[0];
        setLastClock(currentTime.split(' '));
        if (lastClock && lastClock.status){
          await axios.post("http://localhost:4000/api/workingtimes/",{ "start": lastClock.time, "end": currentTime}, config);
          await axios.post("http://localhost:4000/api/clock", { "status": false, "time": currentTime}, config);
        } else {
          await axios.post("http://localhost:4000/api/clock/", {"status": true, "time": currentTime}, config);
        }
      });
  }

  async function getLastClock() {
    let token = SyncStorage.get('token');
    let config = {headers: {Authorization: `Bearer ${JSON.parse(token)}`}};
    await axios
      .get('http://localhost:4000/api/clock/', config)
      .then(async res => {
        //SyncStorage.set('lastClock', res.data.data[0]);
        setLastClock( res.data.data[0].time.replace('Z', '').split('T'))
      });
  }

  useEffect(() => {
    getLastClock();
  }, []);

  return (
    <SafeAreaView style={styles.root}>
      <View style={styles.lastClockBox}>
        <Text style={styles.lastClockText}>LAST CLOCK</Text>
        <View style={styles.dateHourBox}>
          <Text style={styles.dateHourText}>{lastClock[0]}</Text>
          <Text style={styles.dateHourText}>{lastClock[1]}</Text>
        </View>
      </View>
      <View style={styles.clkButton}>
        <CustomButton text="Clock" onPress={clock} type="Clock" />
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  root: {
    backgroundColor: '#1E222D',
    display: 'flex',
    flex: 1,
  },
  lastClockText: {
    fontWeight: 'bold',
    marginLeft: 20,
    fontSize: 30,
    color: '#FF6700',
    fontFamily: 'Cochin',
  },
  dateHourText: {
    fontSize: 30,
    color: 'white',
  },
  lastClockBox: {
    marginTop: 70,
    backgroundColor: '#10131A',
    borderRadius: 20,
    paddingBottom: 20,
    paddingTop: 20,
    marginLeft: 10,
    marginRight: 10,
  },
  dateHourBox: {
    marginTop: 20,
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  clkButton: {
    marginTop: 200,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

export default ClockScreen;
