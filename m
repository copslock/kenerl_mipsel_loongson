Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 15:57:06 +0200 (CEST)
Received: from p508B5F93.dip.t-dialin.net ([80.139.95.147]:16776 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122958AbSIDN5F>; Wed, 4 Sep 2002 15:57:05 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g84Dujw32398;
	Wed, 4 Sep 2002 15:56:45 +0200
Date: Wed, 4 Sep 2002 15:56:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: 64-bit and N32 kernel interfaces
Message-ID: <20020904155645.A31893@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 75
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

(I bcc'ed this to a few people; please followup to linux-mips@linux-mips.org.
I'd like this to be discussed widely before it's cast into stone as everybody
will have to live with this for the years to come.)

Right now the 64-bit kernel interfaces are still pretty much an ad-hoc
approach and can't be considered frozen.  There is now some pressure to
come up with a stable 64-bit API asap.

As first think I want to get rid of all the historic crap we have in
our syscall tables for the 64-bit syscalls.  Let's start here:

#define __NR_syscall                    (__NR_Linux +   0)

Deprecated because can be implemented in userspace.

#define __NR_ioperm                     (__NR_Linux + 101)
#define __NR_iopl                       (__NR_Linux + 110)
#define __NR_vm86                       (__NR_Linux + 113)

i386 braindamage we're never going to support.  So why have it in our
syscall table?

#define __NR_unused59                   (__NR_Linux +  59)
#define __NR_reserved82                 (__NR_Linux +  82)
#define __NR_unused109                  (__NR_Linux + 109)
#define __NR_unused150                  (__NR_Linux + 150)

Unused entries.  Why keep them ...

#define __NR_break                      (__NR_Linux +  17)
#define __NR_stty                       (__NR_Linux +  31)
#define __NR_gtty                       (__NR_Linux +  32)
#define __NR_ftime                      (__NR_Linux +  35)
#define __NR_prof                       (__NR_Linux +  44)
#define __NR_signal                     (__NR_Linux +  48)
#define __NR_mpx                        (__NR_Linux +  56)
#define __NR_ulimit                     (__NR_Linux +  58)
#define __NR_readdir                    (__NR_Linux +  89)
#define __NR_profil                     (__NR_Linux +  98)
#define __NR_modify_ldt                 (__NR_Linux + 123)

Slots that data back to day one of UNIX way before Linux was born.

#define __NR_socketcall                 (__NR_Linux + 102)

Wrapper syscall, obsoleted since quite a while in the 32-bit kernel.

#define __NR_idle                       (__NR_Linux + 112)

Internal syscall, no longer used.

#define __NR_ipc                        (__NR_Linux + 117)

Yet another multiplexor syscall and imho another candidate for getting
rid of.

#define __NR_oldstat                    (__NR_Linux +  18)
#define __NR_umount                     (__NR_Linux +  22)
#define __NR_oldfstat                   (__NR_Linux +  28)
#define __NR_oldlstat                   (__NR_Linux +  84)

Superseeded by newer versions.

#define __NR_uselib                     (__NR_Linux +  86)

a.out support.  Do we really want that.

I probably missed a few.  The primary purpose of this posting is to get a
discussion about the 64-bit syscall interface started.  It's still not
cast into stone so we can modify it as we see fit.  The entire syscall
interface is still open for changes, this includes all structures etc.
Along with a 64-bit ABI we'll also have to deciede about a N32 ABI.

Suggestions, comments etc?

  Ralf
