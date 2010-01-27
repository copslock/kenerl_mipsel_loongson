Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 22:33:50 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54517 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492622Ab0A0Vdr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2010 22:33:47 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0RLXr39023374;
        Wed, 27 Jan 2010 22:33:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0RLXqUB023371;
        Wed, 27 Jan 2010 22:33:52 +0100
Date:   Wed, 27 Jan 2010 22:33:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Staging: Octeon Ethernet: Fix memory allocation.
Message-ID: <20100127213351.GA15380@linux-mips.org>
References: <1264627373-31780-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264627373-31780-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17834

On Wed, Jan 27, 2010 at 01:22:53PM -0800, David Daney wrote:

> After aligning the blocks returned by kmalloc, we need to save the
> original pointer so they can be correctly freed.
> 
> There are no guarantees about the alignment of SKB data, so we need to
> handle worst case alignment.
> 
> Since right shifts over subtraction have no distributive property, we
> need to fix the back pointer calculation.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
> 
> The original in the linux-queue tree is broken as it assumes the
> kmalloc returns aligned blocks.  This is not the case when slab
> debugging is enabled.

Queue updated - but shouldn't the magic numbers 128 rsp 256 all over this
patch be replaced by L1_CACHE_SHIFT rsp 2 * L1_CACHE_SHIFT?

  Ralf
