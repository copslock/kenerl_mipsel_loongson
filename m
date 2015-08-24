Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 05:29:09 +0200 (CEST)
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:34902 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006523AbbHXD3Fv0UgH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Aug 2015 05:29:05 +0200
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-08v.sys.comcast.net with comcast
        id 8TUu1r0022XD5SV01TUzJ4; Mon, 24 Aug 2015 03:28:59 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-20v.sys.comcast.net with comcast
        id 8TUx1r00R0w5D3801TUyhg; Mon, 24 Aug 2015 03:28:59 +0000
Message-ID: <55DA8F47.10002@gentoo.org>
Date:   Sun, 23 Aug 2015 23:28:07 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.6) Gecko/20150728 FossaMail/25.1.6
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
CC:     David Daney <david.daney@cavium.com>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Make set_pte() SMP safe.
References: <1438649323-1082-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1438649323-1082-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1440386939;
        bh=1vfMJs87/qEClO33Xj88SgfWn404mc22yuoQpsiHgHs=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=cnMErQeIG17vKq/C1+423IdziTCKKIU8kwwNXwy25Q5Mm5P77/pU390Be4ct+39ap
         Z2ESfT+UdLwIkV2BXPQPAimbDTzRYcpnFcaMVaVRpoKzd1pl35GJ/DZI/EGnf7Vr/J
         I94Tcz3QP+P2WoSB9OZ/H7FCNK01bYwUjfoSXAlaO63cxqTinNGlMpYlkvq9cyqPae
         kxx87fLU2cx4lZWp24BJi20Sj4rl84G5L3DS+p6ugME+ISlTYW+1XSAA1ErQI3Ecv9
         CExNlMPog4TvRP2jFSZlICchhLutl7+Y9nZHYG1b1DIde/nvbPCm11kjd7vNn8sc+0
         UHNd2zxjL2gFA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48994
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

On 08/03/2015 20:48, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> On MIPS the GLOBAL bit of the PTE must have the same value in any
> aligned pair of PTEs.  These pairs of PTEs are referred to as
> "buddies".  In a SMP system is is possible for two CPUs to be calling
> set_pte() on adjacent PTEs at the same time.  There is a race between
> setting the PTE and a different CPU setting the GLOBAL bit in its
> buddy PTE.
> 
> This race can be observed when multiple CPUs are executing
> vmap()/vfree() at the same time.

Curious, but what's the observed symptom when this race condition occurs?  I am
wondering if it may (or may not) explain the periodic hard lockups on IP27 SMP
that I see during heavy disk I/O.  On that platform, !CONFIG_SMP works fine.
It's only in SMP mode that I can reproduce the lockups, so I suspect it's a
race condition of some kind.


> Make setting the buddy PTE's GLOBAL bit an atomic operation to close
> the race condition.
> 
> The case of CONFIG_64BIT_PHYS_ADDR && CONFIG_CPU_MIPS32 is *not*
> handled.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/mips/include/asm/pgtable.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 9d81067..ae85694 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -182,8 +182,39 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>  		 * Make sure the buddy is global too (if it's !none,
>  		 * it better already be global)
>  		 */
> +#ifdef CONFIG_SMP
> +		/*
> +		 * For SMP, multiple CPUs can race, so we need to do
> +		 * this atomically.
> +		 */
> +#ifdef CONFIG_64BIT
> +#define LL_INSN "lld"
> +#define SC_INSN "scd"
> +#else /* CONFIG_32BIT */
> +#define LL_INSN "ll"
> +#define SC_INSN "sc"
> +#endif
> +		unsigned long page_global = _PAGE_GLOBAL;
> +		unsigned long tmp;
> +
> +		__asm__ __volatile__ (

If an R10000_LLSC_WAR case is needed here (see below), then shouldn't ".set
arch=r4000" go here, and '.set    "MIPS_ISA_ARCH_LEVEL"' go in the
!R10000_LLSC_WAR case?


> +			"	.set	push\n"
> +			"	.set	noreorder\n"
> +			"1:	" LL_INSN "	%[tmp], %[buddy]\n"
> +			"	bnez	%[tmp], 2f\n"
> +			"	 or	%[tmp], %[tmp], %[global]\n"
> +			"	" SC_INSN "	%[tmp], %[buddy]\n"

A quick look at asm/local.h and asm/bitops.h shows that they use "__LL" and
"__SC" instead of defining local variants.  Perhaps those macros are usable
here as well?


> +			"	beqz	%[tmp], 1b\n"

Does this 'beqz' insn need to have a case for R10000_LLSC_WAR, which uses
'beqzl', like several other areas in the kernel?



> +			"	 nop\n"
> +			"2:\n"
> +			"	.set pop"
> +			: [buddy] "+m" (buddy->pte),
> +			  [tmp] "=&r" (tmp)
> +			: [global] "r" (page_global));
> +#else /* !CONFIG_SMP */
>  		if (pte_none(*buddy))
>  			pte_val(*buddy) = pte_val(*buddy) | _PAGE_GLOBAL;
> +#endif /* CONFIG_SMP */
>  	}
>  #endif
>  }
> 

--J
