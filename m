Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2006 12:09:13 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:25995 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133455AbWGYLJE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2006 12:09:04 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 58EEF441A8; Tue, 25 Jul 2006 13:09:03 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G5Km4-0003a5-TU; Tue, 25 Jul 2006 12:08:28 +0100
Date:	Tue, 25 Jul 2006 12:08:28 +0100
To:	hemanth.venkatesh@wipro.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Multiple page size support for AU1xxx
Message-ID: <20060725110828.GD8401@networkno.de>
References: <20060725034619.GA22617@linux-mips.org> <2156B1E923F1A147AABDF4D9FDEAB4CB09D6F3@blr-m2-msg.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2156B1E923F1A147AABDF4D9FDEAB4CB09D6F3@blr-m2-msg.wipro.com>
User-Agent: Mutt/1.5.12-2006-07-14
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

hemanth.venkatesh@wipro.com wrote:
> Hi Ralf,
> 
> >>Currently only 16kB works and only for 64-bit kernels.  I'm planning
> to
> >> fix that rsn.
> 
> Thanks for the info, did u mean 16KB would be supported for 32 bit
> kernel also. I also saw code changes in arch/mips/mm/tlb-r8k.c only, is
> there a plan to port it to r4k TLB also.
> 
> 
> Help on 2.6.14 and 2.6.17 kernels provide the below info. Does it mean
> some changes are required at user level also.

Old binutils (2.14 and earlier) didn't put enough alignment between code
and data section, it this case a re-link with a newer linker is needed.

Some userland applications hardcode a specific pagesize, typically 4kB,
instead of querying sysconf(_SC_PAGESIZE). Those applications will need
fixing.


Thiemo
