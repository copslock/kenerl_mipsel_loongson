Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR8rmY10458
	for linux-mips-outgoing; Tue, 27 Nov 2001 00:53:48 -0800
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAR8rho10455
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 00:53:44 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.9.3/8.9.3) with ESMTP id IAA30759;
	Tue, 27 Nov 2001 08:53:41 +0100
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id IAA24915;
	Tue, 27 Nov 2001 08:53:41 +0100 (MET)
Message-Id: <200111270753.IAA24915@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: Florian Lohoff <flo@rfc822.org>
cc: linux-mips@oss.sgi.com, karel@sparta.research.kpn.com
Subject: Re: Decstation /150 kernel (cvs) problems 
In-reply-to: Your message of "Tue, 27 Nov 2001 02:56:22 +0100."
             <20011127025622.D28037@paradigm.rfc822.org> 
Reply-to: vhouten@kpn.com
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Nov 2001 08:53:40 +0100
From: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Florian,

> Hi,
> it seems the current cvs kernel does not work on my /150 - Does anyone
> have similar expiriences ? It simply reboots for me ...
> 
> >>boot 3/rz0 2/linux.test
> delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
> Loading /etc/delo.conf .. ok
> Loading /boot/vmlinux-2.4.14 ................ ok
> 
> KN04 V2.1k    (PC: 0x80148b9c, SP: 0x8043fef0)
> delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
> ...

I've noticed that recent kernels can't be booted by delo.
As far as I have dug into that, it might be the changed loadaddr,
that is hardcoded in delo...
TFTP booting the same kernel does indeed start the kernel
(for me it usually crashes or hangs some moments later).

Regards,
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
