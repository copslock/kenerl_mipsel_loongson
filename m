Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2008 19:26:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:54764 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20045794AbYF1S0e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 28 Jun 2008 19:26:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5SIPAUk030437;
	Sat, 28 Jun 2008 20:25:35 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5SIP9FA030430;
	Sat, 28 Jun 2008 20:25:09 +0200
Date:	Sat, 28 Jun 2008 20:25:09 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP22: Fix crashes due to wrong L1_CACHE_BYTES
Message-ID: <20080628182509.GA20127@linux-mips.org>
References: <20080627215226.D1B5EE2F71@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080627215226.D1B5EE2F71@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 27, 2008 at 11:52:26PM +0200, Thomas Bogendoerfer wrote:

> The introduction of a real dma cache invalidate makes it important
> to have a correct cache line size, otherwise the kernel will gives
> out two memory segment, which might share one cache line. The R4400
> Indy/Indigo2 CPU modules are using a second level cache line size
> of 128 bytes, so MIPS_L1_CACHE_SHIFT needs to be bumped up to 7 for
> IP22.

Thanks, applied.

I also think this missconfiguration is worth an additional runtime
check; the consequence of that kind of bug are subtle and painful to
debug.

  Ralf
