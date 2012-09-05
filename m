Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2012 23:11:42 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:39599 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903404Ab2IEVLg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2012 23:11:36 +0200
Received: by pbbrq8 with SMTP id rq8so1582762pbb.36
        for <multiple recipients>; Wed, 05 Sep 2012 14:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=24EXvvZ5ufYlRcNR0i5pAw348K2IR8fKHL/CFSCFQEo=;
        b=kuQO+pvVBoc5rG87zSOU/yuib9lO9/BmYIs8YNxhCx62A20mY4Y0WwWS9Hvt4LVGKU
         HVfnq9di7vsw6Pazkn8RTxau4d+Yno3pKTDnSs3mHyrbxHqP7jrnTNfJ8smYDCL37426
         h4C4OZXljwJ3ZM6MLxnW7shcB+cA6BeMrp63EwhAGpMy5JGXf7NedRxRWsEaD0moHGsN
         C7Ss/GZVokRmyi/s0z6oMtKfwOJB4r+SPRWOFFBxNn8gjlmE+RF5iNkvpurcOFaNEnRV
         txIvaYMKvQRWMY/CemGmb8V0ryclfhWRu6cOrs7GROh9Hfz+KiHHYq1mdsrALvfSagoP
         7ROw==
Received: by 10.68.225.196 with SMTP id rm4mr565942pbc.131.1346879489642;
        Wed, 05 Sep 2012 14:11:29 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id sr3sm149382pbc.44.2012.09.05.14.11.27
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 14:11:28 -0700 (PDT)
Message-ID: <5047BFFE.1070109@gmail.com>
Date:   Wed, 05 Sep 2012 14:11:26 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/4] MIPS: Remove kernel_uses_smartmips_rixi use from
 arch/mips/mm.
References: <1346876878-25965-1-git-send-email-sjhill@mips.com> <1346876878-25965-3-git-send-email-sjhill@mips.com>
In-Reply-To: <1346876878-25965-3-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34424
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/05/2012 01:27 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Remove usage of the 'kernel_uses_smartmips_rixi' macro from all files
> in the 'arch/mips/mm' subsystem.
>

> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index e565d45..90c86ee 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -601,7 +601,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
>   static __cpuinit __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
>   								  unsigned int reg)
>   {
> -	if (kernel_uses_smartmips_rixi) {
> +	if (cpu_has_ri | cpu_has_xi) {
>   		UASM_i_SRL(p, reg, reg, ilog2(_PAGE_NO_EXEC));
>   		UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));

Patch is out of date.

This will not apply against mips-for-linux-next.

>   	} else {
> @@ -1021,7 +1021,7 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
>   	if (cpu_has_64bits) {
>   		uasm_i_ld(p, tmp, 0, ptep); /* get even pte */
>   		uasm_i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
> -		if (kernel_uses_smartmips_rixi) {
> +		if (cpu_has_ri | cpu_has_xi) {
>   			UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
>   			UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
>   			UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
> @@ -1048,7 +1048,7 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
>   	UASM_i_LW(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
>   	if (r45k_bvahwbug())
>   		build_tlb_probe_entry(p);
> -	if (kernel_uses_smartmips_rixi) {
> +	if (cpu_has_ri | cpu_has_xi) {
>   		UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
>   		UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
>   		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
> @@ -1214,7 +1214,7 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
>   		UASM_i_LW(p, even, 0, ptr); /* get even pte */
>   		UASM_i_LW(p, odd, sizeof(pte_t), ptr); /* get odd pte */
>   	}
> -	if (kernel_uses_smartmips_rixi) {
> +	if (cpu_has_ri | cpu_has_xi) {
>   		uasm_i_dsrl_safe(p, even, even, ilog2(_PAGE_NO_EXEC));
>   		uasm_i_dsrl_safe(p, odd, odd, ilog2(_PAGE_NO_EXEC));
>   		uasm_i_drotr(p, even, even,
> @@ -1576,7 +1576,7 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
>   {
>   	int t = scratch >= 0 ? scratch : pte;
>
> -	if (kernel_uses_smartmips_rixi) {
> +	if (cpu_has_ri | cpu_has_xi) {
>   		if (use_bbit_insns()) {
>   			uasm_il_bbit0(p, r, pte, ilog2(_PAGE_PRESENT), lid);
>   			uasm_i_nop(p);
> @@ -1906,7 +1906,7 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
>   	if (m4kc_tlbp_war())
>   		build_tlb_probe_entry(&p);
>
> -	if (kernel_uses_smartmips_rixi) {
> +	if (cpu_has_ri | cpu_has_xi) {

These bits should be made conditional on the value of PageGrain[IEC].

Also when PageGrain[IEC] is set you would have to install the proper 
exception handlers for TLBRI and TLBXI ExecCodes.

>   		/*
>   		 * If the page is not _PAGE_VALID, RI or XI could not
>   		 * have triggered it.  Skip the expensive test..
> @@ -1960,7 +1960,7 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
>   	build_pte_present(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbl);
>   	build_tlb_probe_entry(&p);
>
> -	if (kernel_uses_smartmips_rixi) {
> +	if (cpu_has_ri | cpu_has_xi) {
>   		/*
>   		 * If the page is not _PAGE_VALID, RI or XI could not
>   		 * have triggered it.  Skip the expensive test..
>
