Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 08:04:44 +0000 (GMT)
Received: from mail009.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.64]:29338
	"EHLO mail009.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225228AbUARIEn>; Sun, 18 Jan 2004 08:04:43 +0000
Received: from korath.adamsrealm.net.au (c210-49-87-133.rochd3.qld.optusnet.com.au [210.49.87.133])
	by mail009.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i0I84a129645
	for <linux-mips@linux-mips.org>; Sun, 18 Jan 2004 19:04:39 +1100
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
Date: Sun, 18 Jan 2004 18:04:31 +1000
User-Agent: KMail/1.5
References: <200401171711.34964@korath> <200401181646.04740@korath> <400A3353.6050903@gentoo.org>
In-Reply-To: <400A3353.6050903@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401181804.31114@korath>
Return-Path: <a.nielsen@optushome.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@optushome.com.au
Precedence: bulk
X-list: linux-mips

> As for the kernel, -mcpu was deprecated in gcc-3.2.x, and totally 
> removed in gcc-3.3.x.  You'll want to use the -march option (or 
> -mips[1234] as a synonym), although if you use a recent kernel source 
> tree off linux-mips anoncvs, selecting the right CPU/Machinetype in 
> menuconfig will supply the proper -march/-mipsX commands to the 
> compiler.

Oh ok then - so what should I do to actually compile a MIPS kernel?  I'd 
rather not have to download an entirely separate kernel source, so should I 
just go back to gcc-3.1.1 that supports -mcpu?

Will kernel 2.6.1 or whatever's next work properly in this respect?  I realise 
that there are plenty of valid reasons for removing -mcpu, but it does create 
a big headache for us users, who just want the darn thing to 'go' ;-)

> You'll also want to pass something like this:
> make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu- <target>

Oh ok - yes, I sort of guessed how to do this as it wasn't written anywhere, 
and I used "mips-linux" for everything so all should be well there.

At any rate, I think I'll have to call it a day - it's way too much of a 
hassle just to get a working MIPS cross-compiler, and with all the hoops you 
have to jump through I haven't got any patience left :-(

Thanks for all your help everyone,
Adam.
