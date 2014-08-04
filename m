Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2014 15:10:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55585 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860164AbaHDNKnSe1pu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Aug 2014 15:10:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 34CB8EE11D773;
        Mon,  4 Aug 2014 14:10:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 4 Aug 2014 14:10:36 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 4 Aug
 2014 14:10:35 +0100
Message-ID: <53DF864B.6000702@imgtec.com>
Date:   Mon, 4 Aug 2014 14:10:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Aurelien Jarno <aurelien@aurel32.net>
CC:     David Daney <ddaney@caviumnetworks.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <james@albanarts.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: tlbex: fix a missing statement for HUGETLB
References: <1406616880-17142-1-git-send-email-chenhc@lemote.com> <2357839.vPXx615ci5@radagast> <53D9674E.4000507@caviumnetworks.com> <CAAhV-H51phVJvSTv_GMw15RpKp32vmNgj2QSzYzf+UOMK0koyw@mail.gmail.com> <53D99854.8090109@caviumnetworks.com> <53DA2E66.20200@imgtec.com> <53DA7E03.9090306@caviumnetworks.com> <20140802213538.GC19066@hall.aurel32.net> <53DF5BB2.70502@imgtec.com> <20140804130506.GA27352@hall.aurel32.net>
In-Reply-To: <20140804130506.GA27352@hall.aurel32.net>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41876
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

On 04/08/14 14:05, Aurelien Jarno wrote:
> On Mon, Aug 04, 2014 at 11:08:50AM +0100, James Hogan wrote:
>> Hi Aurelien,
>>
>> On 02/08/14 22:35, Aurelien Jarno wrote:
>>> On Thu, Jul 31, 2014 at 10:33:55AM -0700, David Daney wrote:
>>>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>>>> index f99ec587..341add1 100644
>>>> --- a/arch/mips/mm/tlbex.c
>>>> +++ b/arch/mips/mm/tlbex.c
>>>> @@ -1299,6 +1299,8 @@ static void build_r4000_tlb_refill_handler(void)
>>>>         }
>>>>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>>>>         uasm_l_tlb_huge_update(&l, p);
>>>> +       if (!use_bbit_insns())
>>>> +               UASM_i_LW(&p, K0, 0, K1);
>>>>         build_huge_update_entries(&p, htlb_info.huge_pte, K1);
>>>>         build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
>>>>                                    htlb_info.restore_scratch);
>>>
>>> This patch fixes the issue, thanks. That said it doesn't look fully
>>> correct. The test should be done the same way as for
>>> build_fast_tlb_refill_handler. For example the fast handler is not
>>> called on a 32-bit machine with bbit instructions, so it would need
>>> to reload K0.
>>
>> In the non fast case build_is_huge_pte() will still use bbit1 if
>> available after restoring K0, and I don't think the bbit1 would clobber
>> K0 when the branch is taken, so I think the test for !use_bbit_insns()
>> is correct.
>>
> Oh you are right! Therefore this second patch is:
> 
> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

Likewise:

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> Tested-by: Aurelien Jarno <aurelien@aurel32.net>
> 
