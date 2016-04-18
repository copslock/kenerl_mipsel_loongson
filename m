Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 16:34:58 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36814 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026886AbcDROezuG9ql (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 16:34:55 +0200
Received: by mail-wm0-f67.google.com with SMTP id l6so25178516wml.3;
        Mon, 18 Apr 2016 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6xjsZp9LzLYaiYuP/IURtI1QnT+qv8HgmkBNKhqHyvc=;
        b=efsCncbzzalVStJa/P0+bbH0zBxjmVujsatGJUcHaJ84k+O47nQ4c0VnnDQaFhZonM
         PD3uAlquPrvnVpDbFXHjjcd5VxWcGV1E/aqzuHGeM5bOLA9tHkXphq0b0Muj/91d5uhe
         OsKMmliBuS08fvWGSZ2q9A/hskhrf32AgnLbWjimt6CUlYwljZP2UW1fMuvA8K0zmLRs
         KFdC433Uvxxiagj1ojLuUE32Pyk6InX7vYcGYVfJwUVVgRmwrfoySvotfgq1aOq7tEUD
         dU5h1WORghNawTVHP4lPl8WPeggO/fbCKp9OS8co/KH4n/aXObngCuA6cy3XJSL2jPjq
         Hcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6xjsZp9LzLYaiYuP/IURtI1QnT+qv8HgmkBNKhqHyvc=;
        b=TTF8VINs+QNBQh56q4FqbC0G+ICdvamPTzJwEEFRsyAJzPBTeMj+tQm1Dha7mtZ9Bx
         DMoDRWGPxDx8lwxiivZJhmQdT4H44BhVZ6V/klTO0mhTzAq72goN0qk9Z/8tZl6NH0Fk
         OrajiFHJHukp+b3K8IWpxGwr1wadrzPZKjgqUZ/7Ms5YrHYO+9tax9LkAyHGT+2JgmZP
         eHbY/2r3Zn2WYm6bBk+sbHxKF6YOVis1Fs7oFVxcWE841W62ybP1+FFM/iGUsV1iBeOC
         NF3fjmdGH58Ck/ECgCV5yFXY5g8IdY1jZeR5Ka4yRr1mxhaLAR+vlBRmJkW8A4leKBV7
         2Dxg==
X-Gm-Message-State: AOPr4FU2BC2df1w7UHIbeKnd/+pYysocnj4Yo1qbGtJbret7vsBj5Bv2CufrQlzuAt8f/VVaJEsx93HzpXytCA==
X-Received: by 10.28.139.129 with SMTP id n123mr18659385wmd.13.1460990090469;
 Mon, 18 Apr 2016 07:34:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.129.14 with HTTP; Mon, 18 Apr 2016 07:34:10 -0700 (PDT)
In-Reply-To: <1460972133-16973-8-git-send-email-paul.burton@imgtec.com>
References: <1460972133-16973-1-git-send-email-paul.burton@imgtec.com> <1460972133-16973-8-git-send-email-paul.burton@imgtec.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 18 Apr 2016 16:34:10 +0200
Message-ID: <CAOLZvyGWBuUoo3C5V3L9g6Lbswf1cj6=6TSdgehuGeJch8-V=Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] MIPS: mm: Fix MIPS32 36b physical addressing
 (alchemy, netlogic)
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        "# v4 . 1+" <stable@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Huacai Chen <chenhc@lemote.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Mon, Apr 18, 2016 at 11:35 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> There are 2 distinct cases in which a kernel for a MIPS32 CPU
> (CONFIG_CPU_MIPS32=y) may use 64 bit physical addresses
> (CONFIG_PHYS_ADDR_T_64BIT=y):
>
>   - 36 bit physical addressing as used by RMI Alchemy & Netlogic XLP/XLR
>     CPUs.
>
>   - MIPS32r5 eXtended Physical Addressing (XPA).

This hunk here gives me a build failure on Alchemy:

/home/mano/dev/db1200/kernel/linux/arch/mips/mm/init.c: In function
'__kmap_pgprot':
/home/mano/dev/db1200/kernel/linux/arch/mips/mm/init.c:116:28: error:
'_PFNX_MASK' undeclared (first use in this function)
   entrylo = (pte.pte_low & _PFNX_MASK);


> diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
> index 5bc663d..58e8bf8 100644
> --- a/arch/mips/include/asm/pgtable-bits.h
> +++ b/arch/mips/include/asm/pgtable-bits.h
> @@ -32,11 +32,11 @@
>   * unpredictable things.  The code (when it is written) to deal with
>   * this problem will be in the update_mmu_cache() code for the r4k.
>   */
> -#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
> +#if defined(CONFIG_XPA)
>
>  /*
> - * Page table bit offsets used for 64 bit physical addressing on MIPS32,
> - * for example with Alchemy, Netlogic XLP/XLR or XPA.
> + * Page table bit offsets used for 64 bit physical addressing on
> + * MIPS32r5 with XPA.
>   */
>  enum pgtable_bits {
>         /* Used by TLB hardware (placed in EntryLo*) */
> @@ -59,6 +59,27 @@ enum pgtable_bits {
>   */
>  #define _PFNX_MASK             0xffffff
>
> +#elif defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
> +
> +/*
> + * Page table bit offsets used for 36 bit physical addressing on MIPS32,
> + * for example with Alchemy or Netlogic XLP/XLR.
> + */
> +enum pgtable_bits {
> +       /* Used by TLB hardware (placed in EntryLo*) */
> +       _PAGE_GLOBAL_SHIFT,
> +       _PAGE_VALID_SHIFT,
> +       _PAGE_DIRTY_SHIFT,
> +       _CACHE_SHIFT,
> +
> +       /* Used only by software (masked out before writing EntryLo*) */
> +       _PAGE_PRESENT_SHIFT = _CACHE_SHIFT + 3,
> +       _PAGE_NO_READ_SHIFT,
> +       _PAGE_WRITE_SHIFT,
> +       _PAGE_ACCESSED_SHIFT,
> +       _PAGE_MODIFIED_SHIFT,
> +};
> +

forgot _PFNX_MASK here?


Manuel
