Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g04Hot613032
	for linux-mips-outgoing; Fri, 4 Jan 2002 09:50:55 -0800
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g04Hopg13029
	for <linux-mips@oss.sgi.com>; Fri, 4 Jan 2002 09:50:51 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.9.3) with ESMTP id g04Golw19561;
	Fri, 4 Jan 2002 17:50:47 +0100
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id RAA17203;
	Fri, 4 Jan 2002 17:50:47 +0100 (MET)
Message-Id: <200201041650.RAA17203@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: Guido Guenther <agx@sigxcpu.org>
cc: linux-mips@oss.sgi.com
Subject: Re: Newport Xserver 2001-11-21 
In-reply-to: Your message of "Fri, 04 Jan 2002 00:44:25 +0100."
             <20020104004425.B1519@galadriel.physik.uni-konstanz.de> 
Reply-to: vhouten@kpn.com
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 Jan 2002 17:50:47 +0100
From: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Guido,

You wrote:
> On Thu, Jan 03, 2002 at 07:52:13PM +0100, Houten K.H.C. van (Karel) wrote:
> > I'm experimenting with your Xserver for my indy, currently running
> > the 2.4.16 kernel. I've used a local compiled Xserver before, but that
> > was with an older kernel. Now, using 2.4.16 and your Xserver, I get the
> > following errors:
> Which 2.4.16? The one in the debian archive works. The X-Server
> parses /proc/cpuinfo to check if it runs on an Indy(yes, thats ugly)
> since we still have now proper GIO64 bus interface. Ralf recently
> changed some things in /proc/cpuinfo that broke this parsing. He
> reverted these changes later, so current oss cvs kernels should provide
> the necessary information in /proc/cpuinfo again.

Thanks. I've checked out 2.4.17 from CVS, and it indeed solves the problem
(now I only have to reinstall the X fonts :-).

Regards,
Karel.


-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
