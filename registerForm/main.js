// ============================ 태그에 속성 추가 ========================================== //
document.querySelector('input[name="title"]').setAttribute('id', 'title'); // #title

document.querySelectorAll('input[type="radio"]').forEach(item => { //radio button grouping
    item.setAttribute('name', 'fee');
});

document.querySelector('select').setAttribute('name', 'region'); // #region

const $region = document.querySelectorAll('select[name="region"] option'); // set vaule for select option
const regionData = ['','서울','경기','인천','대전','강원','충남','충북','경남','경북','전남','전북']
$region.forEach(function(item,index) {
    item.value = regionData[index];
});

const positionData = ['개발자','팀장','과장','부장'];

document.querySelectorAll('input[type="checkbox"]').forEach(function(item, index) { // checkbox grouping & set default value
    item.setAttribute('name', 'position');
    item.value = positionData[index];
});


// ================== 1. 테이블 숨기기 ===================== //
const $table_responsive = document.querySelector('div.table-responsive>table');
    
$table_responsive.style.display = 'none';

//============================ 2. 제목 200자 제한 및 글자수 확인 ============================ //

const $title = document.querySelector('#title');
const $byteCnt = $title.nextElementSibling;
const $fee = document.querySelectorAll('input[name="fee"]');

let title; // 제목
let byteCnt;
let byteLimit = 200;

// 글자수 확인 및 제한 함수
const goCheckbyte = () => {
    title = $title.value;
    byteCnt = 0;

    for(let i = 0; i<title.length; i++){
        if (escape(title.charAt(i)).length >= 6) {
            byteCnt++;
        }
        byteCnt++;
    }

    if(byteCnt > byteLimit) {
        alert('주제는 200글자내로 입력해주세요.');
        const overByte = byteLimit - byteCnt; //초과byte수
        let overCnt = 0; //초과글자수
        // console.log('overByte'+overByte);
        let reverseTitle = title.slice(overByte).split('').reverse().join(''); //초과 글자수대로 뒤에서부터 잘라서 뒤집기
        // console.log('reverse : '+reverseTitle+' length : '+reverseTitle.length);

        for(let i = 0; i<reverseTitle.length; i++){
            if (escape(reverseTitle.charAt(i)).length >= 6) {
                i++; //한글이면 i를 두번올림
                overCnt++;
            } else { 
                overCnt++ ; 
            }
        }
        // console.log('count2 : '+count2);
        // console.log('title길이: '+title.length);
        title = title.slice(0,title.length-overCnt); //제목에 입력된 글자에서 초과된 글자수빼고 잘라내기
        $title.value = title;
        // console.log('title : '+title);
    }
    // console.log(title);
    // console.log(byteCnt);
    $byteCnt.textContent = '( '+byteCnt+' / '+byteLimit+' )';
}

// ============================== 2. 등록버튼 클릭 시 필수값 입력확인 =================================== //

let fee = '';
let region = '';
let position;
let attached;

// 필수값 입력 여부 확인
const goCheckRegister = () => {
    let positionArr = [];
    let titleFlag = false;
    let feeFlag = false;
    let regionFlag = false;
    let positionFlag = false;

    const $checkedFee = document.querySelector('input[name="fee"]:checked'); // 선택된 참가비
    const $checkedRegion = document.querySelector('select[name="region"] option:checked'); //선택된 지역
    const $position = document.querySelectorAll('input[name="position"]:checked'); // 선택된 직책

    if(title) {
        titleFlag = true;
    }
    
    if($checkedFee) {
        $fee.forEach(function(item,index) {
            if($checkedFee == item) {
                if(index == 0) {
                    fee = '유료';
                } else if(index == 1) {
                    fee = '무료';
                }
            }
        });
        feeFlag = true;
    }

    if($checkedRegion.value) {
        region = $checkedRegion.value;
        regionFlag = true;
    }

    if($position.length > 0){
        $position.forEach(item => {
            positionArr.push(item.value);
        });
        position = positionArr.join(',');
        positionFlag = true;
    }

    if(titleFlag && feeFlag && regionFlag && positionFlag) {
        goRegister();
        document.querySelectorAll('a.ico-trash').forEach(item => {
            item.setAttribute('href', '#;');
            item.addEventListener('click', goDelete);
        });
        $table_responsive.style.display = '';
        goReset();
    } else {
        alert('필수값(*표시)을 모두 입력해주세요!');
    }
}

// ================================== 3. 등록 ==================================== //

// 등록이벤트
const goRegister = () => {
    const $table = document.querySelector('div.table-responsive>table');
    const newLine = document.createElement('tr');
    const data = [title, position, region, fee, attached, ''];
    let newData;

    data.forEach(function(item, index){
        newData = document.createElement('td');
        if(index < 4) {
            newData.textContent = data[index];
            if(index == 0) {
                newData.setAttribute('class', 'title');
            }
        } else if(index > 3 && index < 6) {
            if(index == 4 && item){
                newData.innerHTML = '<a class="ico-down" href="#;"></a>';
            }
            if(index == 5){
                newData.innerHTML = '<a class="ico-trash" href="#;"></a>';
            }
        }
        newLine.appendChild(newData);
    });

    $table.lastElementChild.appendChild(newLine);
}

// 파일첨부 이벤트
const goFileUpload = () => {
    attached = false;
    if($file.files.length > 0) {
        attached = true;
        document.querySelector('div.attached').textContent = $file.files[0].name;
    }
}

// 입력내용 초기화 이벤트
const goReset = () => {
    $title.value = ''; //주제 초기화
    document.querySelector('input[name="fee"]:checked').checked = false; //참가비 초기화
    document.querySelector('select').value = ''; // 지역 초기화
    document.querySelectorAll('input[name="position"]:checked').forEach(item => { // 직책 초기화
        item.checked = false;
    });
    document.querySelector('div.attached').textContent = '파일첨부';
    attached = false; // 첨부 초기화
}

// ================================ 5.삭제 ================================= //
// 행 삭제 이벤트
const goDelete = (event) => {
    event.target.parentElement.parentElement.remove();
}


const $file = document.querySelector('input[type="file"]');
const $btnRegister = document.querySelector('#btnRegister');

$btnRegister.addEventListener('click', goCheckRegister);
$title.addEventListener('keyup', goCheckbyte);
$file.addEventListener('change', goFileUpload);