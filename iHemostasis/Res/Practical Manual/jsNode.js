var startX;
var startY;
var diffX;
var diffY;
var hypo;

function loadPage(page) {
    var	pNodes = document.getElementsByTagName("p");
    console.log("pLength : ", pNodes.length);
    for (var i = 0; i <	pNodes.length; i++) {
        
        if (pNodes[i].className != page) {
            pNodes[i].style.display = "none";
        }
        else {
            pNodes[i].style.display = "block";
            
            // Resize images herein
            var pImages = pNodes[i].getElementsByTagName("img");
            for (var j = 0; j < pImages.length; j++) {
                if(!pImages[j].classList.contains("android")){
                    pImages[j].style.width = 820;
                    pImages[j].style.height = pImages[j].naturalHeight * 65.1/100;
                }
            }
        }
    }
    var	yPos = document.getElementById("yPos");
    window.scrollTo(0, yPos.value);
}

function loadFigure(page) {
    var	pNodes = document.getElementsByTagName("p");
    for (var i = 0; i <	pNodes.length; i++) {
        if (pNodes[i].className != page) {
            pNodes[i].style.display = "none";
        }
        else {
            pNodes[i].style.display = "block";
            
            // Resize images herein
            var pImages = pNodes[i].getElementsByTagName("img");
            for (var j = 0; j < pImages.length; j++) {
                if(!pImages[j].classList.contains("android")){
                    pImages[j].style.width = 820;
                    pImages[j].style.height = pImages[j].naturalHeight * 65.1/100;
                }
            }
        }
    }
    // Save old offset
    var yPosOffset = window.pageYOffset;
    var	yPos = document.getElementById("yPos");
    yPos.value = yPosOffset;
    window.scrollTo(0, 0);
}

function initSwipe() {
    var	pNodes = document.getElementsByTagName("img");
    for (var i = 0; i <	pNodes.length; i++) {
        pNodes[i].addEventListener( 'touchstart' , touchStart , false );
        pNodes[i].addEventListener( 'touchend' , touchEnd , false );
        pNodes[i].addEventListener( 'touchmove' , touchMove , false );
    }
    
}

function touchStart(event) {
    diffX = 0;
    diffY = 0;
    
    startX = event.pageX;
    startY = event.pageY;
    //event.preventDefault();
}

function touchEnd(event) {
    //alert(hypo);
    /*
    if (diffX > 100||diffX < -100){
        this.click();
    }*/
    
    var yPosOffset = window.pageYOffset;
    var	yPos = document.getElementById("yPos");
    
    //alert(yPos.value)
    if (hypo > 300) {
        this.click();
        yPos.value = yPosOffset;
        hypo = 0;
    }
    //event.preventDefault();
    
}

function touchMove(event) {
    var a;
    var b;
    a = event.pageX - startX;
    b = event.pageY - startY;
    var c = calcHypotenuse(a,b);
    diffX = a;
    diffY = b;
    hypo=c;
}

function calcHypotenuse(a,b) {
    return Math.sqrt(a*a,b*b);
}
