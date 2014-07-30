Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 23:45:07 +0200 (CEST)
Received: from mail-by2lp0243.outbound.protection.outlook.com ([207.46.163.243]:29714
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6860069AbaG3VpD5rUCm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jul 2014 23:45:03 +0200
Received: from DM2PR07MB589.namprd07.prod.outlook.com (10.141.176.139) by
 DM2PR07MB255.namprd07.prod.outlook.com (10.141.101.18) with Microsoft SMTP
 Server (TLS) id 15.0.995.14; Wed, 30 Jul 2014 21:44:55 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by
 DM2PR07MB589.namprd07.prod.outlook.com (10.141.176.139) with Microsoft SMTP
 Server (TLS) id 15.0.995.14; Wed, 30 Jul 2014 21:44:52 +0000
Message-ID: <53D9674E.4000507@caviumnetworks.com>
Date:   Wed, 30 Jul 2014 14:44:46 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james@albanarts.com>
CC:     <linux-mips@linux-mips.org>, Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: tlbex: fix a missing statement for HUGETLB
References: <1406616880-17142-1-git-send-email-chenhc@lemote.com> <2357839.vPXx615ci5@radagast>
In-Reply-To: <2357839.vPXx615ci5@radagast>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-ClientProxiedBy: BY2PR07CA049.namprd07.prod.outlook.com (10.141.251.24) To
 DM2PR07MB589.namprd07.prod.outlook.com (10.141.176.139)
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(51704005)(199002)(189002)(377454003)(479174003)(24454002)(102836001)(87266999)(54356999)(76176999)(99396002)(65816999)(106356001)(50986999)(81156004)(79102001)(66066001)(110136001)(69596002)(20776003)(101416001)(74502001)(64706001)(65956001)(80022001)(85306003)(50466002)(46102001)(31966008)(65806001)(81342001)(59896001)(77096002)(76482001)(81542001)(80316001)(64126003)(77982001)(23756003)(87976001)(19580395003)(83506001)(83322001)(4396001)(19580405001)(85852003)(92726001)(83072002)(36756003)(92566001)(21056001)(47776003)(33656002)(575784001)(95666004)(107046002)(74662001)(42186005)(53416004);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB589;H:dl.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;LANG:en;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41825
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

On 07/30/2014 02:41 PM, James Hogan wrote:
> Hi Huacai,
>
> On Tuesday 29 July 2014 14:54:40 Huacai Chen wrote:
>> In commit 2c8c53e28f1 (MIPS: Optimize TLB handlers for Octeon CPUs)
>> build_r4000_tlb_refill_handler() is modified. But it doesn't compatible
>> with the original code in HUGETLB case. Because there is a copy & paste
>> error and one line of code is missing. It is very easy to produce a bug
>> with LTP's hugemmap05 test.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   arch/mips/mm/tlbex.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>> index e80e10b..343fe0f 100644
>> --- a/arch/mips/mm/tlbex.c
>> +++ b/arch/mips/mm/tlbex.c
>> @@ -1299,6 +1299,7 @@ static void build_r4000_tlb_refill_handler(void)
>>   	}
>>   #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>>   	uasm_l_tlb_huge_update(&l, p);
>> +	UASM_i_LW(&p, K0, 0, K1);
>>   	build_huge_update_entries(&p, htlb_info.huge_pte, K1);
>>   	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
>>   				   htlb_info.restore_scratch);
>
> build_huge_tlb_write_entry only uses K0 as a temp and clobbers without using
> the value, so the K0 must be being used by the code generated by
> build_huge_update_entires, but the patch you mentioned changed the second
> argument from K0 to htlb_info.huge_pte.
>
> So should the K0 in the new UASM_i_LW call be changed to htlb_info.huge_pte
> too?
>

I don't know.  You have to dump out the generated handler (by #define 
DEBUG at the top of the file), then assemble/disassemble it.  Looking at 
the disassembly, we could make sensible statements about what is happening.


> (David Daney on Cc)
>
> Thanks
> James
>
