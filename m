Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HAbdh06122
	for linux-mips-outgoing; Thu, 17 Jan 2002 02:37:39 -0800
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HAbYP06119
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 02:37:34 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.9.3) with ESMTP id g0H9bUW10978;
	Thu, 17 Jan 2002 10:37:30 +0100
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id KAA28900;
	Thu, 17 Jan 2002 10:37:30 +0100 (MET)
Message-Id: <200201170937.KAA28900@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: karsten@excalibur.cologne.de
cc: vhouten@kpn.com, linux-mips@oss.sgi.com
Reply-to: vhouten@kpn.com
Subject: DECStation debian CD's
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Jan 2002 10:37:30 +0100
From: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Karsten,

I've installed a 5000/240 using your debian-mipsel images. The install
procedure needs some fixes, but I was able to create a bootable system.
You can have a look at the system and the bootlog at
http://www.xs4all.nl/~vhouten/mipsel/dior.html

After installing the toolchain, I was able to compile the 2.4.17 kernel,
and boot it. I tried to connect the disk to a 5000/200 (R3k too),
but this failed:

- delo doesn't work in combination with th 5000/200 PROM ???
  (the systems just resets)
- when booting a kernel by tftp, the output stops at:
  INIT: version 2.84 booting
- I've a;so tried the tftp install image on the 5000/200, and it
  turns out that busybox can't find any disk: when trying this from
  a shell, I found out that fdisk dumps core. This might be a toolchain
  issue, because the fdisk from H.J.Lu's RH7.1 port works ok on the /200.

Regards,
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
