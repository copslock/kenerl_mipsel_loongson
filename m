Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 01:54:32 +0000 (GMT)
Received: from mail007.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.55]:37536
	"EHLO mail007.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225536AbUARByc>; Sun, 18 Jan 2004 01:54:32 +0000
Received: from korath.adamsrealm.net.au (c210-49-87-133.rochd3.qld.optusnet.com.au [210.49.87.133])
	by mail007.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i0I1sQB09579
	for <linux-mips@linux-mips.org>; Sun, 18 Jan 2004 12:54:27 +1100
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
Date: Sun, 18 Jan 2004 11:54:22 +1000
User-Agent: KMail/1.5
References: <200401171711.34964@korath> <20040117163355.GE5288@linux-mips.org> <200401181119.15234@korath>
In-Reply-To: <200401181119.15234@korath>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401181154.22007@korath>
Return-Path: <a.nielsen@optushome.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@optushome.com.au
Precedence: bulk
X-list: linux-mips

> I'll try an older version of the binutils and see if that fixes it.

Well, I downgraded to binutils 2.13.2.1 and it got past the -mcpu error, but 
now I get this error instead (I'm compiling a stock 2.6.0 kernel with gcc 
2.95.3):

include/asm/sgidefs.h:18: #error Use a Linux compiler or give up.

followed by hundreds of other various errors.  So I'm stuck again ;-)  Any 
ideas?  I'm guessing I need to get a newer compiler...?

Cheers,
Adam.
