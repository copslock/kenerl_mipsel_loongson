Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 18:09:31 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:20677 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20029631AbXK0SJW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Nov 2007 18:09:22 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 96473400DE;
	Tue, 27 Nov 2007 19:09:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 3Uio9CAjD1bW; Tue, 27 Nov 2007 19:09:09 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 27AC9401BE;
	Tue, 27 Nov 2007 19:08:23 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lARI8R96011318;
	Tue, 27 Nov 2007 19:08:28 +0100
Date:	Tue, 27 Nov 2007 18:08:15 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Luis R. Rodriguez" <mcgrof@gmail.com>
cc:	loswillios <loswillios@gmail.com>, kyle@mcmartin.ca,
	linux-wireless@vger.kernel.org, developers@islsm.org,
	linux-mips@linux-mips.org
Subject: Re: prism54 - MIPS do_be() trap caught
In-Reply-To: <43e72e890711270917o309441a0g99ac435a629b6d5e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0711271802340.31004@blysk.ds.pg.gda.pl>
References: <43e72e890711270917o309441a0g99ac435a629b6d5e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4932/Tue Nov 27 14:14:26 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 27 Nov 2007, Luis R. Rodriguez wrote:

> > root@OpenWrt:/# iwlist eth1 scanning
> > Data bus error, epc == c011518c, ra == c01146cc
> > Oops[#1]:
> > Cpu 0
> > $ 0   : 00000000 1000b800 abad0000 00000032
> > $ 4   : 00000001 c00c8000 00000013 00000001
> > $ 8   : 0000003c 80102bd4 ffffffff 81e2101c
> > $12   : ffffffff 00000580 2ab8af24 00000498
> > $16   : 81e21680 000000fa 81339380 0000004a
> > $20   : 81339380 00000000 a1e80000 81339000
> > $24   : 00000000 2abd55e0
> > $28   : 813b4000 813b5cc8 00000019 c01146cc
> > Hi    : 00000000
> > Lo    : 00000580
> > epc   : c011518c     Not tainted
> > ra    : c01146cc Status: 1000b803    KERNEL EXL IE
> > Cause : 0000001c
> > PrId  : 00029007
> 
> I can see that this comes from arch/mips/kernel/traps.c do_be() but I
> fail to see when this is triggered. Perhaps someone from linux-mips
> might be able to help shed some light here. I tried looking into the
> stack trace before but I couldn't find any code that made me suspect
> of a possible big endian problem (it seems that may be the problem?).
> The stack trace used to look like this:
[...]
> > Code: 10800014  24020002  3c02abad <8ca30010> 3442face  1462000f
> > 24020008  08045470  00000000
> > Segmentation fault

 Well, a data bus error is caused by external hardware signalling a 
transaction error on a data read operation (there is an instruction bus 
error counterpart).  A possible reason is a data parity or irrecoverable 
ECC error or a bus timeout when accessing an unpopulated location.  In 
this case the faulting instruction is 8ca30010, which is

	lw	v1,16(a1)

and a1 is 0xc00c8000 above.  I guess you need to find out where the 
mapping for this virtual address is established and what physical address 
and thus device (if any at all) it corresponds to.

  Maciej
