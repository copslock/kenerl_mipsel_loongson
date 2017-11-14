Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 18:58:07 +0100 (CET)
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:5344
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990439AbdKNR57fuwWX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 18:57:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ljzwzRlRLdMCT6HvuMtT9SI1BA0wF/3r25MnY2LG1kw=;
 b=ZL2Cy9ZxAS3K+/cDhwbswCWHOpp81I/gj6z6RTFyO2W0E8Btvku1x0lwzkp9jA0M8u5GVmZBiFxKjAd2jv7gZaThSM8QB4QsT4lQcy+SfkW2hilbEwV5EMKzldZNcMlpOPzSwUekI5ZOJQicc4vLRD2IQssvdDNR9zh02cNrR+A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Tue, 14 Nov 2017 17:57:47 +0000
Subject: Re: [PATCH v3 01/11] MIPS: Add nudges to writes for bit unlocks.
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org, Chad Reese <kreese@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
 <1510633827-23548-2-git-send-email-steven.hill@cavium.com>
 <20171114153958.GA16044@linux-mips.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <ab17af96-e7a6-cd5d-f54d-2156406925b2@caviumnetworks.com>
Date:   Tue, 14 Nov 2017 09:57:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171114153958.GA16044@linux-mips.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0054.namprd07.prod.outlook.com (10.163.126.22)
 To DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b60ede7-be79-42e4-bb7f-08d52b89370f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:7oUWJMCHDdQn2JIoOYO0hx+acebsHZ7+/LDb+o2UB7+Smd0QtAGHDmEwwMY0XhHkrvOdeXgDzFbSP7Xiq93zvK76z6X4dsggq4D77t/hUYgjrGDTcrvU7sZ9HVnHPAT31ft/fT58waQU7zWJc6771TrJtnUjFIANCq4393XheIGOu7+jduP2gaCyjV9IVTjlpJbNTF0ADNUrW50RcQlQNzSp/mIOpNujGyZH9AGn8gyx+1VT1iTOEBP1saVCvMSb;25:4Lx4RRY9ymPDsMFU3noOAlvwmQstGK0vUJ4MOch/arqPmu253FKxGPcovijXGUsuq2vDY8qa5FtdWN5qgqctqie9pSeeggGQ1IDbVyCIl06bPJgFy4qnbfcItpAikbOOgeqfoCQRLxw96wIFBZzo7i1+42qhqLq5maZQaZFVZev8wJ543sXV6O5+FXRWAEaLKet3mWt/xdGxkGi8XcPxMaddaCC+rvl8LUyTFwKNDTCUwzL4YTsRyD1+OZR8GfitixpYHKm5nR0X8YkOTddaI31eByc8jgEt/024wSRi8h/9w13tBKqqyEErZoOTzoHMD0+UyRLk7e+kG+1CnzpHsA==;31:4VhtqU1QY2B9KyXw3wrVoR5Xf2mH9xu1dwrr7Gus+t22QcGp4o2qVrxqB8zOa6QG6aCv7KOoUg7qTvsG3VQ98bGXk+gE3thq1NeOuCD+8wn6xEbu/tmk2KQMReGMEFSnAQadii/hS7Zhza1XHsPzYuoRDf0LS0ViazC334M6d10zqzQzzNJSYAluvDVsFC942JG8U7Hnlx7Oh3vO8Y3zGPx70E7oydtPNdsQdYXXFGY=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3499:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;20:Ms4Qbg6aHm6abghlEFsaM2sjTp5rm43MrxeDBXMAINWGKbCO+ANIL4Jzr+/Fw1YQU7ubz9ALme+tpxi2GKzoXsFyO01auCFWfHySYP7PvNbFb05BdT3FwwAlQMNyIiUVp2aRiTJKMv6ICGUcXp6insuczoPh13K27vVYBVDHDOuedlzskmsNDXif7ziAq4tbCRmw6i+ancbwlgVgxnKzGE/4DiH5dX0NuRgW0wjrXhYdaWYUGOqltNvxNulQrllUuMC8dWiTMvPCjJmBY7i06sO9FXnADMk2iOOQM3xbJjdQyUOAXatLUvFu0tggInBgP8ehosEvk+fSDYKxU5vHtwGzC9lJOc1Bp3E34jgZgU788PLeGJZU8S4AF9YjF7WJAdrO61p89Lv0rnZ6S+N34bfiF80o/pPrlLEkW4oqIY4qZpgMtznJpF6ujjNzDyZyLXWGgkBnGPD0Ec6yF+lwbS0tBP4ME7w3O8rfim6MVyTG8KWLRUedFNHui3Fq/WfciSj9LnwKW9+jM2Zfy6uvhq3D0bfpBx2BRPPpSI4DBLFxteaaX4Ls/CtZzGiw1Yiu4Tj/qIGphJPrEEjUXcbLsTVSb07VlX7RDpCi2XOezsg=;4:F70k3SPkt+8dcCuPo+obNrG6KxC5E1IL0vBW24sj12621CA/eNBWgY+nWh2NtaizF+Ray6fB1MjvzAoYvYK6b2Zo8nL6gUuKB3DjVa4b57KcDtS/T7WFT5+EZO+6K7xjBcsqHi+IX+PZ4pXj7+sxsqonoEUAp5rbOQw7YmNs1iNwUUQODwLNzjavgdJBft+QQjyfIUXKdZvFhqhClEkHvhFW+D0pNCsPR13Gxf3CB5uPVnq/ZtihzXxPyyM6rDMxM0D7YumDWVlOnIu/mreHqw==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3499FB6FA14CB6EE97CC545797280@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3231022)(10201501046)(3002001)(93006095)(100000703101)(100105400095)(6041248)(20161123562025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR07MB3499;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(189002)(24454002)(6506006)(6486002)(58126008)(230700001)(110136005)(189998001)(6512007)(76176999)(229853002)(50986999)(83506002)(54356999)(50466002)(53546010)(478600001)(64126003)(105586002)(106356001)(305945005)(31696002)(53416004)(316002)(2906002)(54906003)(101416001)(25786009)(68736007)(6116002)(107886003)(33646002)(7736002)(47776003)(23676003)(69596002)(67846002)(16526018)(4326008)(2950100002)(3846002)(6246003)(42882006)(97736004)(36756003)(31686004)(72206003)(66066001)(65806001)(65956001)(81156014)(81166006)(8676002)(5660300001)(450100002)(8936002)(53936002)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk5OzIzOnR5MC8zaWpReGE4SnRldFdmY1VzaDl0bldy?=
 =?utf-8?B?R0xQN0N5dWVQeHl0MC9uK3lMM0RiNTZ5aWpqWDM0Y2pBWnFyQWRTd29xWHlM?=
 =?utf-8?B?UkUrNllqcEh3WFZJU2FxZTRxekFsU0k5Yi90b3V1c3lzOWErWFYxRzFvbWxE?=
 =?utf-8?B?ZU02NlgyK3lsOHRjb1JtQ2U4enVhOWl6alZJYTgwUmkyMDdPc0wyZFphTWZV?=
 =?utf-8?B?U3JnSGtXeUVHUUd3WnBnTXlmdnd3cVRDeEw3RUpVZ0RnbGtQeFdlUUIvUmps?=
 =?utf-8?B?NzBCWk9nZVpTelZjRW1HOFNHSFB4YjErM3d6M3MrS1o2TFVFQjNwUVFHbnZl?=
 =?utf-8?B?M3lIOXJwRWhHcDNiTExRZUdseEVUdFVScmZHR0wyTlo5YmVGZG9DMDcxWHRR?=
 =?utf-8?B?QlF2SUVqTHZrK2hHSmw2YXc1S2MySDAxbTNvaW1BVU1DWndzSzh5djI4d21m?=
 =?utf-8?B?TkpUdjcxaGFLQzZwb3FsQXZidG1rZ2xTTkZxbVQzTUh5VDdVQlN3dmpCTVRZ?=
 =?utf-8?B?Sm1RNW14UTQyYjNIVDFMN0hqbzV3QlpVa2NmSjRHK2Y1VzVKS1JCYXRwWElM?=
 =?utf-8?B?OFBWaXhhNkQ2ZDNiOE5zRDZtWmxFYUVJMzJzYnVFUG9GOTRkK1N1NUd0QUdC?=
 =?utf-8?B?dWpGbHkzVGNxUWpjV3o3MEFKckJwOWZYaFRSYWNtbmJMSzBNc3NjVmFjZmZZ?=
 =?utf-8?B?ZTZvY05jdy9hdm1XWTloYnlkT0hzSlNEZ3MrNnJlZ09nMC9ydGtqRTJ1WWtM?=
 =?utf-8?B?WFpNSE5IclVpcmREVEhwSzNZT3lXdG9rYkZxRU9uUWFwNUdXdW5XdktxaEtv?=
 =?utf-8?B?ZEp6RHlKVElrZmtsYXd3c05kaWNyRGJzUmZnRE1vVUVTekpTQksxOGlGM2g0?=
 =?utf-8?B?QXQzUXVYVXhGQXE1enpLVVlTU3BzalVEbUE0MXNTcm42UXc4aEhQQ3gwZWlY?=
 =?utf-8?B?M2p2UjFrUjlpSVgwVEJNcUpCeldOYmd3a09aT2t2WDFOQ3dBSkEwZHQvd3Nv?=
 =?utf-8?B?K0pnOW1yUnEzUFJlOURCVFIvLzdWR082ZVpZTGNFNFJWSTZQRFgxNWkxbVE1?=
 =?utf-8?B?Y3JYL0svUE9ueFYwWVdNTGV3ZHR0LzVKcExhdDZnd0xvWHVFOWRXSTJJSXEw?=
 =?utf-8?B?S0xpOTFsTmNnWHdYQ0gyeC9EeTFvS1ZXS0tOM2swZEtmSjdabGNQazNZYlRP?=
 =?utf-8?B?eHhxOC9vT3Y3Q0FEVXgySzV1TXJLWGJma2Nkd1ptRkJqbUh4dlhMNEZXK3pp?=
 =?utf-8?B?VGJ4T3JQM0RiY2o2QkhWcjkvSHVlSXNlcy9NKzd0VHJDeW9BQmJPQ1hjckFz?=
 =?utf-8?B?VFoyeC9FRmQwZWhWUGtEY1ArZFQxWDhHbFpHNGQ2NCtXZldoYTZwb3VJVUtE?=
 =?utf-8?B?MVNFeXVYK3RadEFZTTY0ZWRIMzNrL3c1WEJWb3dUWUVBM0Y2Z1NOa3FSRmVZ?=
 =?utf-8?B?UGV0SkxrcFRTVzZCZmdDY3E5UUpOdmZQbHlmMlNyRy91MTBxbDZwU2F6UERJ?=
 =?utf-8?B?RWFpRis3N09SWHYvQ1VuTnhLdG5EMEFuYWoyTmpXVlMvRnlTcXlycEErRXNF?=
 =?utf-8?B?ZEZOVUtselA2SnhNTFlYcE14ZXNPMjJ3YzBHODd5bzBxeVBJWnp6bTFFempH?=
 =?utf-8?B?TFU2VUlmVHBSRTQzZDVkeGdOYmk2NnE5bzk1MnBtc2trSUhRamtibk9RbUoy?=
 =?utf-8?B?QlZFUVM3bDBJaU9xMEkzVHJYenFzVE8xRU9IbVlOT1p3U1FqMEExVGhFSlZJ?=
 =?utf-8?B?NDlydHNSb0tPZ25EcURIVlJqUXV3M2NtQ2w2Q2dER252bFJNK1pMZ3dvMkdJ?=
 =?utf-8?B?MG5pbVdGdjlqd3BSQWhkdW40NGFoSGpNKzlDNkZFZzhIb3BHZXFRTWR5VCtI?=
 =?utf-8?B?VjgzWit1V0ZnTitsMFcwWnVYWkdCMElvU0VHRXJIUTFxdVpYZlFVNnhtOEY0?=
 =?utf-8?B?S0U2c2pYK0hnPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:Vry2obv2RHvuIFnIR7gPEWqZrlERQYeN9uY6vi3vVucERxfSU6Rte3RixUZHW+6yUqJMuYU/C0xVxD6A+RMsE/ckK61X87RHjZvT9lGjh1tS30IZYIKYpFdKtIdfp4GfX9ygeAOwFMqtBtCOGfCureI7v9H1ejkr6pomVJgZLzJcMWMJ5tHTo0VzQJyK6qo0LtFE2dxrrjZToCOk+NvuQsi7UnIwvgP/AoqV9B9Ap6ixLOnKhuiQjNSP2hezhi5Y/ID82ymQ1/GR+34Y/hg1+x3/SjUjnL+HkXTEukIGbIptHH5IZLrGhP1h8qw8Sw7p2RzBKe/eJ2t5pbK+oogkkpkBPLQ3O+2ieDANkodJw9c=;5:qgRssAtDIwzkOyUu6ZcyQOhoY39T+wvuUKDqPtSTdPm7dyLAqDoPTbInCtr5nvwHHcr0PXYa7hNUYU8IVn8aBu6Z2BGzAhSs/pUMyuu514BZKLwGrG+NGUlnWWoFPtPbZoE6mJ6vrNchyf4jicpiqRRy7ZYoZlfYhiQZKQFdKPk=;24:8F/TSVXvaMvBQ1Pwx/jJJamm+kcEbLx21eU5okQkkNt4FaWyI6dc3OVPihsCbpLpkuUXJJWeJWY7i741uWM3Ib+fXph5pLP+844xHc/d++s=;7:u3Y5I97MGacZUWalTZZZV+ZA5ovZk7sezJLERAxriBlFn57lJudvkUXtSN5AHzy/nTZGgmaURXz1Xip4MulPRVmwWSgnWqHWpgozz1Aa/QLQSUjqbkkd+Chw8+t7bAZvfejZ/gU6iRbNgL5n3uxTGjLH+alsE8uNn36MSSdtjvnHPwgZpqRPGOkYTUsULVo3aLPewdNqhzrhpBS5ZP31qlvWuwaIfQqzuvPK9BEst6CAENhjpRGApCq4Fx9P1ds/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 17:57:47.2397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b60ede7-be79-42e4-bb7f-08d52b89370f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60932
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

On 11/14/2017 07:39 AM, Ralf Baechle wrote:
> On Mon, Nov 13, 2017 at 10:30:17PM -0600, Steven J. Hill wrote:
> 
>> From: Chad Reese <kreese@caviumnetworks.com>
>>
>> Flushing the writes lets other CPUs waiting for the lock to get it
>> sooner.
>>
>> Signed-off-by: Chad Reese <kreese@caviumnetworks.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
>> ---
>>   arch/mips/include/asm/bitops.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
>> index fa57cef..da1b871 100644
>> --- a/arch/mips/include/asm/bitops.h
>> +++ b/arch/mips/include/asm/bitops.h
>> @@ -456,6 +456,7 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
>>   {
>>   	smp_mb__before_llsc();
>>   	__clear_bit(nr, addr);
>> +	nudge_writes();
>>   }
> 
> Hmm...
> 
> This patch looks ok, it's more the definition of nudge_writes() which I'm
> concerned about.  __clear_bit_unlock() does not need a memory barrier
> after __clear_bit() but for non-Octeon processors nudge_writes() expands
> into one anyway.
> 
> The good news is nudge_writes() is currently unused anyway so we can
> change the definition to something like nudge_writes do { } while (0)
> for the Octeon.  Suggested patch below.
> 
> The Octeon definition of nudge_writes() has a memory clobber and I'm
> wondering if that one is actually required or if we could make things a
> little easier on the compiler by removing it.

The nudging operation (SYNCW) in OCTEON only needs to be ordered after 
the store it is nudging out.   I am not sure if "asm volatile" is enough 
to do the ordering.


> 
>    Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>   arch/mips/include/asm/barrier.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
> index a5eb1bb199a7..0e8e6afbf80a 100644
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -216,7 +216,7 @@
>   #else
>   #define smp_mb__before_llsc() smp_llsc_mb()
>   #define __smp_mb__before_llsc() smp_llsc_mb()
> -#define nudge_writes() mb()
> +#define nudge_writes() do { } while (0)
>   #endif
>   
>   #define __smp_mb__before_atomic()	__smp_mb__before_llsc()
> 
