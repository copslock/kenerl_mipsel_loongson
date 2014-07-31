Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 19:34:13 +0200 (CEST)
Received: from mail-bn1blp0182.outbound.protection.outlook.com ([207.46.163.182]:53059
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6860175AbaGaReKi08Ru (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jul 2014 19:34:10 +0200
Received: from BY2PR07MB583.namprd07.prod.outlook.com (10.141.221.155) by
 BY2PR07MB988.namprd07.prod.outlook.com (10.242.47.156) with Microsoft SMTP
 Server (TLS) id 15.0.995.14; Thu, 31 Jul 2014 17:34:02 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by
 BY2PR07MB583.namprd07.prod.outlook.com (10.141.221.155) with Microsoft SMTP
 Server (TLS) id 15.0.995.14; Thu, 31 Jul 2014 17:33:59 +0000
Message-ID: <53DA7E03.9090306@caviumnetworks.com>
Date:   Thu, 31 Jul 2014 10:33:55 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Huacai Chen <chenhc@lemote.com>, James Hogan <james@albanarts.com>,
        "Linux MIPS Mailing List" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: tlbex: fix a missing statement for HUGETLB
References: <1406616880-17142-1-git-send-email-chenhc@lemote.com> <2357839.vPXx615ci5@radagast> <53D9674E.4000507@caviumnetworks.com> <CAAhV-H51phVJvSTv_GMw15RpKp32vmNgj2QSzYzf+UOMK0koyw@mail.gmail.com> <53D99854.8090109@caviumnetworks.com> <53DA2E66.20200@imgtec.com>
In-Reply-To: <53DA2E66.20200@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-ClientProxiedBy: SN2PR07CA002.namprd07.prod.outlook.com (10.255.174.19) To
 BY2PR07MB583.namprd07.prod.outlook.com (10.141.221.155)
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(377454003)(479174003)(24454002)(51704005)(199002)(189002)(83322001)(50466002)(65816999)(64126003)(46102001)(65806001)(59896001)(33656002)(79102001)(74502001)(80316001)(31966008)(85306003)(74662001)(81342001)(36756003)(81156004)(83072002)(106356001)(77982001)(85852003)(575784001)(54356999)(80022001)(47776003)(95666004)(107046002)(21056001)(102836001)(64706001)(93886003)(42186005)(65956001)(50986999)(92566001)(87266999)(69596002)(92726001)(101416001)(76482001)(105586002)(23676002)(87976001)(77096002)(53416004)(110136001)(20776003)(81542001)(99396002)(66066001)(4396001)(76176999);DIR:OUT;SFP:;SCL:1;SRVR:BY2PR07MB583;H:dl.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;LANG:en;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 07/31/2014 04:54 AM, James Hogan wrote:
> Hi,
>
> On 31/07/14 02:13, David Daney wrote:
>> On 07/30/2014 05:48 PM, Huacai Chen wrote:
>>> For non-Octeon CPU, htlb_info.huge_pte is equal to K0, but I don't
>>> know much about Octeon. So I think you know whether we should use K0
>>>   or htlb_info.huge_pte here, since you are the original author.
>>>
>>
>> This is why I requested that somebody show me a disassembly of the
>> faulty handler.  I cannot tell where the problem is unless I see that.
>>
>> Really I think the problem is in build_is_huge_pte(), where we are
>> clobbering 'tmp' which is K0.
>>
>> So you could reload tmp/K0 in build_is_huge_pte().
>
> Here's the difference with this patch (using k0) on an Octeon I have to
> hand, with some slightly munged offsets for nicer diffing:
>
> #define _PAGE_PRESENT_SHIFT 0
> #define _PAGE_READ_SHIFT 0
> #define _PAGE_WRITE_SHIFT 1
> #define _PAGE_ACCESSED_SHIFT 2
> #define _PAGE_MODIFIED_SHIFT 3
> #define _PAGE_HUGE_SHIFT 4
> #define _PAGE_SPLITTING_SHIFT 5
> #define _PAGE_NO_EXEC_SHIFT 6
> #define _PAGE_NO_READ_SHIFT 7
> #define _PAGE_GLOBAL_SHIFT 8
> #define _PAGE_VALID_SHIFT 9
> #define _PAGE_DIRTY_SHIFT 10
> #define _PFN_SHIFT 14
>
>   00000000 <r4000_tlb_refill>:
> +   0:	df7a0000 	ld	k0,0(k1)

Completely redundant, it is not used and then clobbered...

>      4:	00210a3a 	dror	at,at,0x8
>      8:	40a11000 	dmtc0	at,c0_entrylo0
>      c:	64214000 	daddiu	at,at,16384
>     10:	40a11800 	dmtc0	at,c0_entrylo1
>     14:	3c1a001f 	lui	k0,0x1f

... here.

>     18:	375ae000 	ori	k0,k0,0xe000
>     1c:	409a2800 	mtc0	k0,c0_pagemask
>     20:	000000c0 	ehb
>     24:	42000006 	tlbwr
>     28:	40802800 	mtc0	zero,c0_pagemask
> -  28:	1000002e 	b	e4 <r4000_tlb_refill+0xe4>
> +  2c:	1000002d 	b	e4 <r4000_tlb_refill+0xe4>
>     30:	4021f802 	dmfc0	at,$31,2
> -  30:	07400019 	bltz	k0,98 <r4000_tlb_refill+0x98>
> +  34:	07400018 	bltz	k0,98 <r4000_tlb_refill+0x98>
>     38:	3c1b81da 	lui	k1,0x81da
>     3c:	3c1b8113 	lui	k1,0x8113
> -  3c:	277b7ef0 	addiu	k1,k1,32496
> +  40:	277b7f00 	addiu	k1,k1,32512
>     44:	03600008 	jr	k1
>     48:	4021f802 	dmfc0	at,$31,2
>   	...
>     80:	403a4000 	dmfc0	k0,c0_badvaddr
>     84:	403bf803 	dmfc0	k1,$31,3
>     88:	40a1f802 	dmtc0	at,$31,2
>     8c:	001a0a3e 	dsrl32	at,k0,0x8
> -  90:	1420ffe7 	bnez	at,30 <r4000_tlb_refill+0x30>
> +  90:	1420ffe8 	bnez	at,34 <r4000_tlb_refill+0x34>
>     94:	001a0efa 	dsrl	at,k0,0x1b
>     98:	30211ff8 	andi	at,at,0x1ff8
>     9c:	7c3bda0a 	ldx	k1,k1(at)
>     a0:	001a0cba 	dsrl	at,k0,0x12
>     a4:	30210ff8 	andi	at,at,0xff8
>     a8:	403aa000 	dmfc0	k0,c0_xcontext
>     ac:	7c3b0a0a 	ldx	at,k1(at)
>     b0:	335a0ff0 	andi	k0,k0,0xff0
>     b4:	e824ffd2 	bbit1	at,0x4,0 <r4000_tlb_refill>
>     b8:	00000000 	nop
>     bc:	7c3ada0a 	ldx	k1,k0(at)
>     c0:	675a0008 	daddiu	k0,k0,8
>     c4:	7c3ad20a 	ldx	k0,k0(at)
>     c8:	003bda3a 	dror	k1,k1,0x8
>     cc:	40bb1000 	dmtc0	k1,c0_entrylo0
>     d0:	003ad23a 	dror	k0,k0,0x8
>     d4:	40ba1800 	dmtc0	k0,c0_entrylo1
>     d8:	4021f802 	dmfc0	at,$31,2
>     dc:	000000c0 	ehb
>     e0:	42000006 	tlbwr
>     e4:	42000018 	eret
>
>
> b4 is apparently where it branches back to the huge page case at the
> beginning. In that case the at register (htlb_info.huge_pte) is set to
> *(k1+at) instead of *(k1), so loading to htlb_info.huge_pte instead of
> k0 would I think be bad and change the behaviour. So forget my suggestion!
>
> On the other hand loading the pte to k0 is redundant when
> build_fast_tlb_refill_handler is used (which depends on bbit1), and also
> in the other case if bbit1 is available since it won't get clobbered by
> build_is_huge_pte().
>
> Maybe the reload should simply be conditional on !use_bbit_insns()?
>

That was kind of my suggestion.  What happens if you do something like 
(untested):

--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -716,6 +716,7 @@ build_is_huge_pte(u32 **p, struct uasm_reloc **r, 
unsigned int tmp,
         } else {
                 uasm_i_andi(p, tmp, tmp, _PAGE_HUGE);
                 uasm_il_bnez(p, r, tmp, lid);
+               UASM_i_LW(p, tmp, 0, pmd);
         }
  }

or

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index f99ec587..341add1 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1299,6 +1299,8 @@ static void build_r4000_tlb_refill_handler(void)
         }
  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
         uasm_l_tlb_huge_update(&l, p);
+       if (!use_bbit_insns())
+               UASM_i_LW(&p, K0, 0, K1);
         build_huge_update_entries(&p, htlb_info.huge_pte, K1);
         build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
                                    htlb_info.restore_scratch);


> Cheers
> James
>
>
