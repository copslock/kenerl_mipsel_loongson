Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Nov 2004 18:19:45 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:16403 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224859AbUKJSTk>;
	Wed, 10 Nov 2004 18:19:40 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CRxCG-0003r5-00; Wed, 10 Nov 2004 18:27:56 +0000
Received: from perivale.mips.com ([192.168.192.200])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CRx3q-00080f-00; Wed, 10 Nov 2004 18:19:14 +0000
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1CRx3q-00037P-00; Wed, 10 Nov 2004 18:19:14 +0000
Date: Wed, 10 Nov 2004 18:19:14 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-alpha@sources.redhat.com, Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS/Linux: Kernel vs libc struct siginfo discrepancy
In-Reply-To: <20041110180050.GK7235@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.61.0411101807550.11408@perivale.mips.com>
References: <Pine.LNX.4.61.0411101657420.11408@perivale.mips.com>
 <20041110180050.GK7235@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.805, required 4, AWL,
	BAYES_00)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

On Wed, 10 Nov 2004, Thiemo Seufer wrote:

> >  Since the following change:
> > 
> > http://www.linux-mips.org/cvsweb/linux/include/asm-mips/siginfo.h.diff?r1=1.4&r2=1.5&only_with_tag=MAIN
> > 
> > dated back to Aug 1999 (!), the definitions of struct siginfo in Linux and 
> > GNU libc differ to each other.
> 
> Only 2.4 Kernels, 2.6 uses the normal definition again.

 Ah, it's been changed again for 2.6.9-rc3 without a word of a comment, 
grrr...

> > While it's the kernel that is at fault by 
> > changing its ABI, at this stage it may be more acceptable to update glibc 
> > as it's not the only program interfacing to Linux (uClibc?).  It doesn't 
> > seem to be a heavily used feature as otherwise someone else would have 
> > noticed the problem during these five years.  As I don't really have a 
> > preference, hereby I provide two patches to choose from and ask for 
> > voting.
> 
> I prefer to bring the 2.4 kernel in line with the rest of the system.

 OK for me.

> You surely meant to change the mips-specific siginfo.h here.

 Thanks for spotting it.  Here's an update just in case.

  Maciej

glibc-2.3.3-20041018-mips-siginfo_sigchld-2.patch
diff -up --recursive --new-file glibc-2.3.3-20041018.macro/sysdeps/unix/sysv/linux/mips/bits/siginfo.h glibc-2.3.3-20041018/sysdeps/unix/sysv/linux/mips/bits/siginfo.h
--- glibc-2.3.3-20041018.macro/sysdeps/unix/sysv/linux/mips/bits/siginfo.h	Fri May 23 02:26:20 2003
+++ glibc-2.3.3-20041018/sysdeps/unix/sysv/linux/mips/bits/siginfo.h	Wed Nov 10 18:06:51 2004
@@ -65,8 +65,8 @@ typedef struct siginfo
 	  {
 	    __pid_t si_pid;	/* Which child.  */
 	    __uid_t si_uid;	/* Real user ID of sending process.  */
-	    int si_status;	/* Exit value or signal.  */
 	    __clock_t si_utime;
+	    int si_status;	/* Exit value or signal.  */
 	    __clock_t si_stime;
 	  } _sigchld;
 
