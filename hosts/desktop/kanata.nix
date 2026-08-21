{
  my.kanata = {
    enable = true;

    devices = [
      "/dev/input/by-path/pci-0000:01:00.0-usb-0:1:1.0-event-kbd"
    ];

    config = ''
	    (defsrc
	     tab
	     caps h j k l           
	     lctl
	    )

	    (deflayer default
	     @arr-on
	     lctl _ _ _ _ 
	     caps
	    )
	    (deflayer arrows
	     tab      
	     _ left down up rght          
	     _
	    )
	    (defalias
	     arr-on (tap-hold-press 300 300 tab (layer-toggle arrows))
	    )    
	'';
  };
}

