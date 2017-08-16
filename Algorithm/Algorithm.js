//插入排序
var array = [5, 6, 3, 1, 8, 7, 2, 4];
console.log(array);
var insetArr = insertSort(array);
console.log('insetArray = ' + insetArr);
function insertSort(arr){
	var tmp;
	for (var i = 1; i < arr.length; i++) {
		tmp = arr[i];
		for (var j = i; j >= 0;j--) {
			if (arr[j-1]>tmp) {

				arr[j] = arr[j-1];
			}else{

				arr[j] = tmp;
				break;
			}
		}
		
	}
	return arr;
}