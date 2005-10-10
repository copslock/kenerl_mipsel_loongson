Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2005 14:19:11 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:49170 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3465557AbVJJNSv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Oct 2005 14:18:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 39EBCE1C9C; Mon, 10 Oct 2005 15:18:42 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13447-02; Mon, 10 Oct 2005 15:18:42 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 011C8E1C93; Mon, 10 Oct 2005 15:18:42 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j9ADIjrb031088;
	Mon, 10 Oct 2005 15:18:45 +0200
Date:	Mon, 10 Oct 2005 14:18:52 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Fuxin Zhang <fxzhang@ict.ac.cn>,
	Ralf Baechle <ralf@linux-mips.org>,
	Carlo Perassi <carlo@linux.it>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: rfc about an uncommented string
In-Reply-To: <Pine.LNX.4.62.0510101344450.5402@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.55.0510101407310.18063@blysk.ds.pg.gda.pl>
References: <20051009134106.GB9091@voyager> <20051010111149.GC2661@linux-mips.org>
 <434A4F27.6010301@ict.ac.cn> <Pine.LNX.4.62.0510101327500.5402@numbat.sonytel.be>
 <434A53D3.1080106@ict.ac.cn> <Pine.LNX.4.62.0510101344450.5402@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87/1125/Mon Oct 10 11:16:52 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 10 Oct 2005, Geert Uytterhoeven wrote:

> > It is not my code. But anyway the board has more than one discontinuous
> > io ranges(0xb4000000 is in fact for it8712 superio and legacy ios,
> 
> So 0xb4000000 is the base for ISA and PCI I/O port accesses, right? Hence if
> mips_io_port_base is 0xb4000000, all drivers for PCI (and ISA) expansion cards
> that use inb() and friends will work.
> 
> > it8172's system registers are located around 0xb8000000, while others
> > begins at 0xb4010000).
> 
> So these can use ITE8172-specific access macros.

 IOW, MIPS has no concept of I/O space in the CPU, so whatever is decoded
as I/O cycles to PCI/EISA/ISA is I/O and everything else is MMIO.  In
particular I/O spaces are private to their respective buses -- if there
are more than one disjoint PCI/EISA/ISA buses in a given system, then each
of them can have its private 4GB or 16MB (or whatever) space reserved for
I/O cycles.  If there is only one PCI/EISA/ISA bus, then mips_io_port_base
should refer to the base address where decoding as I/O cycles for that bus
starts, holding an appropriate virtual mapping, typically obtained with
ioremap().

  Maciej
