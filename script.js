// Adicione seu JavaScript interativo aqui, se necessário.
// Por exemplo, para rolagem suave para as seções:
document.querySelectorAll('nav a').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();

        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});

