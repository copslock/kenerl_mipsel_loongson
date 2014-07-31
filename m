Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 03:14:23 +0200 (CEST)
Received: from mail-bl2lp0207.outbound.protection.outlook.com ([207.46.163.207]:12483
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6860069AbaGaBOUbmOfb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jul 2014 03:14:20 +0200
Received: from dl.caveonetworks.com (64.2.3.195) by
 DM2PR07MB592.namprd07.prod.outlook.com (10.141.176.143) with Microsoft SMTP
 Server (TLS) id 15.0.995.14; Thu, 31 Jul 2014 01:13:59 +0000
Message-ID: <53D99854.8090109@caviumnetworks.com>
Date:   Wed, 30 Jul 2014 18:13:56 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
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
References: <1406616880-17142-1-git-send-email-chenhc@lemote.com> <2357839.vPXx615ci5@radagast> <53D9674E.4000507@caviumnetworks.com> <CAAhV-H51phVJvSTv_GMw15RpKp32vmNgj2QSzYzf+UOMK0koyw@mail.gmail.com>
In-Reply-To: <CAAhV-H51phVJvSTv_GMw15RpKp32vmNgj2QSzYzf+UOMK0koyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-ClientProxiedBy: BY2PR07CA049.namprd07.prod.outlook.com (10.141.251.24) To
 DM2PR07MB592.namprd07.prod.outlook.com (10.141.176.143)
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(199002)(189002)(24454002)(479174003)(51704005)(377454003)(66066001)(47776003)(20776003)(65956001)(64706001)(77982001)(59896001)(81542001)(46102001)(4396001)(74662001)(105586002)(81342001)(69596002)(80022001)(65816999)(575784001)(87266999)(54356999)(79102001)(50986999)(95666004)(76176999)(74502001)(83506001)(92726001)(92566001)(85306003)(87976001)(80316001)(33656002)(99396002)(110136001)(83072002)(36756003)(93886003)(76482001)(77096002)(85852003)(21056001)(42186005)(23676002)(53416004)(31966008)(106356001)(50466002)(81156004)(19580405001)(19580395003)(101416001)(83322001)(107046002)(102836001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB592;H:dl.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;LANG:en;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41833
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

On 07/30/2014 05:48 PM, Huacai Chen wrote:
> Hi, David,
>
> For non-Octeon CPU, htlb_info.huge_pte is equal to K0, but I don't
> know much about Octeon. So I think you know whether we should use K0
>  or htlb_info.huge_pte here, since you are the original author.
>

This is why I requested that somebody show me a disassembly of the
faulty handler.  I cannot tell where the problem is unless I see that.

Really I think the problem is in build_is_huge_pte(), where we are
clobbering 'tmp' which is K0.

So you could reload tmp/K0 in build_is_huge_pte().

> On Thu, Jul 31, 2014 at 5:44 AM, David Daney
> <ddaney@caviumnetworks.com> wrote:
>> On 07/30/2014 02:41 PM, James Hogan wrote:
>>>
>>> Hi Huacai,
>>>
>>> On Tuesday 29 July 2014 14:54:40 Huacai Chen wrote:
>>>>
>>>> In commit 2c8c53e28f1 (MIPS: Optimize TLB handlers for Octeon
>>>> CPUs) build_r4000_tlb_refill_handler() is modified. But it
>>>> doesn't compatible with the original code in HUGETLB case.
>>>> Because there is a copy & paste error and one line of code is
>>>> missing. It is very easy to produce a bug with LTP's
>>>> hugemmap05 test.
>>>>
>>>> Signed-off-by: Huacai Chen <chenhc@lemote.com> Signed-off-by:
>>>> Binbin Zhou <zhoubb@lemote.com> Cc: <stable@vger.kernel.org>
>>>> --- arch/mips/mm/tlbex.c | 1 + 1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c index
>>>> e80e10b..343fe0f 100644 --- a/arch/mips/mm/tlbex.c +++
>>>> b/arch/mips/mm/tlbex.c @@ -1299,6 +1299,7 @@ static void
>>>> build_r4000_tlb_refill_handler(void) } #ifdef
>>>> CONFIG_MIPS_HUGE_TLB_SUPPORT uasm_l_tlb_huge_update(&l, p); +
>>>> UASM_i_LW(&p, K0, 0, K1); build_huge_update_entries(&p,
>>>> htlb_info.huge_pte, K1); build_huge_tlb_write_entry(&p, &l,
>>>> &r, K0, tlb_random, htlb_info.restore_scratch);
>>>
>>>
>>> build_huge_tlb_write_entry only uses K0 as a temp and clobbers
>>> without using the value, so the K0 must be being used by the
>>> code generated by build_huge_update_entires, but the patch you
>>> mentioned changed the second argument from K0 to
>>> htlb_info.huge_pte.
>>>
>>> So should the K0 in the new UASM_i_LW call be changed to
>>> htlb_info.huge_pte too?
>>>
>>
>> I don't know.  You have to dump out the generated handler (by
>> #define DEBUG at the top of the file), then assemble/disassemble
>> it.  Looking at the disassembly, we could make sensible statements
>> about what is happening.
>>
>>
>>
>>> (David Daney on Cc)
>>>
>>> Thanks James
>>>
>>
>>
