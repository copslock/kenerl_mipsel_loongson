Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 01:19:25 +0000 (GMT)
Received: from mail012.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.66]:16097
	"EHLO mail012.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225214AbUARBTY>; Sun, 18 Jan 2004 01:19:24 +0000
Received: from korath.adamsrealm.net.au (c210-49-87-133.rochd3.qld.optusnet.com.au [210.49.87.133])
	by mail012.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i0I1JJS14381
	for <linux-mips@linux-mips.org>; Sun, 18 Jan 2004 12:19:20 +1100
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
Date: Sun, 18 Jan 2004 11:19:15 +1000
User-Agent: KMail/1.5
References: <200401171711.34964@korath> <200401171736.49803@korath> <20040117163355.GE5288@linux-mips.org>
In-Reply-To: <20040117163355.GE5288@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401181119.15234@korath>
Return-Path: <a.nielsen@optushome.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@optushome.com.au
Precedence: bulk
X-list: linux-mips

> In your other mail you mentioned you were using gcc 1.1.2; I recommend
> gcc 2.95.4 instead.  gcc 1.1.2 needs a few workarounds in the kernel
> source in particular for 64-bit kernels and I've removed all of them
> around 2003-05-16 (in the Linux 2.4.20 age) so I'm not sure if egcs 1.1.2
> will still work.  Sympthom are compiler core dumps.  Newer doesn't harm ...

Yes, I saw that in the kernel docs but I tried it anyway since that's the 
version used in the FAQ.  I ended up getting another error though, and 
upgrading to gcc 2.95.3 (couldn't find .4) didn't help:

/usr/mips-linux/bin/as: unrecognized option `-mcpu=r3000'

I saw that this option was removed a while back, so I guess downgrading the 
binutils is the only way to go (or upgrading gcc, but I got a ton of errors 
compiling 3.3.2 so I guess that doesn't work...)

I'll try an older version of the binutils and see if that fixes it.  Thanks 
for your help!

Cheers,
Adam.
