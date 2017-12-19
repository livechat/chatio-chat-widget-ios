var ChatioWidget_hasFocusValue = false

document.hasFocus = function () { return ChatioWidget_hasFocusValue;}

var originalAddEventListener = window.addEventListener;
var originalRemoveEventListener = window.removeEventListener;
var handlers = {}

window.addEventListener = function (event, handler) {
    if (event === 'blur' || event === 'focus') {
        handlers[event] = handlers[event] || []
        handlers[event].push(handler)
        return
    }
    
    originalAddEventListener.call(window, event, handler)
}

window.removeEventListener = function (event, handler) {
    if (event === 'blur' || event === 'focus') {
        if (!handlers[event]) {
            return
        }
        
        var index = handlers[event].indexOf(handler)
        
        if (index === -1) {
            return
        }
        
        handlers[event].splice(index, 1)
        return
    }
    
    originalRemoveEventListener.call(window, event, handler)
}

function ChatioWidget_emitFocus() {
    ChatioWidget_hasFocusValue = true;
    
    if (!handlers.focus) {
        return
    }
    
    var focusName = 'focus'
    var focusEvent = document.createEvent('Event')
    focusEvent.initEvent(focusName, false, false);
    
    handlers.focus.forEach(function (handler) { handler(focusEvent) })
}

function ChatioWidget_emitBlur() {
    ChatioWidget_hasFocusValue = false;
    
    if (!handlers.blur) {
        return
    }
    
    var blurName = 'blur'
    var blurEvent = document.createEvent('Event')
    blurEvent.initEvent(blurName, false, false);
    
    handlers.blur.forEach(function (handler) { handler(blurEvent) })
}
