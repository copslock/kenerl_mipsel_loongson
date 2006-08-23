Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2006 17:06:40 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:17633 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20037639AbWHWQGj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2006 17:06:39 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 689FF45595; Wed, 23 Aug 2006 18:06:44 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GFv9H-0000kU-TJ; Wed, 23 Aug 2006 17:00:11 +0100
Date:	Wed, 23 Aug 2006 17:00:11 +0100
To:	Peter Watkins <treestem@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] 64K page size
Message-ID: <20060823160011.GE20395@networkno.de>
References: <44EC7125.7000000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EC7125.7000000@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Peter Watkins wrote:
> Hello,
> 
> There are a number of changes required to support larger page sizes, but 
> this one I thought worth sending up right away.
> 
> The code in pgtable-64.h assumes TASK_SIZE is always bigger than a first 
> level PGDIR_SIZE. This is not the case for 64K pages, where task size is 
> 40 bits (1TB) and a pgd entry can map 42 bits. This leads to 
> USER_PTRS_PER_PGD being zero for 64K pages.
> 
> If there is interest in other changes for 64K pages, I can send more.

Please do so. :-)


Thiemo
