Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 06:46:14 +0000 (GMT)
Received: from mail012.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.66]:37601
	"EHLO mail012.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225228AbUARGqN>; Sun, 18 Jan 2004 06:46:13 +0000
Received: from korath.adamsrealm.net.au (c210-49-87-133.rochd3.qld.optusnet.com.au [210.49.87.133])
	by mail012.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i0I6k9S17922
	for <linux-mips@linux-mips.org>; Sun, 18 Jan 2004 17:46:09 +1100
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
Date: Sun, 18 Jan 2004 16:46:04 +1000
User-Agent: KMail/1.5
References: <200401171711.34964@korath> <200401181510.35686@korath> <400A1B5F.6010307@gentoo.org>
In-Reply-To: <400A1B5F.6010307@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401181646.04740@korath>
Return-Path: <a.nielsen@optushome.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@optushome.com.au
Precedence: bulk
X-list: linux-mips

> I'd recommend the following:
> binutils-2.14.90.0.7 (or you can try the latest .8 release, it has some
> more mips fixes in it)
> ...
> gcc-3.3.2

Thanks for all the info!  Well, I tried building gcc-3.3.2 with your options 
and that worked (hooray!) but I couldn't find binutils-2.14.90.0.7, the 
closest I could see was 2.14 so I used that.  It all compiled ok, but now 
when I go to compile the kernel I get this error:

cc1: error: invalid option `cpu=r3000'

If I copy the command line and change -mcpu to -march then it works fine, but 
this isn't happening automatically for some reason.  Any ideas?  (I tried 
downgrading to binutils-2.13.xxx but it still gave the error, so I'm guessing 
it's a gcc problem - oh how much easier life would be if they didn't remove 
the -mcpu option somewhere along the way ;-))

Cheers,
Adam.
