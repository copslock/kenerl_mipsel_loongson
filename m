Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 02:22:42 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:27814 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S21425695AbYJNBWk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 02:22:40 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m9E1MRdc027872;
	Mon, 13 Oct 2008 18:22:27 -0700 (PDT)
Received: from [128.224.162.196] ([128.224.162.196]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 13 Oct 2008 18:22:26 -0700
Message-ID: <48F3F499.3010508@windriver.com>
Date:	Tue, 14 Oct 2008 09:23:37 +0800
From:	Weiwei Wang <weiwei.wang@windriver.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	weiwei wang <veivei.vang@gmail.com>,
	Mark Mason <mason@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [Fwd: [bug report] 0xffffffffc0000000 can't be used on bcm1250]
References: <48EC9894.4080201@gmail.com> <20081008115001.GA21596@linux-mips.org> <48ED5BA5.4070301@gmail.com> <20081009131554.GB22796@linux-mips.org> <48EEBFE8.1000501@gmail.com> <alpine.LFD.1.10.0810101138180.19747@ftp.linux-mips.org> <48F2BC15.70408@gmail.com> <alpine.LFD.1.10.0810131508390.9667@ftp.linux-mips.org> <20081013162906.GB7144@linux-mips.org> <alpine.LFD.1.10.0810131842430.9667@ftp.linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0810131842430.9667@ftp.linux-mips.org>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2008 01:22:26.0768 (UTC) FILETIME=[5185E500:01C92D9B]
Return-Path: <Weiwei.Wang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiwei.wang@windriver.com
Precedence: bulk
X-list: linux-mips

Hi Maciej,

I have tried your suggested patch, and it works well.

And I am sorry to forget adding linux-mips to the cc list.

Thanks
Weiwei

Maciej W. Rozycki wrote:
> On Mon, 13 Oct 2008, weiwei wang wrote:
>
>   
>> your patch can't work. For the original code, I dump the memory mirror
>>     
>
>  Yes, that's correct -- it wasn't the best idea indeed.
>
>   
>> And I think the key issue is the field Fill / VPN2 in EntryHi, normally
>> this field will equal to corresponding field in BADVADDR. But for
>> address 0xffffffffc0000000, it doesn't; In the book "see mips run",
>> there is a description for register EntryHi:
>>     
>
>  Good point! -- you are correct.  This compatibility area is a special 
> case.  Thanks a lot for the analysis.
>
>   
>> Below is my patch, and it works well in my side.
>>
>> Signed-off-by: Weiwei Wang <weiwei.wang@windriver.com>
>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>> index 5a0835b..1b2ef20 100644
>> --- a/arch/mips/mm/tlbex.c
>> +++ b/arch/mips/mm/tlbex.c
>> @@ -674,6 +674,8 @@ static void __cpuinit
>> build_r4000_tlb_refill_handler(void)
>>                 UASM_i_MFC0(&p, K0, C0_BADVADDR);
>>                 UASM_i_MFC0(&p, K1, C0_ENTRYHI);
>>                 uasm_i_xor(&p, K0, K0, K1);
>> +               UASM_i_SLL(&p, K0, K0, 24);
>> +               UASM_i_SRL(&p, K0, K0, 24);
>>                 UASM_i_SRL(&p, K0, K0, PAGE_SHIFT + 1);
>>                 uasm_il_bnez(&p, &r, K0, label_leave);
>>                 /* No need for uasm_i_nop */
>>     
>
>  This is a hack for a single core type, so hardcoding the width of the 
> virtual address space is fine.  I am assuming you've got these right for 
> the SB-1.
>
>  However preserving the check of the two most significant bits is 
> desirable.  So I would suggest a patch as follows instead.
>
>   
>> Note: The bit-shift amount for dsrl in the range 0 to 31, so I split
>> into 2 dsrl operations.
>>     
>
>  That is actually not needed -- you can use DSRL32.
>
>  Please try the following patch and see if it works for you.  It boots 
> into the user mode for me with a 64-bit big-endian 16kB page 
> configuration, but I haven't checked it any further.
>
>   Maciej
>
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> patch-mips-2.6.27-rc8-20081004-sb1250-m3-3
> diff -up --recursive --new-file linux-mips-2.6.27-rc8-20081004.macro/arch/mips/mm/tlbex.c linux-mips-2.6.27-rc8-20081004/arch/mips/mm/tlbex.c
> --- linux-mips-2.6.27-rc8-20081004.macro/arch/mips/mm/tlbex.c	2008-10-13 14:45:55.000000000 +0000
> +++ linux-mips-2.6.27-rc8-20081004/arch/mips/mm/tlbex.c	2008-10-13 14:47:50.000000000 +0000
> @@ -6,7 +6,7 @@
>   * Synthesize TLB refill handlers at runtime.
>   *
>   * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
> - * Copyright (C) 2005, 2007  Maciej W. Rozycki
> + * Copyright (C) 2005, 2007, 2008  Maciej W. Rozycki
>   * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
>   *
>   * ... and the days got worse and worse and now you see
> @@ -200,6 +200,23 @@ static void __cpuinit build_r3000_tlb_re
>  static u32 final_handler[64] __cpuinitdata;
>  
>  /*
> + * To avoid the BCM1250 M3 erratum check whether EntryHi is consistent
> + * with BadVAddr and return for the exception to retrigger if not.
> + */
> +static void __cpuinit build_bcm1250_m3_war(u32 **p, struct uasm_reloc **r)
> +{
> +	uasm_i_dmfc0(p, K0, C0_BADVADDR);
> +	uasm_i_dmfc0(p, K1, C0_ENTRYHI);
> +	uasm_i_xor(p, K0, K0, K1);
> +	uasm_i_dsll(p, K1, K0, 24);
> +	uasm_i_dsrl32(p, K1, K1, (24 + PAGE_SHIFT + 1) - 32);
> +	uasm_i_dsrl32(p, K0, K0, 30);
> +	uasm_i_or(p, K0, K0, K1);
> +	uasm_il_bnez(p, r, K0, label_leave);
> +	/* No need for uasm_i_nop */
> +}
> +
> +/*
>   * Hazards
>   *
>   * From the IDT errata for the QED RM5230 (Nevada), processor revision 1.0:
> @@ -669,14 +686,8 @@ static void __cpuinit build_r4000_tlb_re
>  	/*
>  	 * create the plain linear handler
>  	 */
> -	if (bcm1250_m3_war()) {
> -		UASM_i_MFC0(&p, K0, C0_BADVADDR);
> -		UASM_i_MFC0(&p, K1, C0_ENTRYHI);
> -		uasm_i_xor(&p, K0, K0, K1);
> -		UASM_i_SRL(&p, K0, K0, PAGE_SHIFT + 1);
> -		uasm_il_bnez(&p, &r, K0, label_leave);
> -		/* No need for uasm_i_nop */
> -	}
> +	if (bcm1250_m3_war())
> +		build_bcm1250_m3_war(&p, &r);
>  
>  #ifdef CONFIG_64BIT
>  	build_get_pmde64(&p, &l, &r, K0, K1); /* get pmd in K1 */
> @@ -1132,14 +1143,8 @@ static void __cpuinit build_r4000_tlb_lo
>  	memset(labels, 0, sizeof(labels));
>  	memset(relocs, 0, sizeof(relocs));
>  
> -	if (bcm1250_m3_war()) {
> -		UASM_i_MFC0(&p, K0, C0_BADVADDR);
> -		UASM_i_MFC0(&p, K1, C0_ENTRYHI);
> -		uasm_i_xor(&p, K0, K0, K1);
> -		UASM_i_SRL(&p, K0, K0, PAGE_SHIFT + 1);
> -		uasm_il_bnez(&p, &r, K0, label_leave);
> -		/* No need for uasm_i_nop */
> -	}
> +	if (bcm1250_m3_war())
> +		build_bcm1250_m3_war(&p, &r);
>  
>  	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
>  	build_pte_present(&p, &l, &r, K0, K1, label_nopage_tlbl);
> diff -up --recursive --new-file linux-mips-2.6.27-rc8-20081004.macro/arch/mips/mm/uasm.c linux-mips-2.6.27-rc8-20081004/arch/mips/mm/uasm.c
> --- linux-mips-2.6.27-rc8-20081004.macro/arch/mips/mm/uasm.c	2008-10-13 14:45:55.000000000 +0000
> +++ linux-mips-2.6.27-rc8-20081004/arch/mips/mm/uasm.c	2008-10-13 14:50:42.000000000 +0000
> @@ -8,7 +8,7 @@
>   * effects like branch delay slots.
>   *
>   * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
> - * Copyright (C) 2005, 2007  Maciej W. Rozycki
> + * Copyright (C) 2005, 2007, 2008  Maciej W. Rozycki
>   * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
>   */
>  
> @@ -62,9 +62,10 @@ enum opcode {
>  	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
>  	insn_dsrl32, insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr,
>  	insn_ld, insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0,
> -	insn_mtc0, insn_ori, insn_pref, insn_rfe, insn_sc, insn_scd,
> -	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
> -	insn_tlbp, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori
> +	insn_mtc0, insn_or, insn_ori, insn_pref, insn_rfe, insn_sc,
> +	insn_scd, insn_sd, insn_sll, insn_sra, insn_srl, insn_subu,
> +	insn_sw, insn_tlbp, insn_tlbwi, insn_tlbwr, insn_xor,
> +	insn_xori
>  };
>  
>  struct insn {
> @@ -116,6 +117,7 @@ static struct insn insn_table[] __cpuini
>  	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
>  	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
>  	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
> +	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
>  	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
>  	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
>  	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
> @@ -361,6 +363,7 @@ I_u1s2(_lui)
>  I_u2s3u1(_lw)
>  I_u1u2u3(_mfc0)
>  I_u1u2u3(_mtc0)
> +I_u3u1u2(_or)
>  I_u2u1u3(_ori)
>  I_u2s3u1(_pref)
>  I_0(_rfe)
> diff -up --recursive --new-file linux-mips-2.6.27-rc8-20081004.macro/arch/mips/mm/uasm.h linux-mips-2.6.27-rc8-20081004/arch/mips/mm/uasm.h
> --- linux-mips-2.6.27-rc8-20081004.macro/arch/mips/mm/uasm.h	2008-10-13 14:45:55.000000000 +0000
> +++ linux-mips-2.6.27-rc8-20081004/arch/mips/mm/uasm.h	2008-10-13 14:26:23.000000000 +0000
> @@ -4,7 +4,7 @@
>   * for more details.
>   *
>   * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
> - * Copyright (C) 2005  Maciej W. Rozycki
> + * Copyright (C) 2005, 2008  Maciej W. Rozycki
>   * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
>   */
>  
> @@ -77,6 +77,7 @@ Ip_u1s2(_lui);
>  Ip_u2s3u1(_lw);
>  Ip_u1u2u3(_mfc0);
>  Ip_u1u2u3(_mtc0);
> +Ip_u3u1u2(_or);
>  Ip_u2u1u3(_ori);
>  Ip_u2s3u1(_pref);
>  Ip_0(_rfe);
