Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03JqRf25490
	for linux-mips-outgoing; Thu, 3 Jan 2002 11:52:27 -0800
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03JqHg25466
	for <linux-mips@oss.sgi.com>; Thu, 3 Jan 2002 11:52:18 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.9.3) with ESMTP id g03IqEa08237;
	Thu, 3 Jan 2002 19:52:14 +0100
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id TAA01081;
	Thu, 3 Jan 2002 19:52:13 +0100 (MET)
Message-Id: <200201031852.TAA01081@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: guido.guenther@gmx.net
cc: karel@sparta.research.kpn.com, linux-mips@oss.sgi.com
Reply-to: vhouten@kpn.com
Subject: Newport Xserver 2001-11-21
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 19:52:13 +0100
From: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Guido,

I'm experimenting with your Xserver for my indy, currently running
the 2.4.16 kernel. I've used a local compiled Xserver before, but that
was with an older kernel. Now, using 2.4.16 and your Xserver, I get the
following errors:

XFree86 Version 4.1.99.2 / X Window System
(protocol Version 11, revision 0, vendor release 6510)
Release Date: 12 December 2001
        If the server is older than 6-12 months, or if your card is
        newer than the above date, look for a newer version before
        reporting problems.  (See http://www.XFree86.Org/)
Build Operating System: Linux 2.4.16 mips [ELF] 
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Thu Jan  3 19:50:14 2002
(==) Using config file: "/etc/X11/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) ServerLayout "simple layout"
(**) |-->Screen "Screen 1" (0)
(**) |   |-->Monitor "SGI GDM17e11"
(**) |   |-->Device "Newport Graphics"
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Keyboard1"
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/local/,/usr/X11R6/lib/X11/fonts/mi
sc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:uns
caled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/CID/,/usr/X11R6/li
b/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100d
pi/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 7

(II) Loading /usr/X11R6/lib/modules/libbitmap.so
(II) Module bitmap: vendor="The XFree86 Project"
        compiled for 4.1.99.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libpcidata.so
(II) Module pcidata: vendor="The XFree86 Project"
        compiled for 4.1.99.2, module version = 0.1.0
(EE) No OS PCI support available
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.so
(II) Module dbe: vendor="The XFree86 Project"
        compiled for 4.1.99.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.so
(II) Module extmod: vendor="The XFree86 Project"
        compiled for 4.1.99.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/drivers/newport_drv.so
(II) Module newport: vendor="The XFree86 Project"
        compiled for 4.1.99.2, module version = 0.1.3
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.so
(II) Module mouse: vendor="The XFree86 Project"
        compiled for 4.1.99.2, module version = 1.0.0
(II) NEWPORT: driver for Newport Graphics Card: XL
(EE) No devices detected.

Fatal server error:
no screens found

Is this a problem with the current kernel? Or have I missed 
a config option?

Regards,
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
