Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 06:51:11 +0100 (CET)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:55045 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009415AbcA0FvJFX6I7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 06:51:09 +0100
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-09v.sys.comcast.net with comcast
        id Atr11s0012EPM3101tr1qQ; Wed, 27 Jan 2016 05:51:01 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-07v.sys.comcast.net with comcast
        id Atqz1s0080w5D3801tqz28; Wed, 27 Jan 2016 05:51:01 +0000
Subject: Re: [PATCH 4/6] MIPS: tlbex: Fix bugs in tlbchange handler
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
References: <1453814784-14230-1-git-send-email-chenhc@lemote.com>
 <1453814784-14230-5-git-send-email-chenhc@lemote.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <56A85ABA.7000903@gentoo.org>
Date:   Wed, 27 Jan 2016 00:50:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101
 Thunderbird/42.0
MIME-Version: 1.0
In-Reply-To: <1453814784-14230-5-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1453873861;
        bh=607dRtbRP35PePAAXDyszIiAVb4ma4Lxl+mnt4wPkNk=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=pNCpFoAqbXlcUnF2acV4h1ZU1Tlim432xYaHLWw8TGChmrWWl7uh/4gdO3RTaRNpA
         2jr8Ib8+81cLCH2HkIGOvR31u1CGn6n0CsaCnXfKCdAXRFwwfhSRCczE/KsScAfFxJ
         PrEsLlifqsw3J7RfTwsxEEuZTEMEcKCpbzojLf6ZnAQ/cwbkre3gkLeHk4rWwcubcG
         Rxt3vdE6R/S6vHtTw01FuboQkR5sgkTexm3l2G/F9VgwLly4WDsgBGiMC3Vv/dQT/k
         2VPdznTIb1tccZz3FhLhT96Xlmc3fVAtIO81dTNjE8MDFXtd5cXPxSg8lce9JDqsBl
         1Q3I3bS/9mF4w==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51454
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

On 01/26/2016 08:26, Huacai Chen wrote:
> If a tlb miss triggered when EXL=1, tlb refill exception is treated as
> tlb invalid exception, so tlbp may fails. In this situation, CP0_Index
> register doesn't contain a valid value. This may not be a problem for
> VTLB since it is fully-associative. However, FTLB is set-associative so
> not every tlb entry is valid for a specific address. Thus, we should
> use tlbwr instead of tlbwi when tlbp fails.
> 
> There is a similar case for huge page, so build_huge_tlb_write_entry()
> is also modified. If wmode != tlb_random, that means the caller is tlb
> invalid handler, we should select tlbr/tlbi depend on the tlbp result.

This patch triggered instruction bus errors on my Octane (R14000) once it
switched to userland, using PAGE_SIZE_64KB, MAX_ORDER=14, and THP.  Without the
patch, that same configuration boots fine, so I suspect this change isn't
appropriate for all systems.

--J


> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/mm/tlbex.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index d0975cd..da68ffb 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -173,7 +173,10 @@ enum label_id {
>  	label_large_segbits_fault,
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>  	label_tlb_huge_update,
> +	label_tail_huge_miss,
> +	label_tail_huge_done,
>  #endif
> +	label_tail_miss,
>  };
>  
>  UASM_L_LA(_second_part)
> @@ -192,7 +195,10 @@ UASM_L_LA(_r3000_write_probe_fail)
>  UASM_L_LA(_large_segbits_fault)
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>  UASM_L_LA(_tlb_huge_update)
> +UASM_L_LA(_tail_huge_miss)
> +UASM_L_LA(_tail_huge_done)
>  #endif
> +UASM_L_LA(_tail_miss)
>  
>  static int hazard_instance;
>  
> @@ -706,8 +712,24 @@ static void build_huge_tlb_write_entry(u32 **p, struct uasm_label **l,
>  	uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);
>  	uasm_i_mtc0(p, tmp, C0_PAGEMASK);
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
>  	build_restore_pagemask(p, r, tmp, label_leave, restore_scratch);
>  }
>  
> @@ -2026,7 +2048,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
>  	uasm_i_ori(p, ptr, ptr, sizeof(pte_t));
>  	uasm_i_xori(p, ptr, ptr, sizeof(pte_t));
>  	build_update_entries(p, tmp, ptr);
> +	uasm_i_mfc0(p, ptr, C0_INDEX);
> +	uasm_il_bltz(p, r, ptr, label_tail_miss);
> +	uasm_i_nop(p);
>  	build_tlb_write_entry(p, l, r, tlb_indexed);
> +	uasm_il_b(p, r, label_leave);
> +	uasm_i_nop(p);
> +	uasm_l_tail_miss(l, *p);
> +	build_tlb_write_entry(p, l, r, tlb_random);
>  	uasm_l_leave(l, *p);
>  	build_restore_work_registers(p);
>  	uasm_i_eret(p); /* return from trap */
> 
