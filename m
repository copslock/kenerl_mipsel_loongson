Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jun 2009 17:53:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50729 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492431AbZF0Pxj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Jun 2009 17:53:39 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5RFn26E023776;
	Sat, 27 Jun 2009 16:49:02 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5RFn2kZ023775;
	Sat, 27 Jun 2009 16:49:02 +0100
Date:	Sat, 27 Jun 2009 16:49:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <KKylheku@zeugmasystems.com>
Cc:	Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
Message-ID: <20090627154902.GA18139@linux-mips.org>
References: <20090624063453.GA16846@volta.aurel32.net> <DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 24, 2009 at 03:18:24PM -0700, Kaz Kylheku wrote:

> +void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
> +{
> +	if (vma->vm_flags & VM_EXEC)
> +		flush_icache_range((unsigned long) page_address(page),
> PAGE_SIZE); 
> +}

Flush_icache_range takes two arguments, start and end address.  Both
addresses are the virtual addresses at which the code will run.  Iow both
arguments are wrong.  The result is that for start address values normally
passed to flush_icache_range it will optimize the flush into a full cache
flush of I-cache and D-cache - iow you're lucky.

  Ralf
