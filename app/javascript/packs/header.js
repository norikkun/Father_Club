const header = document.querySelector('header');
let prevY = window.scrollY; 

window.addEventListener('scroll', () => {
  const currentY = window.scrollY;
  if (currentY < prevY) { 
    header.classList.remove('hidden'); 
  } else { 
    if (currentY > 0) {
      header.classList.add('hidden'); 
    }
  }
  prevY = currentY; 
});