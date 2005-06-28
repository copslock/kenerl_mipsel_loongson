Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 11:21:06 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.187]:50145
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226038AbVF1KUp>; Tue, 28 Jun 2005 11:20:45 +0100
Received: from pD952841F.dip0.t-ipconnect.de [217.82.132.31] (helo=gaspode.madsworld.lan)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwpI-1DnDCQ2TTs-0006v4; Tue, 28 Jun 2005 12:20:14 +0200
Received: from mad by gaspode.madsworld.lan with local (Exim 4.50)
	id 1DnDCQ-0002mg-Bk; Tue, 28 Jun 2005 12:20:14 +0200
Date:	Tue, 28 Jun 2005 12:20:14 +0200
From:	Markus Dahms <mad@automagically.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
Message-ID: <20050628102013.GA10442@gaspode.automagically.de>
References: <20050627100757.GA27679@gaspode.automagically.de> <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl> <20050627141842.GA28236@gaspode.automagically.de> <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl> <20050628062107.GA8665@gaspode.automagically.de> <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:896705dcda322f33ae3752a7fdb3dc09
Return-Path: <mad@automagically.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mad@automagically.de
Precedence: bulk
X-list: linux-mips

Hello Maciej,

[R4000 in 64-bit mode]

I propably won't find the time to build a patched toolchain for R4000,
so my 64-bit experiments will concentrate on the R4600.

The R4000 now successfully boots to prompt using a 32-bit kernel. I'll
try to enable "Support for 64-bit physical address space" in the next
kernel build ;).

[R4600 tlbex.c patch]

This doesn't seem to be enough. The patch applies almost cleanly on
current CVS (offset -1 line), but the resulting kernel (I tried 64
and 32-bit) still stops after "INIT: ...".

Markus
