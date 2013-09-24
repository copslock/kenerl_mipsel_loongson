Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2013 23:35:20 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33129 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824811Ab3IXVfTEXZq4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Sep 2013 23:35:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=efjon2CfsIn50qeKrPUl9XKs3kBqPAJQVSljeF6gFMM=;
        b=bsQNh8TsJi8G7Kgv0vEZlO1XEi7dGadhvs7Jrd7HNNIrtlBI0H5fp1oM4GiFlHH4ipnus55zLIVRkYanRrqJBGJSnTMI329ey/PuFYA/wGulB8CSSt95StM6yCBfSx9KrTkuPRPKTUlIl3f/CGRd2COOZeZSqvxrwgiuxQl6NFI=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:41357)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1VOaAB-0005M8-Nm; Tue, 24 Sep 2013 22:28:56 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1VOaAA-0006UF-1A; Tue, 24 Sep 2013 22:28:54 +0100
Date:   Tue, 24 Sep 2013 22:28:53 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Timothy Pepper <timothy.c.pepper@linux.intel.com>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: Re: mm: insure topdown mmap chooses addresses above security
        minimum
Message-ID: <20130924212853.GK12758@n2100.arm.linux.org.uk>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Tue, Sep 24, 2013 at 02:23:31PM -0700, Timothy Pepper wrote:
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 0c63562..0e7355d 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -9,6 +9,7 @@
>  #include <linux/io.h>
>  #include <linux/personality.h>
>  #include <linux/random.h>
> +#include <linux/security.h>
>  #include <asm/cachetype.h>
>  
>  #define COLOUR_ALIGN(addr,pgoff)		\
> @@ -146,7 +147,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  
>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

This looks sane for ARM.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
