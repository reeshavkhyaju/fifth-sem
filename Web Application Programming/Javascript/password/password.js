const $ = id => document.getElementById(id);
const username = $('username'), email = $('email'), pwd = $('password'), cpwd = $('confirm-password');

const validEmail = v => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);

$('submit-button').addEventListener('click', e => {
  e.preventDefault();
  let ok = true;
  $('username-error').innerText = username.value.trim() ? '' : 'Enter username' && (ok = false);
  $('email-error').innerText = validEmail(email.value.trim()) ? '' : 'Enter valid email' && (ok = false);
  $('password-error').innerText = pwd.value.length >= 6 ? '' : 'Min 6 chars' && (ok = false);
  $('confirm-password-error').innerText = cpwd.value === pwd.value ? '' : 'Passwords differ' && (ok = false);
  if (!ok) return;
  localStorage.setItem('userData', JSON.stringify({ username: username.value.trim(), email: email.value.trim() }));
  $('form-message').innerText = 'Submitted';
});

document.addEventListener('DOMContentLoaded', () => {
  const s = localStorage.getItem('userData');
  if (!s) return;
  try {
    const u = JSON.parse(s);
    if (u.username) username.value = u.username;
    if (u.email) email.value = u.email;
  } catch (e) {}
});
