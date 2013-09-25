Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 09:31:05 +0200 (CEST)
Received: from mail-ea0-f171.google.com ([209.85.215.171]:49656 "EHLO
        mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815989Ab3IYHa6NAzu5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Sep 2013 09:30:58 +0200
Received: by mail-ea0-f171.google.com with SMTP id n15so2954026ead.2
        for <multiple recipients>; Wed, 25 Sep 2013 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QzVosR3TI0BZBS7rou3cPUC/68Ysf70wYveIJTVpl+8=;
        b=qZ+2bFeDFBfu5FXYnPe4vwkVK06hDloeBUPAbocAud/FX24mkzx1hhoZK9EqEpToJu
         tPFeoQMSA0ZXIlXh3+frFWUYHJrYS5GD115u8FpikvNj6gRqPltyMvZbuj4rGA/PYTmt
         8E80Dy4jD6FLWTZrKYzYQtmtmhyrmOG2mISA6ZLD5SIa4LBkTc3PFPThJ4EY9MEFQkly
         oN+jZUXL+ozQs2Nue8uuFgXbJ/Ds9i4Spq6EfkqEakaiWx7GfqJ1Kjw5QuKUsNl7NF5W
         ls99gXXBnvAbWHieFbyRxbT9GNHeUWxxX5vFwnxjooDGfSDyoyn8+f9MjKVcRAn7plBq
         t0MA==
X-Received: by 10.15.44.199 with SMTP id z47mr672906eev.64.1380094252832;
        Wed, 25 Sep 2013 00:30:52 -0700 (PDT)
Received: from gmail.com (BC24D856.catv.pool.telekom.hu. [188.36.216.86])
        by mx.google.com with ESMTPSA id a1sm62344415eem.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 00:30:52 -0700 (PDT)
Date:   Wed, 25 Sep 2013 09:30:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Timothy Pepper <timothy.c.pepper@linux.intel.com>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mm: insure topdown mmap chooses addresses above security minimum
Message-ID: <20130925073048.GB27960@gmail.com>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


* Timothy Pepper <timothy.c.pepper@linux.intel.com> wrote:

> A security check is performed on mmap addresses in
> security/security.c:security_mmap_addr().  It uses mmap_min_addr to insure
> mmaps don't get addresses lower than a user configurable guard value
> (/proc/sys/vm/mmap_min_addr).  The arch specific mmap topdown searches
> look for a map candidate address all the way down to a low_limit that is
> currently hard coded as PAGE_SIZE.  Depending on compile time options
> and userspace setting the procfs tunable, the security check's view of
> the minimum allowable address may be something greater than PAGE_SIZE.
> This leaves a gap where get_unmapped_area()'s call to get_area() might
> return an address above PAGE_SIZE, but below mmap_min_addr, and thus
> get_unmapped_area() fails.
> 
> This was seen on x86_64 in the case of a topdown address space and a large
> stack rlimit, with mmap_min_addr having been set to 32k by the distro.
> This left a 28k gap where the get area search intends to place a small
> mmap, but then get_unmapped_area() stumbles at the security check.
> 
> What should have happened is the address search wraps back to a higher
> address, the search continues and perhaps succeeds.  Indeed an mmap of
> a larger size gets a topdown search that does wrap around back up into
> the rlimit stack reserve and succeeds assuming suitable free space.
> But a small mmap fits in the low gap and always fails.  It becomes
> possible to make large mmaps but not small ones.
> 
> When an explicit address hint is given, mm/mmap.c's round_hint_to_min()
> will round up to mmap_min_addr.
> 
> A topdown search's low_limit should similarly consider mmap_min_addr
> instead of just PAGE_SIZE.
> 
> Signed-off-by: Tim Pepper <timothy.c.pepper@linux.intel.com>
> Cc: linux-mm@kvack.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> --
>  arch/arm/mm/mmap.c               | 3 ++-
>  arch/mips/mm/mmap.c              | 3 ++-
>  arch/powerpc/mm/slice.c          | 3 ++-
>  arch/sh/mm/mmap.c                | 3 ++-
>  arch/sparc/kernel/sys_sparc_64.c | 3 ++-
>  arch/x86/kernel/sys_x86_64.c     | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)
> 
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

>  		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> -		info.low_limit = PAGE_SIZE;
> +		info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  		info.high_limit = mm->mmap_base;
>  		addr = vm_unmapped_area(&info);

> -		info.low_limit = addr;
> +		info.low_limit = max(addr, PAGE_ALIGN(mmap_min_addr));

>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = filp ? get_align_mask() : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

There appears to be a lot of repetition in these methods - instead of 
changing 6 places it would be more future-proof to first factor out the 
common bits and then to apply the fix to the shared implementation.

Thanks,

	Ingo
