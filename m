Received:  by oss.sgi.com id <S42246AbQGOI5u>;
	Sat, 15 Jul 2000 01:57:50 -0700
Received: from smtp-1.worldonline.cz ([195.146.100.76]:24465 "EHLO
        smtp.worldonline.cz") by oss.sgi.com with ESMTP id <S42205AbQGOI5e>;
	Sat, 15 Jul 2000 01:57:34 -0700
Received: from pingu (IDENT:indy@ppp204.plzen.worldonline.cz [212.11.110.208])
	by smtp.worldonline.cz (8.9.3 (WOL 1.2)/8.9.3) with SMTP id KAA22443
	for <linux-mips@oss.sgi.com>; Sat, 15 Jul 2000 10:56:13 +0200 (MET DST)
From:   "Jiri Kastner jr." <indy.j@worldonline.cz>
To:     Linux-MIPS Mailing List <linux-mips@oss.sgi.com>
Subject: mknod /dev/graphics + /dev/gfx
Date:   Sat, 15 Jul 2000 10:52:18 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00071510590700.00833@pingu>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

How to make /dev/graphics + /dev/gfx,
I did not found anywhere described major/minor etc for this devices...

I am trying to start X on Indy, here is log:

XFree86 Version 4.0 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 8 March 2000
	If the server is older than 6-12 months, or if your card is newer
	than the above date, look for a newer version before reporting
	problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.13 mips [ELF] 
(==) Log file: "/var/log/XFree86.0.log", Time: Sat Jul 15 09:51:01 2000
(==) Using config file: "/etc/X11/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (??) unknown.
(==) ServerLayout "Simple Layout"
(**) |-->Screen "Screen 1" (0)
(**) |   |-->Monitor "sgi"
(**) |   |-->Device "My Video Card"
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Keyboard1"
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc101"
(**) XKB: model: "pc101"
(**) Option "XkbLayout" "en_US"
(**) XKB: layout: "en_US"
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/local/,/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(--) using VT number 7

(II) Addressable bus resource ranges are
	[0] -1	0x00000000 - 0xffffffff (0x0) MXB
	[1] -1	0x00000000 - 0x0000ffff (0x10000) IXB
(II) OS-reported resource ranges:
(II) OS-reported resource ranges after removing overlaps with PCI:
(II) All system resource ranges:
(II) NewPort: driver for Newport Graphics Card: XL
(EE) No devices detected.

Fatal server error:
no screens found


Regards
Jiri Kastner.
