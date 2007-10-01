Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 11:59:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56012 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022280AbXJAK74 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 11:59:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l91AxtPV013546;
	Mon, 1 Oct 2007 11:59:55 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l91AxsUN013495;
	Mon, 1 Oct 2007 11:59:54 +0100
Date:	Mon, 1 Oct 2007 11:59:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	veerasena reddy <veerasena_b@yahoo.co.in>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux cache routines for Write-back cache policy on  MIPS24KE
Message-ID: <20071001105954.GB23647@linux-mips.org>
References: <119374.35234.qm@web8401.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119374.35234.qm@web8401.mail.in.yahoo.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 01, 2007 at 10:04:32AM +0100, veerasena reddy wrote:

> I have ported Linux-2.6.18 kernel on MIPS24KE
> processor. I am using write back cache policy.
> 
> Could you please guide me under what cases the below
> cache API's are being used:
> - dma_cache_wback_inv() : Could you explain  what
> exactly this function does
> - dma_cache_wback() : This function write back the
> cache data to memory
> - dma_cache_inv  : This function invalidate the cache
> tags. so subsequent access will fetch from memory.
> 
> Once I looked the above function definitions in
> linux-2.6.18/arch/mips/mm/c-r4k.c.
> All these function's implemetation are same except
> bc_wbak_inv() is called in both dma_cache_wback-inv()
> and dma_cache_wback(), where as bc_inv() is called in
> case of dma_cache_inv.
> 
> Also, bc_inv()/bc_wbak_inv are define as null
> implementation for R4000.
> That means all three functions are doing same
> functionality in case of R4000.
> 
> What are the difference between these three functions.
> Under what cases these functions are used. 

An internal only interface to be used with I/O cache coherency.

> Please guide me if you have any links which will
> explain these API's.

Easy answer, don't use them, for 2.6.24 I've queued a patch to kill this
API.  Documentation/DMA-API.txt documents how to properly deal with I/O
coherency in Linux.

  Ralf
