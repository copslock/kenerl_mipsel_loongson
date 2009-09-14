Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2009 23:51:36 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9324 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S2097347AbZINVvV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2009 23:51:21 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4aaebac20000>; Mon, 14 Sep 2009 14:50:58 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Sep 2009 14:50:59 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Sep 2009 14:50:59 -0700
Message-ID: <4AAEBAC2.1050905@caviumnetworks.com>
Date:	Mon, 14 Sep 2009 14:50:58 -0700
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
	uclinux-dist-devel@blackfin.uclinux.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arch@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: [PATCH 00/11] Add support for GCC's __builtin_unreachable() and use
 it in BUG (v2).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2009 21:50:59.0414 (UTC) FILETIME=[72114F60:01CA3585]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

When I sent the first version, I had not realized that Roland McGrath
had only a day or two earlier submitted a very similar patch (although
one that only fixed up the x86 case).

I have been working on this quite a while now, starting with adding
the required support to GCC, so with an eye towards finishing it up I
have this new version.

 From the announcement of the first version:

Starting with version 4.5, GCC has a new built-in function called
__builtin_unreachable().  The function tells the compiler that control
flow will never reach that point.  Currently we trick the compiler by
putting in for(;;); but this has the disadvantage that extra code is
emitted for an endless loop.  For an i386 kernel using
__builtin_unreachable() results in an defaultconfig that is nearly 4000
bytes smaller.

This patch set adds support to compiler.h creating a
new macro usable in the kernel called unreachable().  If the compiler
lacks __builtin_unreachable(), it just expands to for(;;).

The x86 and MIPS patches I actually tested with a GCC-4.5 snapshot.
Lacking the ability to test the rest of the architectures, I just did
what seemed right without even trying to compile the kernel.

For version 2:

I fixed a couple of checkpatch issues, and simplified the
unreachable() macro for the pre-GCC-4.5 case (as suggested by Richard
Henderson).  Also several Acked-by: were added.

New in this version (as suggested by Ingo Molnar) I added 11/11 which
uses unreachable() in asm-generic/bug.h for !CONFIG_BUG case.  This
one may be a little controversial as it will end up making code
slightly larger when !CONFIG_BUG and you are using a pre-GCC-4.5
compiler.

I will reply with the 11 patches.

David Daney (11):
   Add support for GCC-4.5's __builtin_unreachable() to compiler.h (v2)
   x86: Convert BUG() to use unreachable()
   MIPS: Convert BUG() to use unreachable()
   s390: Convert BUG() to use unreachable()
   mn10300: Convert BUG() to use unreachable()
   parisc: Convert BUG() to use unreachable()
   powerpc: Convert BUG() to use unreachable()
   alpha: Convert BUG() to use unreachable()
   avr32: Convert BUG() to use unreachable()
   blackfin: Convert BUG() to use unreachable()
   Use unreachable() in asm-generic/bug.h for !CONFIG_BUG case.

  arch/alpha/include/asm/bug.h    |    3 ++-
  arch/avr32/include/asm/bug.h    |    2 +-
  arch/blackfin/include/asm/bug.h |    2 +-
  arch/mips/include/asm/bug.h     |    4 +---
  arch/mn10300/include/asm/bug.h  |    3 ++-
  arch/parisc/include/asm/bug.h   |    4 ++--
  arch/powerpc/include/asm/bug.h  |    2 +-
  arch/s390/include/asm/bug.h     |    2 +-
  arch/x86/include/asm/bug.h      |    4 ++--
  include/asm-generic/bug.h       |    4 ++--
  include/linux/compiler-gcc4.h   |   14 ++++++++++++++
  include/linux/compiler.h        |    5 +++++
  12 files changed, 34 insertions(+), 15 deletions(-)
