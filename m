Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2004 07:37:05 +0000 (GMT)
Received: from mail008.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.212]:33221
	"EHLO mail008.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225216AbUAQHhF>; Sat, 17 Jan 2004 07:37:05 +0000
Received: from korath.adamsrealm.net.au (c210-49-87-133.rochd3.qld.optusnet.com.au [210.49.87.133])
	by mail008.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i0H7ard10318
	for <linux-mips@linux-mips.org>; Sat, 17 Jan 2004 18:36:58 +1100
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
Date: Sat, 17 Jan 2004 17:36:49 +1000
User-Agent: KMail/1.5
References: <200401171711.34964@korath>
In-Reply-To: <200401171711.34964@korath>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171736.49803@korath>
Return-Path: <a.nielsen@optushome.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@optushome.com.au
Precedence: bulk
X-list: linux-mips

> as: unrecognized option `-O2'

Ok, I just worked out the problem - or at least I discovered a workaround.  If 
I run:

	./configure --prefix=/usr/local [...]

then I get the error during compilation, but if instead I run

	./configure --prefix=/usr [...]

then it appears to work perfectly...!

No idea what's going on, but at least it works and hopefully it won't 
overwrite my existing compiler when I install it ;-)

Cheers,
Adam.
