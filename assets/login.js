// Usuários permitidos
const USERS = {
  "admin": "1234",
  "marlenildo": "abcd"
};

// Verifica se já está logado
function isLoggedIn() {
  return localStorage.getItem("loggedUser") !== null;
}

// Atualiza navbar dinamicamente
function updateNavbar() {
  let nav = document.querySelector(".navbar-nav");
  if (!nav) return;

  // Remove links antigos
  document.querySelectorAll(".private-link").forEach(el => el.remove());
  document.querySelectorAll(".logout-link").forEach(el => el.remove());

  if (isLoggedIn()) {
    // Book
    let book = document.createElement("li");
    book.className = "nav-item private-link";
    book.innerHTML = `<a class="nav-link" href="book.html">Book</a>`;
    nav.appendChild(book);

    // Ferramentas
    let ferramentas = document.createElement("li");
    ferramentas.className = "nav-item private-link";
    ferramentas.innerHTML = `<a class="nav-link" href="ferramentas.html">Ferramentas</a>`;
    nav.appendChild(ferramentas);

    // Logout
    let logout = document.createElement("li");
    logout.className = "nav-item logout-link";
    logout.innerHTML = `<a class="nav-link" href="#" onclick="doLogout()">Logout</a>`;
    nav.appendChild(logout);

    // Esconde link de login
    let loginLink = document.querySelector('a[href="login.html"]');
    if (loginLink) loginLink.parentElement.style.display = "none";

  } else {
    // Mostra link de login
    let loginLink = document.querySelector('a[href="login.html"]');
    if (loginLink) loginLink.parentElement.style.display = "block";
  }
}

// Função de login
function doLogin() {
  let user = document.getElementById("user").value;
  let pass = document.getElementById("pass").value;
  let msg = document.getElementById("login-msg");

  if (USERS[user] && USERS[user] === pass) {
    localStorage.setItem("loggedUser", user);
    msg.style.color = "green";
    msg.innerText = "Login realizado com sucesso!";
    setTimeout(() => window.location.href = "index.html", 1000);
  } else {
    msg.innerText = "Usuário ou senha incorretos!";
  }
}

// Logout
function doLogout() {
  localStorage.removeItem("loggedUser");
  window.location.href = "index.html";
}

// Atualiza navbar ao carregar
document.addEventListener("DOMContentLoaded", updateNavbar);
