function post (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("input", () => {
    const inputPrice = itemPrice.value;
    const commission = inputPrice * 0.1;
    const profit = inputPrice - commission;
    const addTaxPrice = document.getElementById("add-tax-price");
    const profitArea = document.getElementById("profit");
    addTaxPrice.innerHTML = `${ Math.floor(commission) }`;
    profitArea.innerHTML = `${ Math.floor(profit) }`;
  });
 };
 
 window.addEventListener('load', post);