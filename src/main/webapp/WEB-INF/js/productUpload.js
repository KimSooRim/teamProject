
$('#postgu').change(function() {
	let gu = $(this).val();
	console.log(gu);
	
	$.ajax({
		url : 'address',
		data: { 
			gu : gu
			},
		method : 'POST',
		
		success: function(res) {
			console.log('요청성공');
			console.log(res);
			let dongList = res.split(' ');
			dongList.pop();
			console.log(dongList);
			
			for(dong of dongList) {
				$('#postdong').append(
						$('<option>').prop({
                            innerHTML: dong
                        })
                        );
			}
			
		},
		error: e => { 
			  console.log(e.status + ': ' + e.statusText); 
			  
			  }			
	});
	
	});

/*
$('#postgu').change(function() {
	console.log("fffff");
	let gu = $(this).val();
	//$('#postdong').empty();
	console.log(gu);
	$.ajax({
         url : "dongselect",
         data : {
            gu : gu
         },
         method : "POST",
         success : function(data) {
            console.log("성공");
            let donglist = data.split(" ");
            donglist.pop();
            //console.log(donglist);
            for(dong of donglist){
               //console.log(dong);
               $('#dong_select').append(
                          $('<option>').prop({
                              innerHTML: dong
                          })
                   );
            }
         },
         error : function(data, status, error) {

            console.log("에러");
         },
         complete : function(data) {
            console.log("완료");
         }
      });
});
*/
/*
const selectRequest = new XMLHttpRequest();
function select() {
	let url = '/address';
	selectRequest.open('POST', url, true)
	selectRequest.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded');
	let gu = document.getElementById('postgu').value;
	// console.log(gu)
	selectRequest.send('gu='
			+ encodeURIComponent(document.getElementById('postgu').value));
	selectRequest.onreadystatechange = selectProcess;
	console.log(gu);
}

function selectProcess() {
	if (selectRequest.readyState == 4 && selectRequest.status == 200) {
		// console.log(selectRequest.responseText)
		let obj = eval('(' + selectRequest.responseText + ')');
		// console.log(obj);
		let result = obj.res;

		let sel = document.getElementById('postdong');
		console.log(sel);
		sel.innerHTML = '<option>선택</option>';
		for (let i = 0; i < result.length; i++) {
			let opt = document.createElement("option")
			sel.innerHTML += '<option>' + result[i][0].dong + '</option>'
			// sel.innerHTML = result[i][0].dong
			console.log(result[i][0].dong);
		}
	}
}

/*
 $.ajax({ 
	 url : '/address', 
	 method: 'post', 
	 asyn: false,
	 data: { gu : gu },
	 success : function(result){ 
		 console.log('요청성공'); 
		 console.log(typeof result);
		 console.log(result); 
		 // let obj = eval('(' + result + ')');
		 // console.log(obj);
	  }, 
	  error: e => { 
		  console.log(e.status + ': ' + e.statusText); 
		  }
	  });
 */
