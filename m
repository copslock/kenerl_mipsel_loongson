Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 18:05:15 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.186]:16892
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226061AbVF1REy>; Tue, 28 Jun 2005 18:04:54 +0100
Received: from pD9528876.dip0.t-ipconnect.de [217.82.136.118] (helo=gaspode.madsworld.lan)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwh2-1DnJVb1EnZ-0002qx; Tue, 28 Jun 2005 19:04:27 +0200
Received: from mad by gaspode.madsworld.lan with local (Exim 4.50)
	id 1DnJVa-0001Mg-0j; Tue, 28 Jun 2005 19:04:26 +0200
Date:	Tue, 28 Jun 2005 19:04:25 +0200
From:	Markus Dahms <mad@automagically.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
Message-ID: <20050628170425.GA5189@gaspode.automagically.de>
References: <20050627100757.GA27679@gaspode.automagically.de> <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl> <20050627141842.GA28236@gaspode.automagically.de> <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl> <20050628062107.GA8665@gaspode.automagically.de> <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl> <20050628102013.GA10442@gaspode.automagically.de> <Pine.LNX.4.61L.0506281204190.13758@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506281204190.13758@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:896705dcda322f33ae3752a7fdb3dc09
Return-Path: <mad@automagically.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mad@automagically.de
Precedence: bulk
X-list: linux-mips

Hello Maciej,

>> [R4600 tlbex.c patch]
>> This doesn't seem to be enough.
> Well, there can be something else.  But to be sure I haven't missed 
> anything in these TLB handlers, could you please generate the dumps I 
> mentioned yesterday and send them to me?  You need to uncomment the 
> definition of DEBUG_TLB at the top of arch/mips/mm/tlbex.c for that.

I think I found the trick. Just following the hint that the R4600
is similar to the R5000 I added CPU_R4600 to build_tlb_probe_entry().

After that I got a prompt :-). Everything worked fine so far...

The next problem appeared on shutdown, where I got a kernel panic
(as the R4000 does with the 32-bit kernel, too) - something related
too the UART/serial console I suspect. As it's not on serial output
I need to find a way to get it without pencil and paper ;).

If you have further things to try, just send patches :)

Markus
