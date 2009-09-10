Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Sep 2009 01:55:58 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16039 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493567AbZIJXzu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Sep 2009 01:55:50 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4aa991f40000>; Thu, 10 Sep 2009 16:55:32 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 10 Sep 2009 16:54:44 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 10 Sep 2009 16:54:44 -0700
Message-ID: <4AA991C1.1050800@caviumnetworks.com>
Date:	Thu, 10 Sep 2009 16:54:41 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
CC:	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux390@de.ibm.com, linux-s390@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linux-am33-list@redhat.com, Kyle McMartin <kyle@mcmartin.ca>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-alpha@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Mike Frysinger <vapier@gentoo.org>,
	uclinux-dist-devel@blackfin.uclinux.org
Subject: [PATCH 00/10] Add support for GCC's __builtin_unreachable() and use
 it in BUG.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2009 23:54:44.0061 (UTC) FILETIME=[11D988D0:01CA3272]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Starting with version 4.5, GCC has a new built-in function called
__builtin_unreachable().  The function tells the compiler that control
flow will never reach that point.  Currently we trick the compiler by
putting in for(;;); but this has the disadvantage that extra code is
emitted for an endless loop.  For an i386 kernel using
__builtin_unreachable() results in an allyesconfig that is nearly 4000
bytes smaller.

This patch set adds support to compiler.h creating a
new macro usable in the kernel called unreachable().  If the compiler
lacks __builtin_unreachable(), it just expands to for(;;).

The x86 and MIPS patches I actually tested with a GCC-4.5 snapshot.
Lacking the ability to test the rest of the architectures, I just did
what seemed right without even trying to compile the kernel.

01/10 adds the compiler.h support, the rest of the patches retrofit
the various architecture BUG macros to use it instead of for(;;) or
while(1) loops.

I will reply with the 10 patches.

The architecture specific patches I will send to a smaller set of
people.

David Daney (10):
   Add support for GCC-4.5's __builtin_unreachable() to compiler.h
   x86: Convert BUG() to use unreachable()
   MIPS: Convert BUG() to use unreachable()
   s390: Convert BUG() to use unreachable()
   mn10300: Convert BUG() to use unreachable()
   parisc: Convert BUG() to use unreachable()
   powerpc: Convert BUG() to use unreachable()
   alpha: Convert BUG() to use unreachable()
   avr32: Convert BUG() to use unreachable()
   blackfin: Convert BUG() to use unreachable()

  arch/alpha/include/asm/bug.h    |    2 +-
  arch/avr32/include/asm/bug.h    |    2 +-
  arch/blackfin/include/asm/bug.h |    2 +-
  arch/mips/include/asm/bug.h     |    4 +---
  arch/mn10300/include/asm/bug.h  |    3 ++-
  arch/parisc/include/asm/bug.h   |    4 ++--
  arch/powerpc/include/asm/bug.h  |    2 +-
  arch/s390/include/asm/bug.h     |    2 +-
  arch/x86/include/asm/bug.h      |    4 ++--
  include/linux/compiler-gcc4.h   |   14 ++++++++++++++
  include/linux/compiler.h        |    5 +++++
  11 files changed, 31 insertions(+), 13 deletions(-)
