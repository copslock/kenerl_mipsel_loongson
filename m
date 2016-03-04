Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 18:44:09 +0100 (CET)
Received: from mail-by2on0081.outbound.protection.outlook.com ([207.46.100.81]:57519
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013082AbcCDRoIHV49K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Mar 2016 18:44:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-caviumnetworks-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZA6GzjifPhS91AJPbpmoHrJVhCioiiiDfZg2ByHJQpg=;
 b=M50RBxsIsHTVdkq4iR/yunG5ykm83g86adW8+WgQPW0Xluv1PFEo1Z7sBN/KE4CJ9Q0n6ne7u6FeivzHQRha97+tH8NhR2pTN1HCUtaNSy3lo2WOmZQugrDp3VpNws8jTga3jgClhu9S+Hkp4XnO6pVrkFbTfvOW7bcVKnNaQJw=
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11) with Microsoft SMTP
 Server (TLS) id 15.1.427.16; Fri, 4 Mar 2016 17:43:57 +0000
Message-ID: <56D9C95A.5020106@caviumnetworks.com>
Date:   Fri, 4 Mar 2016 09:43:54 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>, Lars
 Persson <lars.persson@axis.com>, "stable # v4 . 1+" <stable@vger.kernel.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>, David Daney
        <david.daney@cavium.com>, Huacai Chen <chenhc@lemote.com>, Aneesh Kumar K.V
        <aneesh.kumar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Jerome Marchand <jmarchan@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 4/4] MIPS: Sync icache & dcache in set_pte_at
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com> <1456799879-14711-5-git-send-email-paul.burton@imgtec.com> <56D5CDB3.80407@caviumnetworks.com> <20160301171940.GA26791@NP-P-BURTON>
In-Reply-To: <20160301171940.GA26791@NP-P-BURTON>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR0701CA0016.namprd07.prod.outlook.com (25.162.96.26) To
 BN4PR07MB2129.namprd07.prod.outlook.com (25.164.63.11)
