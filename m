Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 02:11:36 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36321 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029173AbcELALbt-SNa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 02:11:31 +0200
Received: by mail-pf0-f194.google.com with SMTP id g132so4838986pfb.3;
        Wed, 11 May 2016 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=KLdCCrbQEaWSos9uKcT92YPO5uAIkKCg8ljO0H1mj6k=;
        b=QckV/HmfHHxYR3sT3Ps9p9uOnYzbUJtWUOXk7h9we6CzMVtubDKHJU6AUJdJJEhMx0
         3DDEWqInZcCZual3D40TXLI9GhWNAuoVc084AlWOvk3c9IQJ1Q6UEpMjLmvkrN2mh1xz
         NFtp75WQloma7ufKWEDBThgAtxmoBKuxvKoMumQaXLWDXsZmyHXTRsWH5iJYKDC8v5uM
         xkFjrpyIhdXaVXI/f4skW+O6dh0wDdF8/pM/NkGlRsxJeOvg4tEYwlvh/yvPPppyOEV7
         FVKfyQOodXNizhvPlecsNynyjeDBzK+2U+RH8ZHH4jDUwIY+V2z0hXibg7PhkUOtUPGU
         Gspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=KLdCCrbQEaWSos9uKcT92YPO5uAIkKCg8ljO0H1mj6k=;
        b=DUfhSUoM03IdWHqIRsKtulvVjGu4LxRcgERDZKqVXLycSBEcS3HgMFiX54BvxeuxAc
         jfw3ABCpqw3h+RzOq9rX+jYAhxInegDqztbF7bOkP61k222wphITuURzdLxjwE+86s8P
         urOKSfpRqNG86Y4L8bedfWN4WC5w9HYXImgg0reU0FgBNo9a1xiP0yLfU5AWxIGyf4UX
         3pBXmZ4pKRrZE6O6iopt4wQu+mRHcQ00dOEJs5F7vrif2sWm6xGMMePDsrNpVrpNYlzy
         x+2XINafT9aI177npXnYcIiv7gVvpBuGPWYDIMszNSe9M41GCbI5J1NfVrHIGTHoqu+N
         bDeg==
X-Gm-Message-State: AOPr4FUNv79uhtXnvMdZ+a+4M+BjDtp9Gb2uCY4/K8AFZsa0nHtXyV1gIq6g9FanmGKzVg==
X-Received: by 10.98.26.130 with SMTP id a124mr9270227pfa.39.1463011885478;
        Wed, 11 May 2016 17:11:25 -0700 (PDT)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id s124sm14858993pfb.63.2016.05.11.17.11.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 May 2016 17:11:23 -0700 (PDT)
Message-ID: <5733CA2A.4060900@gmail.com>
Date:   Wed, 11 May 2016 17:11:22 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/6] MIPS: Add register definitions for VZ ASE registers
References: <1462978232-10670-1-git-send-email-james.hogan@imgtec.com> <1462978232-10670-3-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1462978232-10670-3-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53386
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

On 05/11/2016 07:50 AM, James Hogan wrote:
> Add various register definitions to <asm/mipsregs.h> for the coprocessor
> zero registers in the VZ ASE, namely CP0_GuestCtl0, CP0_GuestCtl0Ext,
> CP0_GuestCtl1, CP0_GuestCtl2, CP0_GuestCtl3, and CP0_GTOffset.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

