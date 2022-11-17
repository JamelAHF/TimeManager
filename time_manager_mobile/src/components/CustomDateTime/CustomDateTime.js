import React, { useEffect, useState } from 'react';
import { Text, useBoolean, Button } from '@react-native-material/core';
import DatePicker from 'react-native-date-picker';
import { TouchableOpacity, StyleSheet, View } from 'react-native';

const CustomDateTime = (props) => {

  // const [date, setDate] = useState(new Date());

  const [open, setOpen] = useState(false);
  const [dateStart, setDateStart] = useState(new Date());
  const [dateEnd, setDateEnd] = useState(new Date());
  const [isDateStart, setIsDateStart] = useState(false);

  useEffect(()=>{dateStart},[dateStart]); //dateStart stock la date de début
  useEffect(()=>{dateEnd},[dateEnd]); // dateEnd stock la date de fin
  props.func(dateStart,dateEnd);

  return (
   <>
  

  <View style={styles.box}>

    <TouchableOpacity

      title="Open"
      style={styles.button}

      onPress={() => {

        setOpen(true);
        setIsDateStart(true);

      }}>

      <Text style={styles.text} >Start date</Text>

    </TouchableOpacity>

    <TouchableOpacity
          
      title="Open"
      style={styles.button}

      onPress={() => {
        setOpen(true);
        setIsDateStart(false);

      }}>

      <Text style={styles.text} >End date</Text>

      </TouchableOpacity>

  </View>

  <DatePicker
    modal
    date={isDateStart ? dateStart : dateEnd}
    open={open}
    onConfirm={date => {
      setOpen(false);
      if (isDateStart) {
        setDateStart(date);
      }
      else {
        setDateEnd(date)
      }
      // console.log("date de début :" + dateStart + "/ " + date)
      // console.log("date de fin :" + dateEnd + "/" + date)
      // console.log(date);
    }}
    onCancel={() => {
      setOpen(false);
    }}
  />
  </>
  );
};

const styles = StyleSheet.create({
  button: {
    backgroundColor: '#FF6700',
    alignItems: "center",
    color: 'white',
    borderRadius: 10,
    height: 30,
    width: '40%',
    margin: "5%",
    justifyContent: "center",
  },

  text: {
    color: 'white',
    fontWeight: 'bold',
  },
  box: {
    flex: 1,
    flexDirection: "row",
  },
  title: {
    color: 'white',
    textAlign: 'center',
  },

});

export default CustomDateTime;