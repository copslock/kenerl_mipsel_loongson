Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA19891; Fri, 30 May 1997 10:35:33 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA15497 for linux-list; Fri, 30 May 1997 10:35:16 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA15456 for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 10:35:08 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA09677
	for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 10:35:03 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id TAA13819; Fri, 30 May 1997 19:31:14 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199705301731.TAA13819@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA18902; Fri, 30 May 1997 19:31:13 +0200
Subject: Re: ld error with 2.0.12-davem
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Fri, 30 May 1997 19:31:13 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199705301556.LAA16331@neon.ingenia.ca> from "Mike Shaver" at May 30, 97 11:56:55 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Using Ralf's gcc and binutils, and davem's cvs'd linux-2.0.12, I get:
> mips-linux-ld -static -N -e kernel_entry -mips2 -Ttext 0x88069000 \
>   arch/mips/kernel/head.o init/main.o init/version.o \
>   arch/mips/lib/lib.a /export/sgi-linux/kernel/mips-linux/lib/lib.a \
>   arch/mips/lib/lib.a -o vmlinux
> mips-linux-ld: vmlinux: Not enough room for program headers \
>   (allocated 3, need 4)
> mips-linux-ld: final link failed: Bad value
> make: *** [vmlinux] Error 1

This is typically caused by an inapropriate mixture of flags to ld,
especially -Ttext and a linker script.  In your case no linker script
has been specified using a -T option, so the buildtin script is being
used.  Just check the right script in <prefix>/mips-linux/lib/ldscripts/.

  Ralf
