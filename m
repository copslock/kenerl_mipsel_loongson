Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2005 12:51:54 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:50461 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133681AbVJJLvg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Oct 2005 12:51:36 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9ABpHpx025975;
	Mon, 10 Oct 2005 12:51:17 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9ABpF6n025974;
	Mon, 10 Oct 2005 12:51:15 +0100
Date:	Mon, 10 Oct 2005 12:51:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Fuxin Zhang <fxzhang@ict.ac.cn>, Carlo Perassi <carlo@linux.it>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: rfc about an uncommented string
Message-ID: <20051010115115.GD2661@linux-mips.org>
References: <20051009134106.GB9091@voyager> <20051010111149.GC2661@linux-mips.org> <434A4F27.6010301@ict.ac.cn> <Pine.LNX.4.62.0510101327500.5402@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510101327500.5402@numbat.sonytel.be>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 10, 2005 at 01:28:43PM +0200, Geert Uytterhoeven wrote:

> > I don't read the 2.6 code,but it seems it remains the same as the copy
> > in 2.4(except that #ifdef changes).I can't see why the code is broken?
> > In case you mean the ioport address,mips_io_port_base for that board is
> > 0xa0000000, inb(0x14000060) is reading from 0xb4000060, which is correct
> > for it.
> 
> Shouldn't mips_io_port_base be 0xb4000000 for your board, so inb(0x60) looks
> more like a PC-style keyboard controller access?

Exactly.

Anyway - what this did actually demonstrate is that at least there's
no 2.6 user of the IT8172.

  Ralf
