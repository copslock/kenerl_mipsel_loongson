Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2003 20:27:01 +0100 (BST)
Received: from p508B5752.dip.t-dialin.net ([IPv6:::ffff:80.139.87.82]:30389
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225196AbTEAT0s>; Thu, 1 May 2003 20:26:48 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h41JQPX23531;
	Thu, 1 May 2003 21:26:25 +0200
Date: Thu, 1 May 2003 21:26:25 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: ashish anand <ashish_ibm@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: running purely uncached ..
Message-ID: <20030501212625.A17635@linux-mips.org>
References: <20030501143241.1494.qmail@webmail35.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030501143241.1494.qmail@webmail35.rediffmail.com>; from ashish_ibm@rediffmail.com on Thu, May 01, 2003 at 02:32:41PM -0000
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 01, 2003 at 02:32:41PM -0000, ashish  anand wrote:

> in my kernel source tree i observed in arch/mips/mm/r4xx0.c though
> there are other support routines for flush , invalidate and maintain
> the cache consistency ..but there is no mention of running purely 
> uncached using the old style code CONFIG_MIPS_UNCACHED or otherwise.

CONFIG_MIPS_UNCACHED still exists but it's only selectable when SMP
support is disabled.

Usual warning applies - running uncached is not well supported and is
extremly slow.  It is mostly intended for hardware people who need to
observe all actions of the processor externally.

  Ralf
