Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 12:31:27 +0100 (BST)
Received: from p508B6081.dip.t-dialin.net ([IPv6:::ffff:80.139.96.129]:32224
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225227AbTGaLbY>; Thu, 31 Jul 2003 12:31:24 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6VBVMx6003916;
	Thu, 31 Jul 2003 13:31:22 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6VBVLXu003915;
	Thu, 31 Jul 2003 13:31:21 +0200
Date: Thu, 31 Jul 2003 13:31:21 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Teresa Tao <Teresat@tridentmicro.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mmap'ed memory cacheable or uncheable
Message-ID: <20030731113121.GB2718@linux-mips.org>
References: <61F6477DE6BED311B69F009027C3F58403AA3969@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61F6477DE6BED311B69F009027C3F58403AA3969@EXCHANGE>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 24, 2003 at 08:26:59PM -0700, Teresa Tao wrote:

> I got a question regarding the mmap'ed memory. Is the mmap'ed memory
> cacheable or uncheable? My driver just use the remap_page_range to map
> a reserved physical memory.

Mmap(2) creates cachable mappings for everything below the highest memory
address and uncached above that.  That's a somewhat naive mechanism
which fails a few systems but somehow nobody did complain so far ...

  Ralf
