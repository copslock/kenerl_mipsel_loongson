Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 07:21:53 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.187]:45513
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226020AbVF1GVh>; Tue, 28 Jun 2005 07:21:37 +0100
Received: from pD952841F.dip0.t-ipconnect.de [217.82.132.31] (helo=gaspode.madsworld.lan)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML2Dk-1Dn9T12Qd0-0002XT; Tue, 28 Jun 2005 08:21:07 +0200
Received: from mad by gaspode.madsworld.lan with local (Exim 4.50)
	id 1Dn9T1-0002HI-LO; Tue, 28 Jun 2005 08:21:07 +0200
Date:	Tue, 28 Jun 2005 08:21:07 +0200
From:	Markus Dahms <mad@automagically.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
Message-ID: <20050628062107.GA8665@gaspode.automagically.de>
References: <20050627100757.GA27679@gaspode.automagically.de> <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl> <20050627141842.GA28236@gaspode.automagically.de> <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:896705dcda322f33ae3752a7fdb3dc09
Return-Path: <mad@automagically.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mad@automagically.de
Precedence: bulk
X-list: linux-mips

Hello again,

>> For the R4000 there are two other things I could try: console on newport
>> instead of serial port and a 32-bit kernel, which I only tried on the
>> R4600.
>  Well, I don't know what newport is, but if it's capable of providing 
> output that early, it'll do.

Newport is the most common graphics option for the Indy and there exists
a console driver for it. Luckily it outputs some more stuff than the
serial console:

| CPU revision is: 00000430
| FPU revision is: 00000500
| ...
| Checking for the multiply/shift bug... yes, workaround... no.
| kernel panic - not syncing: Reliable operation impossible!
| Configure for R4000 to enable the workaround.

I configured the kernel for R4X00. There are a few references to
CONFIG_CPU_R4000 in the source which doesn't seem to be a config
option anymore, but I couldn't find a workaround somewhere...

>> I'll also try the said patch (you're referring to "blast_scache nop ...",
>> do you?).
> Precisely.

doesn't change anything, neither for R4000PC nor for R4600PC.

Markus

-- 
Reactor error - core dumped!
