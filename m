Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6F9ZORw027290
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 02:35:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6F9ZOD0027289
	for linux-mips-outgoing; Mon, 15 Jul 2002 02:35:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6F9ZJRw027280
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 02:35:20 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.9.3) with ESMTP id g6F9e8a24841
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 11:40:08 +0200
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id LAA24361
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 11:40:08 +0200 (MET DST)
Message-Id: <200207150940.LAA24361@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: linux-mips@oss.sgi.com
Reply-to: vhouten@kpn.com
Subject: DECStation: Support for PMAZ-AA TC SCSI card?
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Jul 2002 11:40:08 +0200
From: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
X-Spam-Status: No, hits=-0.1 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Hi all,

I'm currently experimenting with software raid support on my decstation,
and it looks fine! But I would love to use more than one SCSI chain
for my raid disks. My DECStation contains a Turbochannel PMAZ-AA
SCSI card, which WAS once supported in the driver, but isn't anymore. :-(

Does anyone knows about patches to get this working again? (Harald, David, 
Florian?)

Regards,
Karel.
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
