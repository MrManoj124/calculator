let input = document.getElementById('inputbox');
let buttons = document.querySelectorAll('button');

let string = "";
let arr = Array.from(buttons);
arr.forEach(button => {
    button.addEventListener('click', (e) =>{
        if (e.target.innerHTML =='='){
            try {
                string = eval(string);
            } catch (error) {
                string = "Error";
            }
            input.value=string;
        }
        else if(e.target.innerHTML=='Ac'){
            string = "";
            input.value = string;
        }
        else if(e.target.innerHTML=='DEL'){
            string=string.substring(0, string.length -1)
            input.value=string;
        }
        else{
            string += e.target.innerHTML;
            input.value=string;
        }
    })
})