(function(window, document, undefined){
	
	// Constructor
	var ModalBox = function() {
		this.init();
	};
	
	// Defaults
	ModalBox.prototype.defaults = {
		closed: true,
		data: null,
		closeClass: '',
		top: 0,
		topOffset: 0,
		onOpen: null,
		onShow: null,
		onClose: null,
		onHide: null,
		dispose: false,
		source: null
	};
	
	ModalBox.prototype.init = function() {
		var 
			self = this,
			el = self.element = document.createElement('div'),
			ov = self.overlay = document.createElement('div'),
			bo = self.box = document.createElement('div'),
			er = self.error = document.createElement('div'),
			lo = self.loader = document.createElement('div');
			
			el.style.display = 'none';
			
			el.id = 'modalbox-container';
			ov.id = 'modalbox-overlay';
			bo.id = 'modalbox-box';
			
			el.appendChild(ov);
			el.appendChild(bo);
			
			body = document.getElementsByTagName('body')[0];
			body.appendChild(el);
			
			for(var prop in this.defaults) {
				this[prop] = this.defaults[prop];
			}
	};
	
	ModalBox.prototype.open = function(data) {
		if (!this.closed) return;
		else this.closed = false;
		
		this.source = data.parentNode;
		
		// console.log('[ModalBox::open] ' + target);
		if(data) this.data = data;
		else return;
		
		if (this.onOpen) this.onOpen(this.data);

		try
		{
			var bo = this.box;
			bo.appendChild(data);
		}
		catch(Exception)
		{
			console.log('');
		}
		
		this.element.style.display = 'block';
		
		if(this.onShow) this.onShow(this.data);
	};
	
	ModalBox.prototype.close = function() {
		if (this.closed) return;
		else this.closed = true;
		
		// console.log('[ModalBox::close] data: ' + this.data);
		
		if (this.onClose) this.onClose(this.data);
		
		var da = this.data;
		if (da) {
			this.source.insertBefore(da, this.source.firstChild);
			// da.parentNode.removeChild(da);
			this.data = this.defaults.data;
		}
		
		this.element.style.display = 'none';
		
		if (this.onHide) this.onHide(this.data);
	};
	
	ModalBox.prototype.setTop = function(value) {
		if (value >= 0) {
			this.element.style.top = (value + this.topOffset) + 'px';
		}
	}
	
	ModalBox.prototype.isClosed = function()
	{
		return this.closed;
	}
	
	window.ModalBox = ModalBox;
	
})(window, document);