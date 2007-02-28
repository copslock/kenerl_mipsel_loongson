Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 19:32:29 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:30943 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039415AbXB1Tc1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 19:32:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1SJWH08021941;
	Wed, 28 Feb 2007 19:32:17 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1SJWGWG021940;
	Wed, 28 Feb 2007 19:32:16 GMT
Date:	Wed, 28 Feb 2007 19:32:16 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>,
	Andrew Sharp <tigerand@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Message-ID: <20070228193216.GB16562@linux-mips.org>
References: <45E465C1.50408@pmc-sierra.com> <20070227173841.GD12230@networkno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070227173841.GD12230@networkno.de>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 27, 2007 at 05:38:41PM +0000, Thiemo Seufer wrote:

> Something like
> 
> #if LOADADDR == 0xffffffff80000000
> 	.fill	0x400
> #endif
> 
> but by defining an appropriate name in arch/mips/Makefile instead of
> externalizing the load-y/LOADADDR there.

Basically a good idea but it will fail for 64-bit kernels so the test
would need to be extended to cover XKPHYS as well.  Also R2 processors
which have the c0_ebase registers do no need to reserve space for
exception handlers as they can easily move them elsewhere.

  Ralf
