Received:  by oss.sgi.com id <S553716AbQJXFwK>;
	Mon, 23 Oct 2000 22:52:10 -0700
Received: from hermes.research.kpn.com ([139.63.192.8]:50952 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S553686AbQJXFvq>; Mon, 23 Oct 2000 22:51:46 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01JVPHWIC5S0000S9V@research.kpn.com>; Tue,
 24 Oct 2000 07:51:44 +0200
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id HAA02069; Tue,
 24 Oct 2000 07:51:43 +0200 (MET DST)
Date:   Tue, 24 Oct 2000 07:51:42 +0200
From:   "Houten K.H.C. van (Karel)" <K.H.C.vanHouten@research.kpn.com>
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Subject: Re: process lockups
In-reply-to: "Your message of Tue, 24 Oct 2000 04:47:36 +0200."
 <20001024044736.B3397@bacchus.dhis.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com,
        K.H.C.vanHouten@research.kpn.com
Reply-to: K.H.C.vanHouten@kpn.com
Message-id: <200010240551.HAA02069@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: exmh version 1.6.5 12/11/95
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Ralf Baechle wrote:
>
> On Tue, Oct 24, 2000 at 03:22:32AM +0200, Karsten Merker wrote:
> 
> > I am running Kernel 2.4.0-test9 on a DECstation 5000/150. I am
> > experiencing a strange behaviour when having strong I/O-load, such as
> > running a "tar xvf foobar.tgz" with a large archive. After some time of
> > activity the process (in this case tar) is stuck in status "D". There is
> > neither an entry in the syslog nor on the console that would give me a
> > hint what is happening. Is anyone else experiencing this?
> 
> I observe similar stuck processes on Origins - even without massive I/O
> load.  I'm trying to track them but little success aside of fixing a few
> unrelated little bugs.  Do you observe those on your R4k box also?
On my DEC 5000/260 (R4k) I have no stuck processes, but I should mention
that I am running without swap (I have 192Mb RAM).
 
> Another things which I'm observing is that I occasinally can't unmount
> a filesystem.  umount then says the fs is still in use.  Sometimes it's
> at least possible to remount the fs r/o.  Have you also observed this one?
Yes, but only the root FS. I thought I might have to upgrade to a newer
mount program for the 2.4 kernel, or is the system call returning the error?

> > Another thing I see on my 5000/150 (and only there - this is my only
> > R4K-machine, so I do not know whether this is CPU- or machine-type-bound)
> > is "top" going weird, eating lots of CPU cycles and spitting messages
> > "schedule_timeout: wrong timeout value fffbd0b2 from 800900f8; Setting
> > flush to zero for top". I know Florian also has this on his 5000/150.
> > Anyone else with the same behavoiur or any idea about the cause for this?
> 
> Setting flush to zero for <process name> means that the floating point
> approximator is now enabled ;-)
> 
> The schedule_timeout thing is unrelated; I've never heared of it before.

Aside from this I stil get 'bug in get_wchan' messages, but everything
seems to run fine. I hope to test my current kernels on a 5000/150 and
a 3100.

Regards,

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
