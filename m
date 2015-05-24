Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 23:21:43 +0200 (CEST)
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:38803 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006723AbbEXVVkBRauG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 23:21:40 +0200
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-05v.sys.comcast.net with comcast
        id XxMJ1q0012VvR6D01xMbd5; Sun, 24 May 2015 21:21:35 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-19v.sys.comcast.net with comcast
        id XxMa1q00D42s2jH01xMaQZ; Sun, 24 May 2015 21:21:35 +0000
Message-ID: <556240DE.1050003@gentoo.org>
Date:   Sun, 24 May 2015 17:21:34 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 01/10] MIPS: Add SysRq operation to dump TLBs on
 all CPUs
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com> <1432025438-26431-2-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1432025438-26431-2-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432502495;
        bh=KhqkRzS2Wlu496iBocAZZWWG/4quBzsR4lbl6S+sOMA=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=pe2Ek8Kawqo6rxJEVteytJd+iQMvGOdCafyB3dcSuprlZTQ7viI2XZnSdMXIR5uD8
         RVmm5iQqkmfHuMBcv7//CNT9qqI+WGLTm7gmW5gppKJUIMkQys+w/QaKEAOyF2jjTE
         3317gYeEsZquT7xVWkFXrYuXVzmFj6H7QiHZygsDkN+F/emWRhlpHY3LZaVBKHtHN+
         GXpUJtPcYNT8U06el0OIPCLY89liKjPJTsRcH0tdI36RsrGu86+iy+nOkdqI7oZa5D
         qYXstgoL+ZNGpltahoGP4BIzlqihL8zivmoUYuzqezWEA2ec0VhBV5uX7OyRrwuxF1
         ygb+usaC98xbQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 05/19/2015 04:50, James Hogan wrote:
> Add a MIPS specific SysRq operation to dump the TLB entries on all CPUs,
> using the 'x' trigger key.

Thought: Would it make sense to split apart the data such that one SysRq key
dumps the CP0 registers of all CPUs, and another dumps the TLB info?


> +/*
> + * Dump TLB entries on all CPUs.
> + */
> +
> +static DEFINE_SPINLOCK(show_lock);
> +
> +static void sysrq_tlbdump_single(void *dummy)
> +{
> +	const int field = 2 * sizeof(unsigned long);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&show_lock, flags);
> +
> +	pr_info("CPU%d:\n", smp_processor_id());
> +	pr_info("Index	: %0x\n", read_c0_index());
> +	pr_info("Pagemask: %0x\n", read_c0_pagemask());
> +	pr_info("EntryHi : %0*lx\n", field, read_c0_entryhi());
> +	pr_info("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
> +	pr_info("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
> +	pr_info("Wired   : %0x\n", read_c0_wired());
> +	pr_info("Pagegrain: %0x\n", read_c0_pagegrain());
> +	if (cpu_has_htw) {
> +		pr_info("PWField : %0*lx\n", field, read_c0_pwfield());
> +		pr_info("PWSize  : %0*lx\n", field, read_c0_pwsize());
> +		pr_info("PWCtl   : %0x\n", read_c0_pwctl());
> +	}
> +	pr_info("\n");
> +	dump_tlb_all();
> +	pr_info("\n");
> +
> +	spin_unlock_irqrestore(&show_lock, flags);
> +}

The older CPUs, like the R10000 don't have a PageGrain register I believe (at
least R10K doesn't),  Does that need to be stuffed behind a conditional?  Also,
R10K (and newer?) CPUs have a FrameMask CP0 register ($21).  Linux currently
scribbles a 0 to the writable bits, though, so I'm not sure if it matters.

--J
