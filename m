Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 18:31:17 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:64917 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021404AbXGSRbO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2007 18:31:14 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id AA0D03EC9; Thu, 19 Jul 2007 10:30:41 -0700 (PDT)
Message-ID: <469FA03E.7070209@ru.mvista.com>
Date:	Thu, 19 Jul 2007 21:32:46 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix known HW bug with MIPS core on NXP/Philips PNX8550
References: <469F822D.9040209@nxp.com>
In-Reply-To: <469F822D.9040209@nxp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Daniel Laird wrote:

 > Fix known bug with MIPS core when using TLB on NXP/Philips PNX8550

    Would've been god to somehow document it too...

> Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com>

> Index: linux-2.6.22.1/arch/mips/mm/tlbex.c
> ===================================================================
> --- linux-2.6.22.1/arch/mips/mm/tlbex.c    (revision 8)
> +++ linux-2.6.22.1/arch/mips/mm/tlbex.c    (working copy)
[...]
> @@ -705,6 +719,7 @@
> 
> /* Some CP0 registers */
> #define C0_INDEX    0, 0
> +#define C0_RANDOM   1, 0
> #define C0_ENTRYLO0    2, 0
> #define C0_TCBIND    2, 2
> #define C0_ENTRYLO1    3, 0
> @@ -712,6 +727,7 @@
> #define C0_BADVADDR    8, 0
> #define C0_ENTRYHI    10, 0
> #define C0_EPC        14, 0
> +#define C0_CONFIG    16, 0
> #define C0_XCONTEXT    20, 0
> 
> #ifdef CONFIG_64BIT
> @@ -734,6 +750,57 @@
> static __initdata struct label labels[128];
> static __initdata struct reloc relocs[128];
> 
> +#ifdef CONFIG_PNX8550
> +static void __init build_pnx8550_bug_fix( u32 **p, struct label **l, 
> struct reloc **r)
> +{
> +#define MFC0(_reg, _cp, _sel)    \
> +    ((cop0_op)  << OP_SH    \
> +    | (mfc_op) << RS_SH    \
> +    | (_reg)   << RT_SH    \
> +    | (_cp)    << RD_SH    \
> +    | (_sel))
> +
> +#define MTC0(_reg, _cp, _sel)    \
> +    ((cop0_op)  << OP_SH    \
> +    | (mtc_op) << RS_SH    \
> +    | (_reg)   << RT_SH    \
> +    | (_cp)    << RD_SH    \
> +    | (_sel))
> +

    Macro defs inside function, isn't that er... too much?
    And don't we already have macro M() doing exactly what these two macros 
are doing?

> +    /* load epc and badvaddr to k0 and k1 */
> +    i_MFC0(p, K0, C0_EPC);
> +    i_MFC0(p, K1, C0_BADVADDR);
> +
> +    /* branch if code entry  */
> +    il_beq(p, r, K0, K1, label_pnx8550_bac_reset);
> +    i_addiu(p, K0, K0, 4);
> +
> +    /* branch if code entry in BDS */
> +    il_beq(p, r, K0, K1, label_pnx8550_bac_reset);
> +    i_nop(p);
> +    /* Write data tlb entry 11..31 */
> +    i_tlbwr(p);
> +    i_eret(p);
> +    /* BAC Reset */
> +    l_pnx8550_bac_reset(l, *p);
> +    **p = MFC0(K0, C0_CONFIG, 7);
> +    (*p)++;

    Hmmm, why we need another version of i_MFC0? After looking at the currecnt 
code it seemed to me that i_M[FT]C0 are just using i_[d]m[ft]c0 incorrectly -- 
those are difined to have 3 opcode args (by being built as I_u1u2u3() but only 
get passed 2 args.  Hmm, I don't understand how i_[d]m[ft]c0() invocations 
used to work before since they're alsway passing only 2 opcode args where 3 
are requiered...
    Ah, that must be due to those tricky macros above -- with commas inside.
David, then this trickery is unacceptable -- add the needed macro instead; and 
there's no need to use i_M[FT]C0() on a 32-bit only CPU, just use i_m[ft]c0().

> +    i_ori(p, K0, K0, (1<<14));
> +
> +    **p = MTC0(K0, C0_CONFIG, 7);
> +    (*p)++;

    So, this also won't do.

[...]

WBR, Sergei
