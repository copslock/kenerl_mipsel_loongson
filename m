Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2003 13:57:39 +0100 (BST)
Received: from p508B5EF1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.241]:9180
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225310AbTICM5h>; Wed, 3 Sep 2003 13:57:37 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h83CvZHE010878;
	Wed, 3 Sep 2003 14:57:36 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h83CvZbS010877;
	Wed, 3 Sep 2003 14:57:35 +0200
Date: Wed, 3 Sep 2003 14:57:34 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org,
	GNU libc hackers <libc-hacker@sources.redhat.com>,
	libc-alpha@sources.redhat.com
Subject: More sigevent ...
Message-ID: <20030903125734.GA9260@linux-mips.org>
References: <20030831145854.GB23189@linux-mips.org> <20030831161217.GA10286@linux-mips.org> <20030831164812.GB766@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831164812.GB766@bogon.ms20.nix>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Looking into the problem a bit deeper here's my analysis of the whole
missmatch of struct sigevent and the associated constants, including the
entire history.

 - Linux 2.1.72 introduces sigevent.  The definition used is the one taken
   from IRIX and different from what is used in other Linux ports.  But
   that doesn't matter because there are no in-kernel users.

   I don't know why the structure was defined at all in kernel headers at
   all by that time.  Maybe for the sake of libc 5?

 - Some of the >= libc 2.1 version circulating use the kernel definitions

 - Andreas Jaeger contributes sysdeps/unix/sysv/linux/mips/bits/siginfo.h
   for the FSF version of glibc 2.1.  Markedrd as "XXX This one might need
   to change!!!" this header file uses the same structure as other Linux
   architectures but uses the same SIGEV_* constants as the kernel.

 - Linux 2.5.63 introduces the POSIX.1b timer API which uses the kernel's
   definition of sigevent.  The userspace part of the POSIX.1b timer patch
   uses glibc's definition.  But the code assumes both definitions are
   identical ...

Time to resolve the mess.  I see the following options:

 - Yet another syscall wrapper that does argument conversion.  Imho the
   most icky solution.

 - Change the kernel to use the same definition as glibc.  Not really an
   option, SIGEV_CALLBACK has to go.

 - Two part solution:
   - Change the kernel definition to what other architectures use (Done,
     may have to be undone depending on the outcome of this discussion).

   - Remove SIGEV_CALLBACK from glibc which would result in SIGEV_THREAD
     getting renumbered to the same value as in the kernel.
     (This is in my withdrawn libc patch from the weekend.)

   Grepping around in plenty of Linux code I've not found any users of
   SIGEV_THREAD so this would be my prefered solution.

   SIGEV_CALLBACK would have to be removed in any case; it's a dead
   definition with no functionality.  Is it supposed to do what
   SIGEV_THREAD_ID does?  I've been digging around in parts of the Redhat 9
   source code and haven't found any users of SIGEV_THREAD, so it seems
   this is a very rarely used feature and we can change without any major
   compatibility issues.

Comments?

  Ralf
