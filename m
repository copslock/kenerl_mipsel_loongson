Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2003 22:24:09 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:59130 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225208AbTG1VYH>;
	Mon, 28 Jul 2003 22:24:07 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6SLO1h17925;
	Mon, 28 Jul 2003 14:24:01 -0700
Date: Mon, 28 Jul 2003 14:24:01 -0700
From: Jun Sun <jsun@mvista.com>
To: Teresa Tao <Teresat@tridentmicro.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: mmap'ed memory cacheable or uncheable
Message-ID: <20030728142401.K25784@mvista.com>
References: <61F6477DE6BED311B69F009027C3F58403AA396F@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <61F6477DE6BED311B69F009027C3F58403AA396F@EXCHANGE>; from Teresat@tridentmicro.com on Fri, Jul 25, 2003 at 03:52:33PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Jul 25, 2003 at 03:52:33PM -0700, Teresa Tao wrote:
> How about if I specify the following flags in my mmap routine just like what the pgprot_noncached micro did.
> 	pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
> 	pgprot_val(vma->vm_page_prot) |= _CACHE_UNCACHED;
> 
> Will this have kernel make the mmap'd memory non-cacheable? Or is there a mmap non-cacheable patch?
>

I think this might work.  Did you try it?  The performance will be bad
though as mmap() is used widely by userland.

Jun
