Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA17173; Fri, 30 May 1997 10:21:42 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA09829 for linux-list; Fri, 30 May 1997 10:21:25 -0700
Received: from odin.corp.sgi.com (odin.corp.sgi.com [192.26.51.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA09800 for <linux@engr.sgi.com>; Fri, 30 May 1997 10:21:22 -0700
Received: from sgi.sgi.com by odin.corp.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/951211.SGI)
	for <linux@engr.sgi.com> id JAA05445; Fri, 30 May 1997 09:05:38 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA15727
	for <linux@engr.sgi.com>; Fri, 30 May 1997 09:05:35 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id LAA16331 for linux@engr.sgi.com; Fri, 30 May 1997 11:56:55 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705301556.LAA16331@neon.ingenia.ca>
Subject: ld error with 2.0.12-davem
To: linux@cthulhu.engr.sgi.com
Date: Fri, 30 May 1997 11:56:55 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Using Ralf's gcc and binutils, and davem's cvs'd linux-2.0.12, I get:
mips-linux-ld -static -N -e kernel_entry -mips2 -Ttext 0x88069000 \
  arch/mips/kernel/head.o init/main.o init/version.o \
  arch/mips/lib/lib.a /export/sgi-linux/kernel/mips-linux/lib/lib.a \
  arch/mips/lib/lib.a -o vmlinux
mips-linux-ld: vmlinux: Not enough room for program headers \
  (allocated 3, need 4)
mips-linux-ld: final link failed: Bad value
make: *** [vmlinux] Error 1

I've patched the Makefiles to use mips-linux instead of mipsel-linux,
but that's about it.

Anyone know enough about gnu ld to help me with this?

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                 Ignore the man behind the curtain.                  
#>                                                                     
#> "And then I realized that it never should have worked in the first  
#>  place.  Thus, it would not work again until rewritten." --- Anon.  
