let sites = [];
let currentIndex = 0;
let intervalId = null;

async function loadSites() {
    try {
        const response = await fetch('sites.json');
        sites = await response.json();
        if (sites.length > 0) {
            startRotation();
        }
    } catch (error) {
        console.error('Failed to load sites.json:', error);
        document.getElementById('kiosk-container').innerHTML = '<p>Error loading configuration.</p>';
    }
}

function startRotation() {
    const iframe = document.getElementById('site-iframe');
    const container = document.getElementById('kiosk-container');

    function showSite(index) {
        const site = sites[index];
        const zoom = site.zoom / 100 || 1;
        iframe.src = site.url;
        iframe.style.transform = `scale(${zoom})`;
        iframe.style.width = `${100 / zoom}%`;
        iframe.style.height = `${100 / zoom}%`;
        iframe.onload = () => {
            console.log(`Loaded: ${site.url}`);
        };
        iframe.onerror = () => {
            console.error(`Failed to load: ${site.url}`);
            // Skip to next site
            setTimeout(() => nextSite(), 1000);
        };

        const interval = site.interval || 60; // default 60 seconds
        intervalId = setTimeout(() => nextSite(), interval * 1000);
    }

    function nextSite() {
        clearTimeout(intervalId);
        currentIndex = (currentIndex + 1) % sites.length;
        showSite(currentIndex);
    }

    showSite(currentIndex);

    // Enter fullscreen
    if (document.documentElement.requestFullscreen) {
        document.documentElement.requestFullscreen();
    }
}

document.addEventListener('DOMContentLoaded', loadSites);