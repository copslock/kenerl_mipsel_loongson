Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 07:44:11 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:18623 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21103053AbZA3HoI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Jan 2009 07:44:08 +0000
Received: (qmail 12436 invoked by uid 1000); 30 Jan 2009 08:44:07 +0100
Date:	Fri, 30 Jan 2009 08:44:07 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: GCC-4.3.3 sillyness
Message-ID: <20090130074407.GA12368@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

Can't build kernel because gcc-4.3.3 comes up with this gem:

  CC      arch/mips/kernel/traps.o
cc1: warnings being treated as errors
/linux-2.6.git/arch/mips/kernel/traps.c: In function 'set_uncached_handler':
/linux-2.6.git/arch/mips/kernel/traps.c:1599: error: format not a string literal and no format arguments

The fastest fix is the patch below, but I don't know whether it is
the right thing to do.

Thanks!
	Manuel Lauss

---

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 7378b91..70ddf83 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -78,7 +78,7 @@ all-$(CONFIG_BOOT_ELF64)	:= $(vmlinux-64)
 # machines may also.  Since BFD is incredibly buggy with respect to
 # crossformat linking we rely on the elf2ecoff tool for format conversion.
 #
-cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe
+cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe -Wno-format
 cflags-y			+= -msoft-float
 LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
 MODFLAGS			+= -mlong-calls
