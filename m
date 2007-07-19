Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 21:17:09 +0100 (BST)
Received: from bay0-omc3-s35.bay0.hotmail.com ([65.54.246.235]:27108 "EHLO
	bay0-omc3-s35.bay0.hotmail.com") by ftp.linux-mips.org with ESMTP
	id S20022629AbXGSURH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 21:17:07 +0100
Received: from BAY124-DS3 ([207.46.11.158]) by bay0-omc3-s35.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Thu, 19 Jul 2007 13:17:00 -0700
X-Originating-IP: [82.152.169.203]
X-Originating-Email: [danieljlaird@hotmail.com]
Message-ID: <BAY124-DS362D171D52D42DEA949D3DCFB0@phx.gbl>
From:	<danieljlaird@hotmail.com>
To:	<linux-mips@linux-mips.org>
References: <469F822D.9040209@nxp.com> <469FA03E.7070209@ru.mvista.com>
Subject: Re: [PATCH] Fix known HW bug with MIPS core on NXP/Philips PNX8550
Date:	Thu, 19 Jul 2007 21:16:52 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 12.0.1184
X-MimeOLE: Produced By Microsoft MimeOLE V12.0.1184
X-OriginalArrivalTime: 19 Jul 2007 20:17:00.0559 (UTC) FILETIME=[C38951F0:01C7CA41]
Return-Path: <danieljlaird@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips

Cheers for all comments, will
1.) remove reinvented code
2.) Add explanation of exact bug (corruption of TLB)
3.) Use runtime checking instead of #ifdef
4.) Not use Thunderbird to post patches!

Cheers
Dan


----- Original Message -----
From: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
To: "Daniel Laird" <daniel.j.laird@nxp.com>
Cc: <linux-mips@linux-mips.org>
Sent: Thursday, July 19, 2007 6:32 PM
Subject: Re: [PATCH] Fix known HW bug with MIPS core on NXP/Philips PNX8550

> Hello.
>
> Daniel Laird wrote:
>
> > Fix known bug with MIPS core when using TLB on NXP/Philips PNX8550
>
>    Would've been god to somehow document it too...
>
>> Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com>
>
>> Index: linux-2.6.22.1/arch/mips/mm/tlbex.c
>> ===================================================================
>> --- linux-2.6.22.1/arch/mips/mm/tlbex.c    (revision 8)
>> +++ linux-2.6.22.1/arch/mips/mm/tlbex.c    (working copy)
> [...]
>> @@ -705,6 +719,7 @@
>>
>> /* Some CP0 registers */
>> #define C0_INDEX    0, 0
>> +#define C0_RANDOM   1, 0
>> #define C0_ENTRYLO0    2, 0
>> #define C0_TCBIND    2, 2
>> #define C0_ENTRYLO1    3, 0
>> @@ -712,6 +727,7 @@
>> #define C0_BADVADDR    8, 0
>> #define C0_ENTRYHI    10, 0
>> #define C0_EPC        14, 0
>> +#define C0_CONFIG    16, 0
>> #define C0_XCONTEXT    20, 0
>>
>> #ifdef CONFIG_64BIT
>> @@ -734,6 +750,57 @@
>> static __initdata struct label labels[128];
>> static __initdata struct reloc relocs[128];
>>
>> +#ifdef CONFIG_PNX8550
>> +static void __init build_pnx8550_bug_fix( u32 **p, struct label **l, 
>> struct reloc **r)
>> +{
>> +#define MFC0(_reg, _cp, _sel)    \
>> +    ((cop0_op)  << OP_SH    \
>> +    | (mfc_op) << RS_SH    \
>> +    | (_reg)   << RT_SH    \
>> +    | (_cp)    << RD_SH    \
>> +    | (_sel))
>> +
>> +#define MTC0(_reg, _cp, _sel)    \
>> +    ((cop0_op)  << OP_SH    \
>> +    | (mtc_op) << RS_SH    \
>> +    | (_reg)   << RT_SH    \
>> +    | (_cp)    << RD_SH    \
>> +    | (_sel))
>> +
>
>    Macro defs inside function, isn't that er... too much?
>    And don't we already have macro M() doing exactly what these two macros 
> are doing?
>
>> +    /* load epc and badvaddr to k0 and k1 */
>> +    i_MFC0(p, K0, C0_EPC);
>> +    i_MFC0(p, K1, C0_BADVADDR);
>> +
>> +    /* branch if code entry  */
>> +    il_beq(p, r, K0, K1, label_pnx8550_bac_reset);
>> +    i_addiu(p, K0, K0, 4);
>> +
>> +    /* branch if code entry in BDS */
>> +    il_beq(p, r, K0, K1, label_pnx8550_bac_reset);
>> +    i_nop(p);
>> +    /* Write data tlb entry 11..31 */
>> +    i_tlbwr(p);
>> +    i_eret(p);
>> +    /* BAC Reset */
>> +    l_pnx8550_bac_reset(l, *p);
>> +    **p = MFC0(K0, C0_CONFIG, 7);
>> +    (*p)++;
>
>    Hmmm, why we need another version of i_MFC0? After looking at the 
> currecnt code it seemed to me that i_M[FT]C0 are just using i_[d]m[ft]c0 
> incorrectly -- 
> those are difined to have 3 opcode args (by being built as I_u1u2u3() but 
> only get passed 2 args.  Hmm, I don't understand how i_[d]m[ft]c0() 
> invocations used to work before since they're alsway passing only 2 opcode 
> args where 3 are requiered...
>    Ah, that must be due to those tricky macros above -- with commas 
> inside.
> David, then this trickery is unacceptable -- add the needed macro instead; 
> and there's no need to use i_M[FT]C0() on a 32-bit only CPU, just use 
> i_m[ft]c0().
>
>> +    i_ori(p, K0, K0, (1<<14));
>> +
>> +    **p = MTC0(K0, C0_CONFIG, 7);
>> +    (*p)++;
>
>    So, this also won't do.
>
> [...]
>
> WBR, Sergei
>
> 
