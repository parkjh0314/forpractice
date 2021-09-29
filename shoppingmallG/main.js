// 아이템 배열 생성
const items = [
    {
        "type":"tshirt",
        "gender":"male",
        "size":"large, midium, small",
        "color":"blue",
        "image":"imgs/blue_t.png"
    },
    {
        "type":"tshirt",
        "gender":"male",
        "size":"large, midium, small",
        "color":"yellow",
        "image":"imgs/yellow_t.png"
    },
    {
        "type":"tshirt",
        "gender":"male",
        "size":"large, midium, small",
        "color":"pink",
        "image":"imgs/pink_t.png"
    },
    {
        "type":"tshirt",
        "gender":"female",
        "size":"large, midium, small",
        "color":"blue",
        "image":"imgs/blue_t.png"
    },
    {
        "type":"tshirt",
        "gender":"female",
        "size":"large, midium, small",
        "color":"yellow",
        "image":"imgs/yellow_t.png"
    },
    {
        "type":"tshirt",
        "gender":"female",
        "size":"large, midium, small",
        "color":"pink",
        "image":"imgs/pink_t.png"
    },
    {
        "type":"pants",
        "gender":"male",
        "size":"large, midium, small",
        "color":"pink",
        "image":"imgs/pink_p.png"
    },
    {
        "type":"pants",
        "gender":"male",
        "size":"large, midium, small",
        "color":"blue",
        "image":"imgs/blue_p.png"
    },
    {
        "type":"pants",
        "gender":"male",
        "size":"large, midium, small",
        "color":"yellow",
        "image":"imgs/yellow_p.png"
    },
    {
        "type":"pants",
        "gender":"female",
        "size":"large, midium, small",
        "color":"pink",
        "image":"imgs/pink_p.png"
    },
    {
        "type":"pants",
        "gender":"female",
        "size":"large, midium, small",
        "color":"yellow",
        "image":"imgs/yellow_p.png"
    },
    {
        "type":"pants",
        "gender":"female",
        "size":"large, midium, small",
        "color":"blue",
        "image":"imgs/blue_p.png"
    },
    {
        "type":"skirt",
        "gender":"female",
        "size":"large, midium, small",
        "color":"blue",
        "image":"imgs/blue_s.png"
    },
    {
        "type":"skirt",
        "gender":"female",
        "size":"large, midium, small",
        "color":"yellow",
        "image":"imgs/yellow_s.png"
    },
    {
        "type":"skirt",
        "gender":"female",
        "size":"large, midium, small",
        "color":"blue",
        "image":"imgs/pink_s.png"
    }
]

// 클릭이벤트가 일어났을 때 
const onClickItem = (event) => {

    $itemLine.innerHTML = null; //태그 비우기

    let target = event.target;
    const clickItem = target.id.substring(0,target.id.length-1); //클릭이벤트가 일어난 태그의 아이디값을 가져와 가공

    items.forEach(item => {
        if(clickItem ==='logo') {
            showItem(item);
        }
        else if (item.type == clickItem || item.color == clickItem) {
            showItem(item);
        }
    });
}

// 아이템 정보를 태그에 추가하여 화면에 출력
const showItem = (item) => {
    
    let itemList = document.createElement('li'); //새로운 li태그 만들기

    let imgTag = document.createElement('img'); //이미지태그 생성
    imgTag.setAttribute('src', item.image); //이미지태그 설정
    imgTag.setAttribute('class', 'itmeImage')
    imgTag.alt = 'image';
    itemList.appendChild(imgTag); //생성한 li태그에 이미지태그를 자식태그로 넣음

    let itemDescription = item.gender + ' / ' + item.size;
    let wrapItemDesc = document.createElement('span'); // span태그생성
    wrapItemDesc.setAttribute('class', 'itemDesc');
    let itemDesc = document.createTextNode(itemDescription); // li 태그에 텍스트를 자식으로 넣음
    wrapItemDesc.appendChild(itemDesc);

    itemList.appendChild(wrapItemDesc);

    $itemLine.appendChild(itemList); // li태그를 $itemLine 태그의 자식으로 넣음

}

// 필터 버튼 클릭 시
const goFilter = (event) => {
    const $showItem = document.querySelectorAll('ul.itemLine>li');
    const gender = event.target.id.substring(0,event.target.id.length-1);
    const arr = [];
    $showItem.forEach(item => {
        arr.push(item.lastElementChild.textContent.indexOf(gender));
        item.style.display = '';
    });
    if(gender == 'male'){
        $showItem.forEach(function(item, index) {
            if (arr[index] != 0) {
                item.style.display = 'none';
            }
        });
    } else if(gender == 'female'){
        $showItem.forEach(function(item, index) {
            if (arr[index] == -1) {
                item.style.display = 'none';
            }
        });
    }
}

const $itemLine = document.querySelector(".itemLine");
const $logoB = document.querySelector('#logoB').addEventListener('click', onClickItem);
const $tshirtB = document.querySelector('#tshirtB').addEventListener('click', onClickItem);
const $pantsB = document.querySelector('#pantsB').addEventListener('click', onClickItem);
const $skirtB = document.querySelector('#skirtB').addEventListener('click', onClickItem);
const $blueB = document.querySelector('#blueB').addEventListener('click', onClickItem);
const $yellowB = document.querySelector('#yellowB').addEventListener('click', onClickItem);
const $pinkB = document.querySelector('#pinkB').addEventListener('click', onClickItem);
const $maleB = document.querySelector('#maleB').addEventListener('click', goFilter);
const $femaleB = document.querySelector('#femaleB').addEventListener('click', goFilter);

// 첫화면 로딩 시 실행 (모든 아이템 목록 보여주기)
items.forEach(item => {
    showItem(item);
});
