Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f669R8X02207
	for linux-mips-outgoing; Fri, 6 Jul 2001 02:27:08 -0700
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f669R6V02198
	for <linux-mips@oss.sgi.com>; Fri, 6 Jul 2001 02:27:06 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.9.3/8.9.3) with ESMTP id LAA12355;
	Fri, 6 Jul 2001 11:27:04 +0200
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id LAA10388;
	Fri, 6 Jul 2001 11:27:03 +0200 (MET DST)
Message-Id: <200107060927.LAA10388@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: Carsten Langgaard <carstenl@mips.com>
cc: vhouten@kpn.com, linux-mips@oss.sgi.com, karel@sparta.research.kpn.com
Subject: Re: Illegal instruction 
In-reply-to: Your message of "Fri, 06 Jul 2001 10:15:52 +0200."
             <3B4573B8.9F89022B@mips.com> 
Reply-to: vhouten@kpn.com
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Jul 2001 11:27:03 +0200
From: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Carsten Langgaard wrote: 
> I have tried the root-images tar-files: mipselroot-rh7-20010606 and
> mipsroot-rh7.
> The mipsroot-rh7 (bigendian) root image seem to work fine, but when
> I use the mipselroot-rh7-20010606 (littleendian) I get an illegal
> instruction.
> [cat:179] Illegal instruction 7c010001 at 2ac8b20c ra=00000000.
> 
> I'm using a 2.4.3 kernel.
> Anyone got an idea ?

I'm still using 2.4.0-test9 on mipsel, because I've problems with the
newer kernels too.  I hope to test H.J. Lu's toolchain/glibc, but
currently it is much to hot to switch on extra computers :-)

Regards,
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
