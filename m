Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 15:19:33 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.183]:40959
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225956AbVF0OTR>; Mon, 27 Jun 2005 15:19:17 +0100
Received: from pD95289E9.dip0.t-ipconnect.de [217.82.137.233] (helo=gaspode.madsworld.lan)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML29c-1DmuRe3daL-0007xb; Mon, 27 Jun 2005 16:18:42 +0200
Received: from mad by gaspode.madsworld.lan with local (Exim 4.50)
	id 1DmuRe-0007MY-Ei; Mon, 27 Jun 2005 16:18:42 +0200
Date:	Mon, 27 Jun 2005 16:18:42 +0200
From:	Markus Dahms <mad@automagically.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
Message-ID: <20050627141842.GA28236@gaspode.automagically.de>
References: <20050627100757.GA27679@gaspode.automagically.de> <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:896705dcda322f33ae3752a7fdb3dc09
Return-Path: <mad@automagically.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mad@automagically.de
Precedence: bulk
X-list: linux-mips

>> My experiments: Indy with R4600PC (133MHz) boots to userspace
>> | INIT: version 2.86 booting
>> and dies then :(. The same machine, but with a R4000PC (100MHz)
>  Hmm, it might be a problem with TLB handlers that have been changed to be 
> built at the run time.  Perhaps the R4600 isn't handled right as a result.  
> What's the CPU revision ID? -- it's printed right at the beginning.

| CPU revision is: 00002020
| FPU revision is: 00002020
| ...
| Synthesized TLB refill handler (30 instructions).
| Synthesized TLB load handler fastpath (43 instructions).
| Synthesized TLB store handler fastpath (43 instructions).
| Synthesized TLB modify handler fastpath (42 instructions).

the TLB stuff, if it's of interest...

| ...
| Calibrating system timer... warning: timer counts differ, retrying...\
| disagreement, using average... 44500 [89.0000 MHz CPU]
| Using 44.500 MHz high precision timer.

this is strange, too. It's a 133MHz CPU as kernel 2.4.x correctly
recognizes.

For the R4000 there are two other things I could try: console on newport
instead of serial port and a 32-bit kernel, which I only tried on the
R4600.
I'll also try the said patch (you're referring to "blast_scache nop ...", do
you?).

Markus

-- 
No RISC - No fun!
