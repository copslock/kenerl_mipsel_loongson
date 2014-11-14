Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 17:47:34 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:35773 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013725AbaKNQrcvKbVT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2014 17:47:32 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XpK1n-0004Aw-BI; Fri, 14 Nov 2014 17:47:19 +0100
Date:   Fri, 14 Nov 2014 17:47:19 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave@sr71.net>
cc:     hpa@zytor.com, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        qiaowei.ren@intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 09/11] x86, mpx: on-demand kernel allocation of bounds
 tables
In-Reply-To: <20141114151829.AD4310DE@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.11.1411141743230.3935@nanos>
References: <20141114151816.F56A3072@viggo.jf.intel.com> <20141114151829.AD4310DE@viggo.jf.intel.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Fri, 14 Nov 2014, Dave Hansen wrote:
>  * move mm init-time #ifdef to mpx.h

> +static inline void arch_bprm_mm_init(struct mm_struct *mm,
> +		struct vm_area_struct *vma)
> +{
> +	mpx_mm_init(mm);
> +#ifdef CONFIG_X86_INTEL_MPX
> +	mm->bd_addr = MPX_INVALID_BOUNDS_DIR;
> +#endif

So we have a double init now :)

> +++ b/arch/x86/kernel/setup.c	2014-11-14 07:06:23.941684394 -0800
> @@ -959,6 +959,13 @@ void __init setup_arch(char **cmdline_p)
>  	init_mm.end_code = (unsigned long) _etext;
>  	init_mm.end_data = (unsigned long) _edata;
>  	init_mm.brk = _brk_end;
> +#ifdef CONFIG_X86_INTEL_MPX
> +	/*
> +	 * NULL is theoretically a valid place to put the bounds
> +	 * directory, so point this at an invalid address.
> +	 */
> +	init_mm.bd_addr = MPX_INVALID_BOUNDS_DIR;
> +#endif

And this one wants mpx_mm_init() replacement as well.
  
Thanks,

	tglx
