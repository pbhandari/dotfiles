document.addEventListener('DOMContentLoaded', function() {
    const checkElement = setInterval(() => {
        const commandDialog = document.querySelector(".quick-input-widget");
        if (!commandDialog) {
            console.debug("Command dialog not found.  Retrying ... ");
            return;
        }
        console.log(commandDialog)

        // Observer isn't attached the 1st time this element spawns
        toggleBlur()

        // Create an DOM observer to 'listen' for changes in element's attribute.
        const observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                if (mutation.type === 'attributes' && mutation.attributeName === 'style') {
                    toggleBlur()
                }
            });
        });

        observer.observe(commandDialog, { attributes: true });

        // Clear the interval once the observer is set
        clearInterval(checkElement);
    }, 500); // Check every 500ms

    function toggleBlur() {
        const displayStyle = document.querySelector(".quick-input-widget")?.style.display  ?? "none"
        const shouldShowBlur = displayStyle !== "none";
        if (shouldShowBlur) { addBlurContainer() }
        else                { detachBlurContainer() }
    }

    function addBlurContainer() {
        const targetDiv = document.querySelector(".monaco-workbench");

        // Remove existing element if it already exists
        document.getElementById("command-blur")?.remove()

        // Create blur div, and append styles
        const newElement = document.createElement("div");
        newElement.setAttribute('id', 'command-blur');
        Object.assign(newElement.style, {
            position: 'absolute',
            width: '100%',
            height: '100%',
            background: 'rgba(0, 0, 0, .15)',
            backdropFilter: 'blur(2px)',
            top: '0',
            left: '0',
            zIndex: '99'
        });

        newElement.addEventListener('click', function() {
            newElement.remove();
        });

        // Append the new element as a child of the targetDiv
        targetDiv.appendChild(newElement);
    }

    // Remove the backdrop blur from the DOM when esc key is pressed.
    function detachBlurContainer() {
        const element = document.getElementById("command-blur");
        if (element) {
            element.click();
        }
    }
});
