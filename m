Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2003 10:43:34 +0100 (BST)
Received: from [IPv6:::ffff:80.88.36.193] ([IPv6:::ffff:80.88.36.193]:9903
	"EHLO witte.sonytel.be") by linux-mips.org with ESMTP
	id <S8225365AbTJWJnc>; Thu, 23 Oct 2003 10:43:32 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id h9N9hSQG001587;
	Thu, 23 Oct 2003 11:43:28 +0200 (MEST)
Date: Thu, 23 Oct 2003 11:43:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Compiler Problems in tlbex-r4k.S
In-Reply-To: <NHBBLBCCGMJFJIKAMKLHOEIJCBAA.ralf.roesch@rw-gmbh.de>
Message-ID: <Pine.GSO.4.21.0310231142250.27218-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 23 Oct 2003, [iso-8859-1] Ralf Rösch wrote:
> The latest update in tlbex-r4k.S (tag 2_4) produces
> following compiler errors on my machine:
> 
> mipsel-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/build/linux-2.4.22-rthal5g-s
> trom
> boli/include -I /build/linux-2.4.22-rthal5g-stromboli/include/asm/gcc -G
> 0 -mno-
> abicalls -fno-pic -pipe   -mcpu=r4600 -mips2 -Wa,--trap   -c -o tlbex-r4k.o
> tlbe
> x-r4k.S
> tlbex-r4k.S: Assembler messages:
> tlbex-r4k.S:179: Error: missing ')'
> tlbex-r4k.S:179: Error: missing ')'
> tlbex-r4k.S:179: Error: missing ')'
> tlbex-r4k.S:179: Error: illegal operands `and'
> tlbex-r4k.S:207: Error: missing ')'
> tlbex-r4k.S:207: Error: missing ')'
> tlbex-r4k.S:207: Error: missing ')'
> tlbex-r4k.S:207: Error: illegal operands `and'
> tlbex-r4k.S:243: Error: missing ')'
> tlbex-r4k.S:243: Error: missing ')'
> tlbex-r4k.S:243: Error: missing ')'
> ...
> 
> If I change the line 43 from:
> #define PTE_PAGE_SIZE	(1L << PTE_PAGE_SHIFT)
> to
> #define PTE_PAGE_SIZE	(1 << PTE_PAGE_SHIFT)
> the compiling is o.k.
> 
> Is that a compiler problem or an programming error ?

That's a programming error. The assembler doesn't know 1L, it needs plain 1.

Yes, it makes life hard, if you want to share your definitions between the
C compiler and the assembler.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
