Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f436ReE29254
	for linux-mips-outgoing; Wed, 2 May 2001 23:27:40 -0700
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f436RVF29246;
	Wed, 2 May 2001 23:27:31 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.9.3/8.9.3) with ESMTP id IAA01433;
	Thu, 3 May 2001 08:27:29 +0200
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id IAA27956;
	Thu, 3 May 2001 08:27:29 +0200 (MET DST)
Message-Id: <200105030627.IAA27956@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: linux-mips@oss.sgi.com
cc: ralf@oss.sgi.com
Reply-to: vhouten@kpn.com
Subject: Compilers / libstdc++ for RH7-mips
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 May 2001 08:27:29 +0200
From: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi all,

I've uploaded working Compiler packages (2.95.3-19) for the RH7 mips port.
They are a straight compile of Maciej's src.rpm package.
Yes, this compiler can compile a kernel natively.
With this libstdc++ package, the groff package is working again.

Ralf: you might move the files over from 'contrib' to 'RPMS' / 'SRPMS',
just as you like.

For now, they are at:
ftp://oss.sgi.com/pub/linux/mips/redhat/test-7.0/contrib

Regards,
Karel.
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
