Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 13:54:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44776 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821694AbaGaLyWxy50J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 13:54:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8B63097034827;
        Thu, 31 Jul 2014 12:54:13 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 31 Jul 2014 12:54:15 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 31 Jul
 2014 12:54:14 +0100
Message-ID: <53DA2E66.20200@imgtec.com>
Date:   Thu, 31 Jul 2014 12:54:14 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>,
        Huacai Chen <chenhc@lemote.com>
CC:     James Hogan <james@albanarts.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: tlbex: fix a missing statement for HUGETLB
References: <1406616880-17142-1-git-send-email-chenhc@lemote.com> <2357839.vPXx615ci5@radagast> <53D9674E.4000507@caviumnetworks.com> <CAAhV-H51phVJvSTv_GMw15RpKp32vmNgj2QSzYzf+UOMK0koyw@mail.gmail.com> <53D99854.8090109@caviumnetworks.com>
In-Reply-To: <53D99854.8090109@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi,

On 31/07/14 02:13, David Daney wrote:
> On 07/30/2014 05:48 PM, Huacai Chen wrote:
>> For non-Octeon CPU, htlb_info.huge_pte is equal to K0, but I don't
>> know much about Octeon. So I think you know whether we should use K0
>>  or htlb_info.huge_pte here, since you are the original author.
>>
> 
> This is why I requested that somebody show me a disassembly of the
> faulty handler.  I cannot tell where the problem is unless I see that.
> 
> Really I think the problem is in build_is_huge_pte(), where we are
> clobbering 'tmp' which is K0.
> 
> So you could reload tmp/K0 in build_is_huge_pte().

Here's the difference with this patch (using k0) on an Octeon I have to
hand, with some slightly munged offsets for nicer diffing:

#define _PAGE_PRESENT_SHIFT 0
#define _PAGE_READ_SHIFT 0
#define _PAGE_WRITE_SHIFT 1
#define _PAGE_ACCESSED_SHIFT 2
#define _PAGE_MODIFIED_SHIFT 3
#define _PAGE_HUGE_SHIFT 4
#define _PAGE_SPLITTING_SHIFT 5
#define _PAGE_NO_EXEC_SHIFT 6
#define _PAGE_NO_READ_SHIFT 7
#define _PAGE_GLOBAL_SHIFT 8
#define _PAGE_VALID_SHIFT 9
#define _PAGE_DIRTY_SHIFT 10
#define _PFN_SHIFT 14

 00000000 <r4000_tlb_refill>:
+   0:	df7a0000 	ld	k0,0(k1)
    4:	00210a3a 	dror	at,at,0x8
    8:	40a11000 	dmtc0	at,c0_entrylo0
    c:	64214000 	daddiu	at,at,16384
   10:	40a11800 	dmtc0	at,c0_entrylo1
   14:	3c1a001f 	lui	k0,0x1f
   18:	375ae000 	ori	k0,k0,0xe000
   1c:	409a2800 	mtc0	k0,c0_pagemask
   20:	000000c0 	ehb
   24:	42000006 	tlbwr
   28:	40802800 	mtc0	zero,c0_pagemask
-  28:	1000002e 	b	e4 <r4000_tlb_refill+0xe4>
+  2c:	1000002d 	b	e4 <r4000_tlb_refill+0xe4>
   30:	4021f802 	dmfc0	at,$31,2
-  30:	07400019 	bltz	k0,98 <r4000_tlb_refill+0x98>
+  34:	07400018 	bltz	k0,98 <r4000_tlb_refill+0x98>
   38:	3c1b81da 	lui	k1,0x81da
   3c:	3c1b8113 	lui	k1,0x8113
-  3c:	277b7ef0 	addiu	k1,k1,32496
+  40:	277b7f00 	addiu	k1,k1,32512
   44:	03600008 	jr	k1
   48:	4021f802 	dmfc0	at,$31,2
 	...
   80:	403a4000 	dmfc0	k0,c0_badvaddr
   84:	403bf803 	dmfc0	k1,$31,3
   88:	40a1f802 	dmtc0	at,$31,2
   8c:	001a0a3e 	dsrl32	at,k0,0x8
-  90:	1420ffe7 	bnez	at,30 <r4000_tlb_refill+0x30>
+  90:	1420ffe8 	bnez	at,34 <r4000_tlb_refill+0x34>
   94:	001a0efa 	dsrl	at,k0,0x1b
   98:	30211ff8 	andi	at,at,0x1ff8
   9c:	7c3bda0a 	ldx	k1,k1(at)
   a0:	001a0cba 	dsrl	at,k0,0x12
   a4:	30210ff8 	andi	at,at,0xff8
   a8:	403aa000 	dmfc0	k0,c0_xcontext
   ac:	7c3b0a0a 	ldx	at,k1(at)
   b0:	335a0ff0 	andi	k0,k0,0xff0
   b4:	e824ffd2 	bbit1	at,0x4,0 <r4000_tlb_refill>
   b8:	00000000 	nop
   bc:	7c3ada0a 	ldx	k1,k0(at)
   c0:	675a0008 	daddiu	k0,k0,8
   c4:	7c3ad20a 	ldx	k0,k0(at)
   c8:	003bda3a 	dror	k1,k1,0x8
   cc:	40bb1000 	dmtc0	k1,c0_entrylo0
   d0:	003ad23a 	dror	k0,k0,0x8
   d4:	40ba1800 	dmtc0	k0,c0_entrylo1
   d8:	4021f802 	dmfc0	at,$31,2
   dc:	000000c0 	ehb
   e0:	42000006 	tlbwr
   e4:	42000018 	eret


b4 is apparently where it branches back to the huge page case at the
beginning. In that case the at register (htlb_info.huge_pte) is set to
*(k1+at) instead of *(k1), so loading to htlb_info.huge_pte instead of
k0 would I think be bad and change the behaviour. So forget my suggestion!

On the other hand loading the pte to k0 is redundant when
build_fast_tlb_refill_handler is used (which depends on bbit1), and also
in the other case if bbit1 is available since it won't get clobbered by
build_is_huge_pte().

Maybe the reload should simply be conditional on !use_bbit_insns()?

Cheers
James
