Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 22:16:03 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33757 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011604AbcAZVQAgz5dG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 22:16:00 +0100
Received: by mail-pa0-f65.google.com with SMTP id pv5so8315280pac.0;
        Tue, 26 Jan 2016 13:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4dOm2hHMTXZzGrCdQwV7Qo025m2MuVt94jRu+NecNS0=;
        b=uq08X7SRV4HB/WTD4al07lXZwpVO9fKsFU8INTI9MXp/7VaPAnCGScJoRRsXHRjea6
         Sf5Kl0dkplDXVt4SFX5AgzXoLGyKH7e+LC7BGAAFo+Zq+n2Hjqs8n/Sn2cv/Ev1DvW7L
         iV3kUe8PD0g2cpI7AkzMgXoLWUMotCUDFlX8SLvV5eBYATgyEmPK0G/Kfj7J2jyN+qjJ
         fJSH/jfTsBJqBhZCLupgLbuUfdwtnSvq/R+6Pq/RxKUub7KMEfHrm+kvFwVz37TSmgCX
         uCTZyTCDrtvpr9mixUEigUuIUl+YohqSQ4SY9pLUHJ8O02UlQ6RHIlbnbm9SGZr1f9Om
         vw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4dOm2hHMTXZzGrCdQwV7Qo025m2MuVt94jRu+NecNS0=;
        b=meHCLBH4dJGhHX3gW+OENSZbDnJeqiQvm3q8oWSH1zJ4ZGY4M4/bg42qKJMkXs70ZS
         L0R12rup9tcpgR/FY2uPEqUeNNSfki5pTtj+xPGNhX1aOfqhGGaQlYXykexgKk/4HHNz
         da3cDRoMLMewP4owCiJtieX2EYB+My1NaSgj6sobfyRKlO9/o3Syv7bLdGmdZgHpr/sp
         Jvs7vcdmszT64ubiuEBEXRiWu9rzgFzakKiNIzUASy5BAAf/e3NheevX3O5H/u8h6YIq
         fccgE7hLQFM2oM8wy0mmYq7M1BiOYZY8djwInnAibHOD3zxNy28HmL5+ryQtex/J2h2F
         Iw4Q==
X-Gm-Message-State: AG10YOQGKGXFgm2LaXiv/IZvo+4vV6MccQ4pBgv4RVhV/Vv6yfD0i3nZ+B1OS4h+YdtKUw==
X-Received: by 10.66.253.137 with SMTP id aa9mr10140716pad.139.1453842953067;
        Tue, 26 Jan 2016 13:15:53 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id v26sm3844912pfi.56.2016.01.26.13.15.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jan 2016 13:15:51 -0800 (PST)
Message-ID: <56A7E206.4040301@gmail.com>
Date:   Tue, 26 Jan 2016 13:15:50 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 4/6] MIPS: tlbex: Fix bugs in tlbchange handler
References: <1453814784-14230-1-git-send-email-chenhc@lemote.com> <1453814784-14230-5-git-send-email-chenhc@lemote.com>
In-Reply-To: <1453814784-14230-5-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/26/2016 05:26 AM, Huacai Chen wrote:
> If a tlb miss triggered when EXL=1,

How is that possible?  The exception handlers are not in mapped memory, 
and we clear EXL very early in the exception handlers.

In valid code, how are you getting TLB related exceptions when EXL=1?

> tlb refill exception is treated as
> tlb invalid exception, so tlbp may fails. In this situation, CP0_Index
> register doesn't contain a valid value. This may not be a problem for
> VTLB since it is fully-associative. However, FTLB is set-associative so
> not every tlb entry is valid for a specific address. Thus, we should
> use tlbwr instead of tlbwi when tlbp fails.
>
> There is a similar case for huge page, so build_huge_tlb_write_entry()
> is also modified. If wmode != tlb_random, that means the caller is tlb
> invalid handler, we should select tlbr/tlbi depend on the tlbp result.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   arch/mips/mm/tlbex.c | 31 ++++++++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index d0975cd..da68ffb 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -173,7 +173,10 @@ enum label_id {
>   	label_large_segbits_fault,
>   #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>   	label_tlb_huge_update,
> +	label_tail_huge_miss,
> +	label_tail_huge_done,
>   #endif
> +	label_tail_miss,
>   };
>
>   UASM_L_LA(_second_part)
> @@ -192,7 +195,10 @@ UASM_L_LA(_r3000_write_probe_fail)
>   UASM_L_LA(_large_segbits_fault)
>   #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>   UASM_L_LA(_tlb_huge_update)
> +UASM_L_LA(_tail_huge_miss)
> +UASM_L_LA(_tail_huge_done)
>   #endif
> +UASM_L_LA(_tail_miss)
>
>   static int hazard_instance;
>
> @@ -706,8 +712,24 @@ static void build_huge_tlb_write_entry(u32 **p, struct uasm_label **l,
>   	uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);
>   	uasm_i_mtc0(p, tmp, C0_PAGEMASK);
>
> -	build_tlb_write_entry(p, l, r, wmode);
> +	if (wmode == tlb_random) { /* Caller is TLB Refill Handler */
> +		build_tlb_write_entry(p, l, r, wmode);
> +		build_restore_pagemask(p, r, tmp, label_leave, restore_scratch);
> +		return;
> +	}
> +
> +	/* Caller is TLB Load/Store/Modify Handler */
> +	uasm_i_mfc0(p, tmp, C0_INDEX);
> +	uasm_il_bltz(p, r, tmp, label_tail_huge_miss);
> +	uasm_i_nop(p);
> +	build_tlb_write_entry(p, l, r, tlb_indexed);
> +	uasm_il_b(p, r, label_tail_huge_done);
> +	uasm_i_nop(p);
> +
> +	uasm_l_tail_huge_miss(l, *p);
> +	build_tlb_write_entry(p, l, r, tlb_random);
>
> +	uasm_l_tail_huge_done(l, *p);
>   	build_restore_pagemask(p, r, tmp, label_leave, restore_scratch);
>   }
>
> @@ -2026,7 +2048,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
>   	uasm_i_ori(p, ptr, ptr, sizeof(pte_t));
>   	uasm_i_xori(p, ptr, ptr, sizeof(pte_t));
>   	build_update_entries(p, tmp, ptr);
> +	uasm_i_mfc0(p, ptr, C0_INDEX);
> +	uasm_il_bltz(p, r, ptr, label_tail_miss);
> +	uasm_i_nop(p);
>   	build_tlb_write_entry(p, l, r, tlb_indexed);
> +	uasm_il_b(p, r, label_leave);
> +	uasm_i_nop(p);
> +	uasm_l_tail_miss(l, *p);
> +	build_tlb_write_entry(p, l, r, tlb_random);
>   	uasm_l_leave(l, *p);
>   	build_restore_work_registers(p);
>   	uasm_i_eret(p); /* return from trap */
>