X-MS-Office365-Filtering-Correlation-Id: 662a58ce-497c-4ae1-e0bd-08d344549150
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;2:ExhCXsGJiKnhtBPbQxwTzlCtmvRgUgCvbuqUSVDvw++9b0jNHetKzz9vrxng67ZlRBKn78/77DpvggNNQHq9k5PBAoKrhgShDcW7pg6bBF4+3L5WL/9y46dohQKM+Cqh5QJVCZ4vlc4kDXXoZZgRDTlN23MKY64T7DhADK16Oi4ncn8UMA2KJTyAhkWe6me+;3:dgc5kQTbDPSDj7NmB2jYjfj0x55qFkl7OmX9NNgZrEHxP/6i9OFkPxhwwqZwM5oBwxioUZEcBHpMnVP9n96rUEd9Ff2uk7buqjknB7n/Qt95kof3t4BjlUj2kpfPPK7V;25:WiKkvIjh94lNCcRkS6xQNg3OvC9dfvyXX02Hg5vAI/Kbow5q0AZxPMJycEZ9fmlvNAla2bJa6UZ+ZlRzgVXcWdv0/L80TAdFbMTsc/zxKnQeHa7utsdNOwQWX4RQF4AyTe21U6WVTvou/k5Fcw+QQ+MSrdm07Yz6DaL5ObfbgVn97+5wD+EtLNiJaXGZZdF78sZQzA6DEq0n788M+EdEHHU6CA+QDFopkUfN9Mq5xgjrYKGRVtzdJofJ2u6rD3oIFLF/Q8PCj8mzB3B5yXzYXQYtkd4lp5hvVpx4X+1xelHOkAgfXfz9xBmetyvP4cAd4EfCsVq4nwelYndZpgeg9A==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;20:3JLAh2Cm7yfG+GQNI1b024jQLZMRsYOszve832MAVyoLQH5wj/5NrigN/pJpF+mN61MuMoEXpwT5RobOhA0oH0zrePI8yoi0qhOAdvysc0n1Y4zPWeeG/fU3eiMXAjshtcEEaPSiw74b7QvNiZIJ1M69C1DLdrUx4ach6CfyHlbvupzfbIKB6LuR0iPine5NJb3ZK/Ruac3zXxsmDitd6yUAmh9B09tZklUc3l8fomtD81enNB6vY3XsR75LP0hOOBWTiN0Io6fDJsUnGl0A5CpYoxnEW6lcwTqG3Nc5XyT6DLOlPOmop5UTTS1TAKRH7TAti+7XuJ78AOm1b6qHxJLD/d7wSFlX+IQGDIdSqqyG3Rmuz+pNqZmEN5RrMTh8CVI93cGK6YvzfO3N/QGScMpu+Lf6ismojuoPpFJWGXCkYXxHNCvWm1ztD0aOiyG2t26ZJmbGZ6TNVoUCy/zxSlr4hvnhcXCcYEo3MFlBYMvanTrCGAboKsctCcOnOvkfs+BfyVrDzlAuNo5I7W9rvpdy6izfVOZ3NngHO0BIcZ4VFcXbOdUI3ZU6GqcUg0Z8M7qrikSg9sEUxx0jRwLn6j4V35yk3JCnWBM1oD3SRCs=
X-Microsoft-Antispam-PRVS: <BN4PR07MB2129BC0FBD9B327BDB4D58259ABE0@BN4PR07MB2129.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:BN4PR07MB2129;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;4:XMa+CJ+ObEUnGfgZs2IoNTFXpGftSuIGbetCOSpquPbeArNM+wqsaXnhQgDgutPlLz6YtxFF2qliPuD9dHP9ONlUesmloIgttZ7GS/BcTAHmQ2eEl8VXZau1j8JT1jb453VRXiuHrXg0pKKVQdssskKNDsKXolzlgfj3oeV07SBsHeoShXc+vmjSXrucvCwARCCo0Mls7VHHr6S9HTVDWOVdSMNmckCSD2/+QCnR5RwPVrrlOdAMfrefxolmAC+sayY6UvdesJtfZRXZ6YClB/wl4WZSoRJsNl9YRxzG2EpTC3lAzScG12m5KZT58Nf4OwMNzxQzbDDsnjFkA21O6/p0Y5Rz4IboCr0S0Ma9C+M=
X-Forefront-PRVS: 0871917CDA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(24454002)(479174004)(377454003)(64126003)(2906002)(92566002)(50986999)(76176999)(87266999)(54356999)(77096005)(40100003)(66066001)(2950100001)(122386002)(230700001)(53416004)(81166005)(6116002)(47776003)(42186005)(1096002)(586003)(3846002)(110136002)(80316001)(83506001)(5004730100002)(5008740100001)(36756003)(189998001)(4326007)(65816999)(59896002)(4001350100001)(33656002)(87976001)(93886004)(50466002)(23676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2129;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjRQUjA3TUIyMTI5OzIzOnZHWCtFbnVzaEdwZ2hFYlFaMXZ4eE5PMXJQ?=
 =?utf-8?B?RFJySE53N3cyS3RyWTNiZVEvSnFJN1huaVROR0srWHhZVTNKbml6UVFsczdJ?=
 =?utf-8?B?S1R2bndvQVVod3UrTGhiRWNLQ1hxOVpMQWpHWXB0S1hZR1E3bDB6bTRCUWZr?=
 =?utf-8?B?ZHgxTWh0ZkJ6ejIvdlFoeWY2b2hsRmM1UW5CSlh6cU52OUtabXJTM1c2b1hI?=
 =?utf-8?B?T0EwbHp1a2twTWdkZVoxeG5VZnBnY1RxSmNXamMxZ0t4bHovZCt5QzhoWlg1?=
 =?utf-8?B?UE5HYnYwY055ZldxbUQ3b2l6VHQyeVdkYXNFeXdCSXkrdVorblR5YWtWbzFm?=
 =?utf-8?B?L3RoNE15TVBzaHFUbHpGWmRKWDN4MVNBMHZCaGdRUUdSRU1Icy9JcmFFdTVP?=
 =?utf-8?B?b09YMWRYdnNLQVhZLzNWOGJJeE1FbkdiZnRYeU4wZ1hVUTg5NVQrTEtYRjRE?=
 =?utf-8?B?bm5ENy9TeFphVHBaYmhZSC9ISmdZUEhvYkhxOUh2WTloYk9jV3FGRU9UKy9j?=
 =?utf-8?B?SGkvRmNSYlRIMjkvZmVxM1paY0N2RzJGaGoxZFF0QklmaUpPUjhkY0tRNDF1?=
 =?utf-8?B?aGtOVGxOWkZWbExtMUVrL3k4elZRV2NwdUpZb2czL2pkdWNNTmJYb2hEdVhW?=
 =?utf-8?B?RDc4VmtySDkwWFMycGRpOXQzTitZd3hlOE1Mby9idFEwZkJ3RmlJZFdUeUVY?=
 =?utf-8?B?MzZQNGxrUVdjVEZEOG5ITVlWSDVpM2JqL0RrbE9WaTNKRzA3ZE1lUjhxcUll?=
 =?utf-8?B?dGU3cUxDNjc0WjBXQ0MyNW0xME1BTXFzU253SGtzRGhTUHE3aXExV1BNS01U?=
 =?utf-8?B?bzM5MklFYkx2azJnNWlGRlZidUxYc29mb0NkaHdwcDJjQkhQdkJIZWdzakZD?=
 =?utf-8?B?ZjVlMmo3cmpxZHFITGRiOFZSNEtQS1MzNkxWRzB6bVkwSVFlT0I3M2x2R085?=
 =?utf-8?B?dlVFV2dyRXpGNTZ6MW5GQmtQVFp0czZVSDNaWk8xVG9aQTBNbUhnODF5T1Qw?=
 =?utf-8?B?RDlxWU9EQTR1TitwTFl0ZVQ5eXVIU0xpZ3U1U3l0aGdlMG5xdCtPWHJ2U2Ro?=
 =?utf-8?B?UFlRT01pVVRzNVdjZm1hWHJIMFRXVWk2V2Q1N1NFY1krOFEzcmJIM0FSV0N4?=
 =?utf-8?B?bTVpekJ3RVVPRDFYaTFyQjlsTktQYlV3T1JOVy9jR29Ja2NVMC8wTGF5Qysw?=
 =?utf-8?B?cEs0a2NPNFZmMkQzbTJjdTEwZWk1MFhZNVJlcFM1K20wS2xMdit6NVlqY1Jo?=
 =?utf-8?B?QnZrOFNjZTVkMzdvRU9MMWhVUU9VSHI3TWx3c3ZkbDlSL2pURUExQm92OVh6?=
 =?utf-8?B?MiswenQrZWE4Ym5zTlpNWGtQVDB0WFlQc0JlNmVVeWtwbjVpQlZPa1FtdFZj?=
 =?utf-8?B?ZisrOXFWYzhyaW1EdlJjTStuWGx4a1JEZ3pUTjdVUGhreGdVN3M5THZZSDZu?=
 =?utf-8?B?ZmtCc0JOMXBtMmgvS05JczVxYTNHTkhUcFRKcE9wdGROMCtsTEhJeHR0U3FR?=
 =?utf-8?B?K1cydz09?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;5:HjBtcLekVOCrLc1pX2h+NYErxsCIdYMdbFzMnBiNwyFC/kKHr6PVDuL8xFHhKePWf5BUCv1PQR2+kLCkCM1AsJh4izVX0gTUkamYzkGlFYJgqx8Ev1OM3K1+aDb6qumaVjBASTe9+kKYs5rox/gbTQ==;24:XqS7NEmSP1+ab/UHccLzM0M+qLCeFHFs9N306tb2N1eXqtRvfpZM7ZrApD+pQ8S+pyr8r5dsM8h1S8VN0F3omgsnZuP563cXX4MYnNgolXc=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2016 17:43:57.1246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2129
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52451
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

On 03/01/2016 09:19 AM, Paul Burton wrote:
> On Tue, Mar 01, 2016 at 09:13:23AM -0800, David Daney wrote:
>> On 02/29/2016 06:37 PM, Paul Burton wrote:
>> [...]
>>> @@ -234,6 +237,22 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
>>>   }
>>>   #endif
>>>
>>> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>>> +			      pte_t *ptep, pte_t pteval)
>>> +{
>>> +	extern void __update_cache(unsigned long address, pte_t pte);
>>> +
>>> +	if (!pte_present(pteval))
>>> +		goto cache_sync_done;
>>> +
>>> +	if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
>>> +		goto cache_sync_done;
>>> +
>>> +	__update_cache(addr, pteval);
>>> +cache_sync_done:
>>> +	set_pte(ptep, pteval);
>>> +}
>>> +
>>
>> This seems crazy.
>
> Perhaps, but also correct...
>
>> I don't think any other architecture does this type of work in set_pte_at().
>
> Yes they do. As mentioned in the commit message see arm, ia64 or powerpc
> for architectures that all do the same sort of thing in set_pte_at.
>
>> Can you look into finding a better way?
>
> Not that I can see.
>
>> What if you ...
>>
>>
>>>   /*
>>>    * (pmds are folded into puds so this doesn't get actually called,
>>>    * but the define is needed for a generic inline function.)
>>> @@ -430,15 +449,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>>
>>>   extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
>>>   	pte_t pte);
>>> -extern void __update_cache(struct vm_area_struct *vma, unsigned long address,
>>> -	pte_t pte);
>>>
>>>   static inline void update_mmu_cache(struct vm_area_struct *vma,
>>>   	unsigned long address, pte_t *ptep)
>>>   {
>>>   	pte_t pte = *ptep;
>>>   	__update_tlb(vma, address, pte);
>>> -	__update_cache(vma, address, pte);
>>
>> ... Reversed the order of these two operations?
>
> It would make no difference. The window for the race exists between
> flush_dcache_page & set_pte_at. update_mmu_cache isn't called until
> later than set_pte_at, so cannot possibly avoid the race. The commit
> message walks through where the race exists - I don't think you've read
> it.


I think the code that calls set_pte_at() should be fixed.

If cache maintenance is needed before modifying the page tables, that is 
explicitly done in the calling code.

In migrate.c (remove_migration_pte, similar in do_swap_page) we have:
    .
    .
    .
	flush_dcache_page(new);
	set_pte_at(mm, addr, ptep, pte);
    .
    .
    .

Similar in huge_memory.c (unfreeze_page_vma, freeze_page_vma, etc.)

The point being, the callers have the knowledge about what is changing 
and should make sure they do the right thing to keep the caches 
consistent.  The job of set_pte_at() is to manipulate the page tables, 
nothing else.
