Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 02:22:18 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:20130 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225236AbTGVBWQ>;
	Tue, 22 Jul 2003 02:22:16 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h6M1M91W010790
	for <linux-mips@linux-mips.org>; Tue, 22 Jul 2003 03:22:09 +0200 (MEST)
Date: Tue, 22 Jul 2003 03:22:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20030722005641Z8225235-1272+3651@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0307220321300.27391-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jul 2003 ralf@linux-mips.org wrote:
> Modified files:
> 	arch/mips/mm   : Makefile c-sb1.c pg-r3k.c 
> 	arch/mips/mm-32: pg-r4k.S 
> 	arch/mips/mm-64: init.c 
> Added files:
> 	arch/mips/mm   : pgtable-32.c pgtable-64.c 

Euh, shouldn't these be in mm-32 and mm-64 then?

> Log message:
> 	Move pgd_init and pmd_init to their own files.

Gr{oetje,eeting}s,

						Geert, reading mail, not code

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