I assume all the numbers are correct.  These are indeed needed, so:

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   arch/mips/include/asm/mipsregs.h | 117 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 117 insertions(+)
>
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 480d51550dc0..951d92e5f771 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -55,8 +55,14 @@
>   #define CP0_BADINSTR $8, 1
>   #define CP0_COUNT $9
>   #define CP0_ENTRYHI $10
> +#define CP0_GUESTCTL1 $10, 4
> +#define CP0_GUESTCTL2 $10, 5
> +#define CP0_GUESTCTL3 $10, 6
>   #define CP0_COMPARE $11
> +#define CP0_GUESTCTL0EXT $11, 4
>   #define CP0_STATUS $12
> +#define CP0_GUESTCTL0 $12, 6
> +#define CP0_GTOFFSET $12, 7
>   #define CP0_CAUSE $13
>   #define CP0_EPC $14
>   #define CP0_PRID $15
> @@ -740,6 +746,94 @@
>   #define MIPS_PWCTL_PSN_SHIFT	0
>   #define MIPS_PWCTL_PSN_MASK	0x0000003f
>
> +/* GuestCtl0 fields */
> +#define MIPS_GCTL0_GM_SHIFT	31
> +#define MIPS_GCTL0_GM		(_ULCAST_(1) << MIPS_GCTL0_GM_SHIFT)
> +#define MIPS_GCTL0_RI_SHIFT	30
> +#define MIPS_GCTL0_RI		(_ULCAST_(1) << MIPS_GCTL0_RI_SHIFT)
> +#define MIPS_GCTL0_MC_SHIFT	29
> +#define MIPS_GCTL0_MC		(_ULCAST_(1) << MIPS_GCTL0_MC_SHIFT)
> +#define MIPS_GCTL0_CP0_SHIFT	28
> +#define MIPS_GCTL0_CP0		(_ULCAST_(1) << MIPS_GCTL0_CP0_SHIFT)
> +#define MIPS_GCTL0_AT_SHIFT	26
> +#define MIPS_GCTL0_AT		(_ULCAST_(0x3) << MIPS_GCTL0_AT_SHIFT)
> +#define MIPS_GCTL0_GT_SHIFT	25
> +#define MIPS_GCTL0_GT		(_ULCAST_(1) << MIPS_GCTL0_GT_SHIFT)
> +#define MIPS_GCTL0_CG_SHIFT	24
> +#define MIPS_GCTL0_CG		(_ULCAST_(1) << MIPS_GCTL0_CG_SHIFT)
> +#define MIPS_GCTL0_CF_SHIFT	23
> +#define MIPS_GCTL0_CF		(_ULCAST_(1) << MIPS_GCTL0_CF_SHIFT)
> +#define MIPS_GCTL0_G1_SHIFT	22
> +#define MIPS_GCTL0_G1		(_ULCAST_(1) << MIPS_GCTL0_G1_SHIFT)
> +#define MIPS_GCTL0_G0E_SHIFT	19
> +#define MIPS_GCTL0_G0E		(_ULCAST_(1) << MIPS_GCTL0_G0E_SHIFT)
> +#define MIPS_GCTL0_PT_SHIFT	18
> +#define MIPS_GCTL0_PT		(_ULCAST_(1) << MIPS_GCTL0_PT_SHIFT)
> +#define MIPS_GCTL0_RAD_SHIFT	9
> +#define MIPS_GCTL0_RAD		(_ULCAST_(1) << MIPS_GCTL0_RAD_SHIFT)
> +#define MIPS_GCTL0_DRG_SHIFT	8
> +#define MIPS_GCTL0_DRG		(_ULCAST_(1) << MIPS_GCTL0_DRG_SHIFT)
> +#define MIPS_GCTL0_G2_SHIFT	7
> +#define MIPS_GCTL0_G2		(_ULCAST_(1) << MIPS_GCTL0_G2_SHIFT)
> +#define MIPS_GCTL0_GEXC_SHIFT	2
> +#define MIPS_GCTL0_GEXC		(_ULCAST_(0x1f) << MIPS_GCTL0_GEXC_SHIFT)
> +#define MIPS_GCTL0_SFC2_SHIFT	1
> +#define MIPS_GCTL0_SFC2		(_ULCAST_(1) << MIPS_GCTL0_SFC2_SHIFT)
> +#define MIPS_GCTL0_SFC1_SHIFT	0
> +#define MIPS_GCTL0_SFC1		(_ULCAST_(1) << MIPS_GCTL0_SFC1_SHIFT)
> +
> +/* GuestCtl0.AT Guest address translation control */
> +#define MIPS_GCTL0_AT_ROOT	1  /* Guest MMU under Root control */
> +#define MIPS_GCTL0_AT_GUEST	3  /* Guest MMU under Guest control */
> +
> +/* GuestCtl0.GExcCode Hypervisor exception cause codes */
> +#define MIPS_GCTL0_GEXC_GPSI	0  /* Guest Privileged Sensitive Instruction */
> +#define MIPS_GCTL0_GEXC_GSFC	1  /* Guest Software Field Change */
> +#define MIPS_GCTL0_GEXC_HC	2  /* Hypercall */
> +#define MIPS_GCTL0_GEXC_GRR	3  /* Guest Reserved Instruction Redirect */
> +#define MIPS_GCTL0_GEXC_GVA	8  /* Guest Virtual Address available */
> +#define MIPS_GCTL0_GEXC_GHFC	9  /* Guest Hardware Field Change */
> +#define MIPS_GCTL0_GEXC_GPA	10 /* Guest Physical Address available */
> +
> +/* GuestCtl0Ext fields */
> +#define MIPS_GCTL0EXT_RPW_SHIFT	8
> +#define MIPS_GCTL0EXT_RPW	(_ULCAST_(0x3) << MIPS_GCTL0EXT_RPW_SHIFT)
> +#define MIPS_GCTL0EXT_NCC_SHIFT	6
> +#define MIPS_GCTL0EXT_NCC	(_ULCAST_(0x3) << MIPS_GCTL0EXT_NCC_SHIFT)
> +#define MIPS_GCTL0EXT_CGI_SHIFT	4
> +#define MIPS_GCTL0EXT_CGI	(_ULCAST_(1) << MIPS_GCTL0EXT_CGI_SHIFT)
> +#define MIPS_GCTL0EXT_FCD_SHIFT	3
> +#define MIPS_GCTL0EXT_FCD	(_ULCAST_(1) << MIPS_GCTL0EXT_FCD_SHIFT)
> +#define MIPS_GCTL0EXT_OG_SHIFT	2
> +#define MIPS_GCTL0EXT_OG	(_ULCAST_(1) << MIPS_GCTL0EXT_OG_SHIFT)
> +#define MIPS_GCTL0EXT_BG_SHIFT	1
> +#define MIPS_GCTL0EXT_BG	(_ULCAST_(1) << MIPS_GCTL0EXT_BG_SHIFT)
> +#define MIPS_GCTL0EXT_MG_SHIFT	0
> +#define MIPS_GCTL0EXT_MG	(_ULCAST_(1) << MIPS_GCTL0EXT_MG_SHIFT)
> +
> +/* GuestCtl0Ext.RPW Root page walk configuration */
> +#define MIPS_GCTL0EXT_RPW_BOTH	0  /* Root PW for GPA->RPA and RVA->RPA */
> +#define MIPS_GCTL0EXT_RPW_GPA	2  /* Root PW for GPA->RPA */
> +#define MIPS_GCTL0EXT_RPW_RVA	3  /* Root PW for RVA->RPA */
> +
> +/* GuestCtl0Ext.NCC Nested cache coherency attributes */
> +#define MIPS_GCTL0EXT_NCC_IND	0  /* Guest CCA independent of Root CCA */
> +#define MIPS_GCTL0EXT_NCC_MOD	1  /* Guest CCA modified by Root CCA */
> +
> +/* GuestCtl1 fields */
> +#define MIPS_GCTL1_ID_SHIFT	0
> +#define MIPS_GCTL1_ID_WIDTH	8
> +#define MIPS_GCTL1_ID		(_ULCAST_(0xff) << MIPS_GCTL1_ID_SHIFT)
> +#define MIPS_GCTL1_RID_SHIFT	16
> +#define MIPS_GCTL1_RID_WIDTH	8
> +#define MIPS_GCTL1_RID		(_ULCAST_(0xff) << MIPS_GCTL1_RID_SHIFT)
> +#define MIPS_GCTL1_EID_SHIFT	24
> +#define MIPS_GCTL1_EID_WIDTH	8
> +#define MIPS_GCTL1_EID		(_ULCAST_(0xff) << MIPS_GCTL1_EID_SHIFT)
> +
> +/* GuestID reserved for root context */
> +#define MIPS_GCTL1_ROOT_GUESTID	0
> +
>   /* CDMMBase register bit definitions */
>   #define MIPS_CDMMBASE_SIZE_SHIFT 0
>   #define MIPS_CDMMBASE_SIZE	(_ULCAST_(511) << MIPS_CDMMBASE_SIZE_SHIFT)
> @@ -1270,9 +1364,21 @@ do {									\
>   #define read_c0_entryhi()	__read_ulong_c0_register($10, 0)
>   #define write_c0_entryhi(val)	__write_ulong_c0_register($10, 0, val)
>
> +#define read_c0_guestctl1()	__read_32bit_c0_register($10, 4)
> +#define write_c0_guestctl1(val)	__write_32bit_c0_register($10, 4, val)
> +
> +#define read_c0_guestctl2()	__read_32bit_c0_register($10, 5)
> +#define write_c0_guestctl2(val)	__write_32bit_c0_register($10, 5, val)
> +
> +#define read_c0_guestctl3()	__read_32bit_c0_register($10, 6)
> +#define write_c0_guestctl3(val)	__write_32bit_c0_register($10, 6, val)
> +
>   #define read_c0_compare()	__read_32bit_c0_register($11, 0)
>   #define write_c0_compare(val)	__write_32bit_c0_register($11, 0, val)
>
> +#define read_c0_guestctl0ext()	__read_32bit_c0_register($11, 4)
> +#define write_c0_guestctl0ext(val) __write_32bit_c0_register($11, 4, val)
> +
>   #define read_c0_compare2()	__read_32bit_c0_register($11, 6) /* pnx8550 */
>   #define write_c0_compare2(val)	__write_32bit_c0_register($11, 6, val)
>
> @@ -1283,6 +1389,12 @@ do {									\
>
>   #define write_c0_status(val)	__write_32bit_c0_register($12, 0, val)
>
> +#define read_c0_guestctl0()	__read_32bit_c0_register($12, 6)
> +#define write_c0_guestctl0(val)	__write_32bit_c0_register($12, 6, val)
> +
> +#define read_c0_gtoffset()	__read_32bit_c0_register($12, 7)
> +#define write_c0_gtoffset(val)	__write_32bit_c0_register($12, 7, val)
> +
>   #define read_c0_cause()		__read_32bit_c0_register($13, 0)
>   #define write_c0_cause(val)	__write_32bit_c0_register($13, 0, val)
>
> @@ -2111,6 +2223,11 @@ __BUILD_SET_C0(intcontrol)
>   __BUILD_SET_C0(intctl)
>   __BUILD_SET_C0(srsmap)
>   __BUILD_SET_C0(pagegrain)
> +__BUILD_SET_C0(guestctl0)
> +__BUILD_SET_C0(guestctl0ext)
> +__BUILD_SET_C0(guestctl1)
> +__BUILD_SET_C0(guestctl2)
> +__BUILD_SET_C0(guestctl3)
>   __BUILD_SET_C0(brcm_config_0)
>   __BUILD_SET_C0(brcm_bus_pll)
>   __BUILD_SET_C0(brcm_reset)
>
