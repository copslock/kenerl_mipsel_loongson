Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2FDNK128170
	for linux-mips-outgoing; Fri, 15 Mar 2002 05:23:20 -0800
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2FDND928167
	for <linux-mips@oss.sgi.com>; Fri, 15 Mar 2002 05:23:14 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.9.3) with ESMTP id g2FDOUg00607;
	Fri, 15 Mar 2002 14:24:30 +0100
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id OAA18816;
	Fri, 15 Mar 2002 14:24:30 +0100 (MET)
Message-Id: <200203151324.OAA18816@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@oss.sgi.com
Subject: Re: DECStation kernel boot failure 
In-reply-to: Your message of "Fri, 15 Mar 2002 13:47:23 +0100."
             <20020315124723.GZ25044@lug-owl.de> 
Reply-to: vhouten@kpn.com
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Mar 2002 14:24:30 +0100
From: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Jan-Benedict Glaw wrote:
> On Fri, 2002-03-15 22:16:08 +1030, Guo-Rong Koh <grk@start.com.au>
> wrote in message <B1516392835@i01sv4138.ids1.intelonline.com>:
> > ....
> > This DECstation is a Personal DS5000/xx
> > CPU revision is: 00000230
> > FPU revision is: 00000340
> > Primary instruction cache 64kb, linesize 4 bytes
> > Primary data cache 64kb, linesize 4 bytes
> > Linux version 2.4.16 (root@elrond) (gcc version 2.96 20000731 (Red Hat
> > Linux 7.1 2.96-96.1)) #7 Sun Dec 23 14:57:24 MET 2001
> > Determined physical RAM map:
> >  memory: 01000000 @ 00000000 (usable)
> > On node 0 totalpages: 4096
> > zone(0): 4096 pages.
> > zone(1): 0 pages.
> > zone(2): 0 pages.
> > Kernel command line: root=/dev/nfs nfsroot=192.168.2.145:/mips
> > ip=bootp
> 
> Command line looks good to me.
> 
> > Calibrating delay loop... 24.87 BogoMIPS
> > Memory: 13520k/16384k available (2007k kernel code, 2864k reserved,
> > 87k data, 76k init)
> > Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
> > Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
> > Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> > Kernel panic: can't allocate root vfsmount
> > In idle task - not syncing
> > --kernel boot dump finishes here--
> 
> You attempt to do nfsroot, but I can't see that your network card
> has been detected. Are you sure you've included it into kernel
> compile? If not, do so...

He uses my kernel image. I'm sure I've included the DECStation 5000
ethernet card, because the same image works OK on other DECStations.
I don't have access to a 5000/25 however.


Regards,
Karel.
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
