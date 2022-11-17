import {View, Text, StyleSheet} from 'react-native';
import React from 'react';
import {Table, Row, Rows} from 'react-native-table-component';

const CustomTab = ({HeadTable, DataTable}) => {
  return (
    <View style={styles.container}>
      <Table>
        <Row
          data={HeadTable}
          style={styles.HeadStyle}
          textStyle={styles.TableText}
        />
        <Rows
          data={DataTable}
          style={styles.TableCor}
          textStyle={styles.TableText}
        />
      </Table>
    </View>
  );
};


const styles = StyleSheet.create({
  container: {
    padding: 18,
    paddingTop: 35,
    backgroundColor: '#1E222D',
    color: "white",
    justifyContent:"center",
    tintColor:"white",
    //alignItems:"center",
  },
  HeadStyle: {
    alignContent: 'center',
    justifyContent:"center",
    alignItems:"center",
    backgroundColor: '#10131A',
    tintColor:"white",
  },

  TableCor: {
    alignContent: 'center',
    justifyContent:"center",
    alignItems:"center",
    tintColor:"white",
  },

  TableText: {
    margin: 5,
    color: "white",
    tintColor:"white",
    justifyContent:"center",
    alignItems:"center",
    paddingLeft:10,
    margin:15,
  },
});

export default CustomTab;
