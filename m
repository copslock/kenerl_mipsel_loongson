Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2004 14:11:38 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:37390 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225235AbUJONLb>; Fri, 15 Oct 2004 14:11:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 88731E1C96; Fri, 15 Oct 2004 15:11:22 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19921-08; Fri, 15 Oct 2004 15:11:22 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2D53CE1C65; Fri, 15 Oct 2004 15:11:22 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9FDBVcX007244;
	Fri, 15 Oct 2004 15:11:32 +0200
Date: Fri, 15 Oct 2004 14:11:24 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Alec Voropay <a.voropay@vmb-service.ru>
Cc: linux-mips@linux-mips.org
Subject: Re: JAZZ architecture
In-Reply-To: <00c501c4b2b0$3a4a42b0$1701a8c0@vmbservice.ru>
Message-ID: <Pine.LNX.4.58L.0410151351540.11787@blysk.ds.pg.gda.pl>
References: <00c501c4b2b0$3a4a42b0$1701a8c0@vmbservice.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 15 Oct 2004, Alec Voropay wrote:

>  It seems, kernel API was changed. What is
> spin_unlock_restoreirq()
> spin_lock_saveirq()

 I guess spin_unlock_irqrestore() and spin_lock_irqsave(), respectively.  
These are typos, not API changes.  This shows how popular the platform is
-- they have been there for a year and nobody noticed.

> =====
> arch/mips/jazz/jazz.o(.bss+0x10): multiple definition of
> `board_time_init'
> arch/mips/kernel/kernel.o(.bss+0x77c): first defined here
> arch/mips/mm/mm.o(.text+0x5cc): In function `free_initmem':
> : undefined reference to `prom_free_prom_memory'
> arch/mips/jazz/jazz.o(.text+0x1fc): In function `ll_count':
> : undefined reference to `return'
> arch/mips/jazz/jazz.o(.text+0x344): In function `vdma_alloc':
> : undefined reference to `spin_unlock_restoreirq'
> arch/mips/jazz/jazz.o(.text+0x35c): In function `vdma_alloc':
> : undefined reference to `spin_lock_saveirq'
> arch/mips/jazz/jazz.o(.text+0x498): In function `vdma_alloc':
> : undefined reference to `spin_unlock_restoreirq'
> arch/mips/jazz/jazz.o(.text.init+0x2c8): In function `jazz_setup':
> : undefined reference to `irq_setup'
> arch/mips/jazz/jazz.o(.text.init+0x2cc): In function `jazz_setup':
> : undefined reference to `irq_setup'
> arch/mips/jazz/jazz.o(.text.init+0x368): In function `jazz_setup':
> : undefined reference to `dummy_con'
> arch/mips/jazz/jazz.o(.text.init+0x36c): In function `jazz_setup':
> : undefined reference to `dummy_con'
> arch/mips/arc/arclib.a(init.o)(.text.init+0x88): In function
> `prom_init':
> : undefined reference to `prom_meminit'
> arch/mips/arc/arclib.a(arc_con.o)(.text+0x44): In function
> `prom_console_write':
> : undefined reference to `prom_putchar'
> arch/mips/arc/arclib.a(arc_con.o)(.text+0x5c): In function
> `prom_console_write':
> : undefined reference to `prom_putchar'
> arch/mips/lib/lib.a(promlib.o)(.text+0x54): In function `prom_printf':
> : undefined reference to `prom_putchar'
> arch/mips/lib/lib.a(promlib.o)(.text+0x68): In function `prom_printf':
> : undefined reference to `prom_putchar'
> make: *** [vmlinux] Error 1

 These should be relatively easy to fix.

  Maciej
