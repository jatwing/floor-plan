const container = document.querySelector('.daejaContinuousSelectedPage');
const firstDiv = container.querySelector('div');
const images = firstDiv.querySelectorAll('img.gwt-Image');

function downloadImage(img, index = 1) {
  const url = img.currentSrc || img.src;
  if (!url) return;
  let filename = img.alt ? img.alt.replace(/[^\w.-]/g, '_') : `image_${index+1}`;
  const extMatch = url.match(/\.\w+$/);
  filename += extMatch ? extMatch[0] : '.jpg';
  fetch(url)
    .then(response => response.blob())
    .then(blob => {
      const blobUrl = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = blobUrl;
      a.download = filename;
      document.body.appendChild(a);
      a.click();
      a.remove();
      setTimeout(() => URL.revokeObjectURL(blobUrl), 1000);
    })
    .catch(err => console.error('Download failed', err));
}

images.forEach((img, idx) => {
  downloadImage(img, idx);
});