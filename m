Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2018 12:08:16 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.18]:60001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990435AbeBKLIJy0g16 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2018 12:08:09 +0100
Received: from [79.235.153.113] ([79.235.153.113]) by
 3c-app-gmx-bs58.server.lan (via HTTP); Sun, 11 Feb 2018 12:07:58 +0100
MIME-Version: 1.0
Message-ID: <trinity-48b02633-0f70-42cc-8d2f-e939cf2787bd-1518347278438@3c-app-gmx-bs58>
From:   =?UTF-8?Q?=22J=C3=BCrgen_Urban=22?= <JuergenUrban@gmx.de>
To:     "Fredrik Noring" <noring@nocrew.org>
Cc:     "Maciej W. Rozycki" <macro@mips.com>, linux-mips@linux-mips.org
Subject: Aw: [RFC] MIPS: R5900: The ERET instruction has issues with delay
 slot and CACHE
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Feb 2018 12:07:58 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20180211080914.GE2222@localhost.localdomain>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211080914.GE2222@localhost.localdomain>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:pHm3uXdLCredn6aF7LlS6oTHusbxKW6jHQssVzBj2bD
 kR5c87aWugLi+7E2gQYB0DSEXZC0SIUgGNSfjf8SnIJ6N8w+bv
 at7TPxjyVYkiPMxEcjjFI37J0h51Y/xGGvqjfPLkqbtsReb5Fi
 ERoZ7FwPvBLWbFcOffMlzP4SZp6dJg9rdp38QolAF4OsgXDoSU
 llItPM8mH4Ip7i90YV9nVEXKDW2vzWw/8RLMtYct8yQDpRvbGI
 byCtpeJjXTv3Anc58LL1QdWst+W0/yMX4UvbWOio7CJf+Bsxtn itOyag=
X-UI-Out-Filterresults: notjunk:1;V01:K0:zoSRwGC2cZs=:0+MetLaKJ+qb8Gv1+QaB+J
 YBYompNQrIb6yNZLVxMcEG5rbm/vbkKRRKU6f8N35BGgERPXHio/Wc0o9ugCCmF48vSGkYaar
 1pgIcpznreCQBa0Bq8QGMmKdZifJFCLBGpC6qVHLMapbGk5yP1veTSNKII7H16sZsUK/ol7ky
 3u5TDj/CqpIWtbPSwb86Dx9oo2f26jIgwmdl3BYPKUKTcx01aTmU3KtrfaAmUlN38A3Ie0gBU
 7oRmBX0xRaK/JdAGH7ZOFIclzryO8zHiA4PMmM5agvDr41YxOVuXwUOGiV7oQYXi60SA2uLxb
 Zdpbj4CMmTa2EEpljMZ4U/zzvAiEDh72gczA3AWWI9x6WWldn3ZcOr8UoM9Mwi3KnNzjUCjTu
 OtSZS6unliEWT1oZNCALlI5iZvmDA9JKpW/xMzfKxwx6mjrBhFgUr8S1aXMWs4GAFCgy9vsFU
 TNljziMzIHB8FCJYoc+J86JolL5DUZYtUvVU5TtmklPd1Rn0/qFl
Return-Path: <JuergenUrban@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: JuergenUrban@gmx.de
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

Hello Fredrik,

> Gesendet: Sonntag, 11. Februar 2018 um 09:09 Uhr
> Von: "Fredrik Noring" <noring@nocrew.org>
> An: "Maciej W. Rozycki" <macro@mips.com>, "Jürgen Urban" <JuergenUrban@gmx.de>
> Cc: linux-mips@linux-mips.org
> Betreff: [RFC] MIPS: R5900: The ERET instruction has issues with delay slot and CACHE
>
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
> This change has been ported from v2.6 patches. I have not found any note
> describing this in the TX79 manual.

The Restriction manual restri_e.pdf from Sony's Linux Toolkit says:

(2) Arrangement of Program Code and Cata 
When arraging program code and data in adjoining addresses, put 5 or more NOP instructions, or a combination of SYNC.P and NOP instructions between them. When the data arranged next to the program code has a specific bit pattern, it is regarded as a CACHE instruction, and may fetch a wrong instruction, destroy the data cache, or affect floating point divide of COP1.

(17) Undefined Instruction (2) 
Do not execute the following undefined instructions with specific bit pattern, since they interfere with the operation. 

a) Undefined instructions which interfere with floating-point calculations 
Inst[31:26]== 010001 &&
Inst[25:23]== 1*0 && 
(Inst[ 5: 9]== 010**1 || inst[5:0]==*1*011) 
Floating-point calculation results may cling to a certain value. This problem also occurs when this bit pattern 
exists in the data area next to the program code. Therefore, it is necessary to put 5 or more N0P 
instructions or a combination of SYNC.P and N0P instructions on the boundary between the program 
code and data. 

b) Undefined instructions which affect the data cache 
Inst[31:26]== 101111 && (Inst[20:16]== 10101 || 10111 || 11001 || 11011 || 11101 || 11110 || lllll) 
The data cache may be destroyed. An undefined instruction exception does not occcur. 

c) Undefined instructions which affect TLB entries 
Inst[31:26]==010000 && 
Inst[25:21]== 1**** && 
(Inst[ 5: 0]==000** || 0****1 || *01*** || ****1*) 
TLB entries may be destroyed.

Best regards
Jürgen

> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index e23765312e25..b67f31d04716 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1378,6 +1378,16 @@ static void build_r4000_tlb_refill_handler(void)
>  		uasm_l_leave(&l, p);
>  		uasm_i_eret(&p); /* return from trap */
>  	}
> +
> +#ifdef CONFIG_CPU_R5900
> +	/* There should be nothing which can be interpreted as cache instruction. */
> +	uasm_i_nop(&p);
> +	uasm_i_nop(&p);
> +	uasm_i_nop(&p);
> +	uasm_i_nop(&p);
> +	uasm_i_nop(&p);
> +#endif
> +
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>  	uasm_l_tlb_huge_update(&l, p);
>  	if (htlb_info.need_reload_pte)
> @@ -2132,6 +2142,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
>  	uasm_l_leave(l, *p);
>  	build_restore_work_registers(p);
>  	uasm_i_eret(p); /* return from trap */
> +#ifdef CONFIG_CPU_R5900
> +	/* There should be nothing which can be interpreted as cache instruction. */
> +	uasm_i_nop(p);
> +	uasm_i_nop(p);
> +	uasm_i_nop(p);
> +	uasm_i_nop(p);
> +	uasm_i_nop(p);
> +#endif
>  
>  #ifdef CONFIG_64BIT
>  	build_get_pgd_vmalloc64(p, l, r, tmp, ptr, not_refill);
>
