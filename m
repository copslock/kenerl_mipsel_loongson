Received:  by oss.sgi.com id <S553781AbQKPVPh>;
	Thu, 16 Nov 2000 13:15:37 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14717 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S553766AbQKPVPa>; Thu, 16 Nov 2000 13:15:30 -0800
Received: from zeus-fddi.americas.sgi.com (zeus-fddi.americas.sgi.com [128.162.8.103]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA09266
	for <linux-mips@oss.sgi.com>; Thu, 16 Nov 2000 13:23:18 -0800 (PST)
	mail_from (jberens@sgi.com)
Received: from poppy-e185.americas.sgi.com (poppy.americas.sgi.com [128.162.185.207]) by zeus-fddi.americas.sgi.com (8.9.3/americas-smart-nospam1.1) with ESMTP id PAA7686803 for <linux-mips@oss.sgi.com>; Thu, 16 Nov 2000 15:14:14 -0600 (CST)
Received: from jberens.americas.sgi.com (jberens.americas.sgi.com [128.162.186.11]) by poppy-e185.americas.sgi.com (980427.SGI.8.8.8/SGI-server-1.7) with ESMTP id PAA88645 for <linux-mips@oss.sgi.com>; Thu, 16 Nov 2000 15:14:13 -0600 (CST)
Date:   Thu, 16 Nov 2000 15:10:53 -0600
From:   Joe Berens <jberens@sgi.com>
X-Sender: jberens@jberens.americas.sgi.com
To:     linux-mips@oss.sgi.com
Subject: X
Message-ID: <Pine.SGI.4.10.10011161506530.11923-100000@jberens.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I have compiled X on my Indy running linux following the directions found
at http://honk.physik.uni-konstanz.de/~agx/mipslinux/x/x.html.  When i to
startx it seems to start X but no x ever shows up.  From
/var/log/xdm-errrors:

XFree86 Version 4.0.1 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 1 July 2000
        If the server is older than 6-12 months, or if your card is newer
        than the above date, look for a newer version before reporting
        problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.1.100 mips [ELF] 
(==) Log file: "/var/log/XFree86.0.log", Time: Wed Nov 15 11:32:55 2000
(==) Using config file: "/etc/X11/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (??) unknown.
(==) ServerLayout "simple layout"
(**) |-->Screen "Screen 1" (0)
(**) |   |-->Monitor "SGI GDM17e11"
(**) |   |-->Device "Newport Graphics"
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Keyboard1"
(WW) The directory "/usr/X11R6/lib/X11/fonts/100dpi/" does not exist.
        Entry deleted from font path.
(WW) The directory "/usr/X11R6/lib/X11/fonts/100dpi/" does not exist.
        Entry deleted from font path.
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/local/,/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/CID/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(--) using VT number 7

(EE) No OS PCI support available
(II) v4l driver for Video4Linux
(II) Newport: driver for Newport Graphics Card: XL
(**) Newport(0): Depth 8, (--) framebuffer bpp 8
(==) Newport(0): Default visual is PseudoColor
(==) Newport(0): Using gamma correction (1.0, 1.0, 1.0)
xdm error (pid 4268): Hung in XOpenDisplay(:0), aborting
xdm error (pid 4268): server open failed for :0, giving up
xdm error (pid 4265): Display :0 cannot be opened

Any help?

Thank you,

Joe



___________________________________

Joe Berens
SGI Customer Support Center
Operating Systems Group
Phone: 800-800-4744, Direct: 651-683-3254
Email: jberens@sgi.com

___________________________________
