Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f31Eddl11512
	for linux-mips-outgoing; Sun, 1 Apr 2001 07:39:39 -0700
Received: from hermes.research.kpn.com (hermes.research.kpn.com [139.63.192.8])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f31EdbM11509
	for <linux-mips@oss.sgi.com>; Sun, 1 Apr 2001 07:39:38 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01K1W4OUCURA000PPL@research.kpn.com> for
 linux-mips@oss.sgi.com; Sun, 1 Apr 2001 16:39:35 +0200
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id QAA12245; Sun,
 01 Apr 2001 16:39:34 +0200 (MET DST)
Date: Sun, 01 Apr 2001 16:39:34 +0200
From: "Houten K.H.C. van (Karel)" <K.H.C.vanHouten@research.kpn.com>
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Subject: Re: Recommended toolchain
In-reply-to: "Your message of Thu, 29 Mar 2001 20:10:15 +0200."
 <Pine.GSO.3.96.1010329195202.16049B-100000@delta.ds2.pg.gda.pl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: vhouten@kpn.com, linux-mips@oss.sgi.com
Reply-to: vhouten@kpn.com
Message-id: <200104011439.QAA12245@sparta.research.kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


"Maciej W. Rozycki" writes:
> So I guess there may be something wrong with the R4k code generation in
>gcc 2.95.2(3) (or possibly binutils, but the latter is quite unlikely).  I
>can't run-time test R4k code but I may see if I can review the generated
>binary of startup code up to the first line output for any
>inconsistencies.  Don't hold your breath, though... 

I've now done a native compile of a CVS checkout from Friday, and
it does compile. It even boots, up until:

esp0: target 1 [period 248ns offset 15 4.03MHz synchronous SCSI]
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Unhandled kernel unaligned access in unaligned.c:emulate_load_store_insn, line 372:
$0 : 00000000 10010c00 8017fed0 00000000
$4 : 801fe33c 80200000 813de000 802db000
$8 : 10010c01 8019af20 00000000 00000000
$12: 00000000 fffff000 fffffff7 802db060
$16: 00000000 813de000 00000001 00000000
$20: 00000005 801cbe34 801eb070 801eb1ac
$24: 00000000 0000000a
$28: 8022e000 8022fe88 00000000 80066cc0
epc   : 8017ff08
Status: 10010c03
Cause : 00002010
Process swapper (pid: 1, stackpage=8022e000)

etc.
I have not yet found the time to look further into that...
