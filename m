Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 05:10:53 +0000 (GMT)
Received: from mail018.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.72]:36033
	"EHLO mail018.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225230AbUARFKx>; Sun, 18 Jan 2004 05:10:53 +0000
Received: from korath.adamsrealm.net.au (c210-49-87-133.rochd3.qld.optusnet.com.au [210.49.87.133])
	by mail018.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i0I5Ae506746;
	Sun, 18 Jan 2004 16:10:41 +1100
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: Eric Christopher <echristo@redhat.com>
Subject: Re: Trouble compiling MIPS cross-compiler
Date: Sun, 18 Jan 2004 15:10:35 +1000
User-Agent: KMail/1.5
Cc: linux-mips@linux-mips.org
References: <200401171711.34964@korath> <200401181119.15234@korath> <1074399252.3602.8.camel@dzur.sfbay.redhat.com>
In-Reply-To: <1074399252.3602.8.camel@dzur.sfbay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401181510.35686@korath>
Return-Path: <a.nielsen@optushome.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@optushome.com.au
Precedence: bulk
X-list: linux-mips

> You do? What errors? How'd you build the toolchain?

I was just following the linux-mips.org FAQ for building a cross compiler.  
The errors were something to do with missing headers (pthread.h among others) 
so I tried configuring gcc with --disable-threads as suggested in a post 
Google found, and so far that seems to be working...except just as I wrote 
that it came up with this:

/usr/mips-linux/bin/ld: cannot open crti.o: No such file or directory

Now I see why it says on the FAQ that building a cross compiler has always 
been the hardest step - it's certainly a lot harder than you'd expect (at 
least for a cross-compiler newbie like me ;-))  I was thinking it would be a 
simple matter of compiling a few programs in a certain order and that'd be 
it, but it seems that there are huge differences between versions - the 
instructions use ecgs-1.1.2 and binutils-2.13.2.1, but to compile linux-2.6.0 
you need newer than ecgs-1.1.2, but using gcc-3.x means upgrading to 
binutils-2.14, but then when you've done that gcc-3.x won't compile so you 
try gcc-2.95.3 instead, but that means you have to go back to 
binutils-2.13.2.1 but then gcc-2.95.3 is still too old to compile the kernel, 
so you *need* gcc-3.x but that won't compile...grrr!!! ;-)

Cheers,
Adam.
