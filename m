Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 14:08:12 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:24004 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8226047AbVF1NH4>; Tue, 28 Jun 2005 14:07:56 +0100
Received: from vivi.cc.vt.edu (IDENT:mirapoint@[10.1.1.12])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j5SD4PrU017517;
	Tue, 28 Jun 2005 09:06:46 -0400
Received: from [192.168.1.2] (68-232-96-93.chvlva.adelphia.net [68.232.96.93])
	by vivi.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id DMW15908 (AUTH spbecker);
	Tue, 28 Jun 2005 09:03:35 -0400 (EDT)
Message-ID: <42C14AA7.7090005@gentoo.org>
Date:	Tue, 28 Jun 2005 09:03:35 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050625)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Markus Dahms <mad@automagically.de>, linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
References: <20050627100757.GA27679@gaspode.automagically.de> <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl> <20050627141842.GA28236@gaspode.automagically.de> <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl> <20050628062107.GA8665@gaspode.automagically.de> <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl> <20050628102013.GA10442@gaspode.automagically.de> <42C14151.5050209@gentoo.org> <Pine.LNX.4.61L.0506281339080.13758@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0506281339080.13758@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

> It's either not 2.6.11 or it must be something platform-specific (here 
> meaning the specific CPU model and/or system type) as 2.6.12-rc1 as of the 
> end of March seems to be rock-solid running 64-bit on the BCM1250.  Or 
> perhaps SMP works and only UP does not. ;-)
> 

Yeah, it is ip22 specific.  I have been running 64-bit ip32 kernels
(R5000) from the same checkouts with no problems.

-Steve
