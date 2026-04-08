document.addEventListener('DOMContentLoaded', function() {
    const checkElement = setInterval(() => {
        const commandDialog = document.querySelector(".quick-input-widget");
        if (!commandDialog) {
            console.debug("Command dialog not found.  Retrying ... ");
            return;
        }

        shouldShowBlur = commandDialog.style.display !== "none";

        // Observer only gets attached after 1st run; make that not look ugly
        if (shouldShowBlur) { addBlurContainer() }

        // Create an DOM observer to 'listen' for changes in element's attribute.
        const observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                if (mutation.type === 'attributes' && mutation.attributeName === 'style') {
                    const shouldShowBlur = commandDialog.style.display !== "none";
                    if (shouldShowBlur) { addBlurContainer() }
                    else                { detachBlurContainer() }
                }
            });
        });

        observer.observe(commandDialog, { attributes: true });

        // Clear the interval once the observer is set
        clearInterval(checkElement);
    }, 500); // Check every 500ms

    function addBlurContainer() {
        const targetDiv = document.querySelector(".monaco-workbench");

        // Remove existing element if it already exists
        const existingElement = document.getElementById("command-blur");
        if (existingElement) {
            existingElement.remove();
        }

        // Create and configure the new element
        const newElement = document.createElement("div");
        newElement.setAttribute('id', 'command-blur');

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
