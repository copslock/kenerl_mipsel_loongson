Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Feb 2005 12:14:01 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:8477 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225204AbVB1MNq>; Mon, 28 Feb 2005 12:13:46 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1SCBMUE013116;
	Mon, 28 Feb 2005 12:11:22 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1SCBKYD013115;
	Mon, 28 Feb 2005 12:11:20 GMT
Date:	Mon, 28 Feb 2005 12:11:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jeroen Vreeken <pe1rxq@amsat.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: sparse and mips
Message-ID: <20050228121120.GA11719@linux-mips.org>
References: <422256A3.2030407@amsat.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422256A3.2030407@amsat.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 28, 2005 at 12:24:19AM +0100, Jeroen Vreeken wrote:

> I tried compiling my switch driver with sparse to see if I did some 
> stupid casts and got a lot of warnings.... (attached below)
> Are others using sparse with mips kernels and getting the same?
> Or has nobody taken the time to fix it up?
> (The byteorder stuff should creap up everywhere or not?)

Not to my knowledge.  I always meant to as a preventive maintenance meassure
but somehow there was always something more important to do ...

> include/asm/byteorder.h:27:4: warning: "MIPS, but neither __MIPSEB__, 
> nor __MIPSEL__???"
> include/linux/kernel.h:200:2: warning: "Please fix asm/byteorder.h"

A result of sparse not knowing about MIPS yet.

> include/linux/aio_abi.h:59:2: warning: edit for your odd byteorder.

Same.

The others don't really make sense at the first look.

73,

  Ralf
