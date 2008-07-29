Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 08:10:55 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:50566
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023139AbYG2HKr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 08:10:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6T79irQ003301;
	Tue, 29 Jul 2008 08:10:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6T79iMx003298;
	Tue, 29 Jul 2008 08:09:44 +0100
Date:	Tue, 29 Jul 2008 08:09:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Is the new generic KGDB patch in upstream-akpm?
Message-ID: <20080729070944.GC1876@linux-mips.org>
References: <64660ef00807250921h75ec4e48v92ef964e1c1185f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64660ef00807250921h75ec4e48v92ef964e1c1185f4@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 25, 2008 at 05:21:33PM +0100, Daniel Laird wrote:

> I am trying to respin the patch to add pnx833x support to linux 2.6.27.
> I wanted to patch against the new generic kernel KGDB patch.
> So I removed gdb-hook etc.
> 
> However when I compile I get
> arch/mips/kernel/built-in.o: In function `early_console_write':
> early_printk.c:(.init.text+0x1450): undefined reference to `prom_putchar'
> early_printk.c:(.init.text+0x1450): relocation truncated to fit:
> R_MIPS_26 against `prom_putchar'
> early_printk.c:(.init.text+0x145c): undefined reference to `prom_putchar'
> early_printk.c:(.init.text+0x145c): relocation truncated to fit:
> R_MIPS_26 against `prom_putchar'
> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> These functions were defined in my gdb-hook.c.  Do I need to move
> these somewhere else now? Or just not support EARLY_PRINTK etc.

Bad choice - early printk has no relation whatsoever to GDB - though both
might end bitbanging the same serial, so early printk code should live
in a different file.

  Ralf
