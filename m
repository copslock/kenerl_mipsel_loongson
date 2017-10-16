Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 18:05:44 +0200 (CEST)
Received: from mail-by2nam03on0075.outbound.protection.outlook.com ([104.47.42.75]:23290
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990510AbdJPQFg00e9C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Oct 2017 18:05:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kelamiQ3XTibplrjkrMMwLo4g95o9A7PPFufwN+phGM=;
 b=jZt0Yngf84wDWG8GdMKnaF3dZQQXa7tdShemjDJqx/z3sdj8EwUDUTjg7YfFrag8gGC5+wrI1Sxc/aqvLQv4HKok7oKu/O0rZMvGmKzSNegrR5su4W0Vbq2xNrO/eVyn8Mxs/KAeWGUm+5/9L5Xwg99w/C4aFqQh3lxNlg+zPTg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Mon, 16 Oct 2017 16:05:24 +0000
Subject: Re: [PATCH 3/4] kexec-tools: mips: Use proper page_offset for OCTEON
 CPUs.
To:     Simon Horman <horms@verge.net.au>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     kexec@lists.infradead.org, linux-mips@linux-mips.org
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-4-david.daney@cavium.com>
 <20171016065636.wxm3nrzq7lkn4lw6@verge.net.au>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <901800ab-a86a-6513-3bdd-2d2567105ac4@caviumnetworks.com>
Date:   Mon, 16 Oct 2017 09:05:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171016065636.wxm3nrzq7lkn4lw6@verge.net.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0026.namprd07.prod.outlook.com (10.168.109.12) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd3834a1-00c5-4775-fd81-08d514afb65e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:nfgV+HD+dR793rHDQNlb/ujR5m/TxVPXYP/ZPxpF60Bx73OD5pAOFC5zm4Jv5VGD325q48tKYJ8x/VhAXBUFUFZocZPVAcUvBE4CUQLd3FvuZgPCYq/6t/JYFJRj2FZvPGYGsXPhwsU/ohHMxYFrUYrAEkHwhhX+lq7j144He3KpRqR5ZPsQezbbfom457XdiI9bgHFgtLYf3FxPoWuWaLiRi3LwEY5+rWqKDdDoI3srxW5lhgeOBbE+dFQ9YxuK;25:j4s8IyFH4/dqkr8zkHgN3JgDWHn/bgjfU08aTClDg3WbcYGJKobyk8/WO4shRSYYFcpKQu7etzXJ/GAEIpubq3mDPVowikm0Y/X6fG7JHYIM7LNm1J8HzI4i9nTWnwEur4rSPRYye3encmtIvIGG3Zi/J0s/ysjJJ3DSVXoEgWgyuFvybT9jDQUrd1uVhtYNioP4Ej74BgD4uNUmGH/IXMINOaFwhZSu3eg2P/ImdCFDf0I3atPzYCyY9xV2UDM5eKrNOJ2Ty2Sd+W7vnGmegdUBjeHZC1rcBFPy+jpjrVjgdk6LE+6VW0QIbhxIx7qLX0DAVV8szd8JZ1oqkm5CDw==;31:9bPBcgVhWYbbNRn/C6B5KD3Vd/pwDWDWgO5dxbOkr2ooVfnnzhRsgWcfF3B0CDzjycV6wmHi7ft4NUpsE7OiuVfCpwLzhFRzUt+p37KgjcKd7SeMtT7Ui0CU9uuiAPSQPt0NCcTw3xbKgSGS+H5H3JO6D48xUKwg7258u7VsTByeTIEcKnLZWriXJb5rP2SYDaffXoO8naRp22P82o8s7fG9TbM9VwoxHKby6c7LeAI=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:snfliYnQwdjBKQn9MS4ocoiynS1qtWGT4a5WYPUe81/7bDAAG7A8pvy1BxDAiV4t/J7YxsR8EQ3HX9YvrYFN1LvP3+u/M7zHS59V8KYYk/u/++dCSlXtdbpc/739QMKB+yzz7VNE0s1nDVSpHN9SuaG370pNfhKTxtH3pT0DlqWHmP0iv3lfRxlCUhdT7DCPOed8WwtLFKPD99Kejg3m8j4vz6kZQ/UxLgQEtL7Do1wVc/OUKibg+mAjRjPFoB3Pq4CzEmfD1T5+mzwyoTyFtbjs2u+/dskbXyc3lvG4ZNGXNS1QIrTG5ORBEBZcAXt4ZwKMOATJh1XXN7jVmZuPXktQ+7uqU9Ite23bFsvSTfBpjwQRvHzenee7IfzovHwjcDREZ31TB4ERauVXCngpgVHNIFpZT/CjDwYfIvvsi5wstUyBPK5loFkz106qgc5jnxtZ/KHbkhmfJKD83BrQ79utXBojFgb9KFUFHT5hWHYLzqLB7jeJPLqRN38yVFpA4JlEBf94Ho3r942M/h4KD5g1MPRYLJUHw92tLy3YQH3QPtsFLQxGn/RKX0NXpPPcsvMaLdNvFoXyXG/biLQ6Zz46clYSUnHnsDhC89BlLRM=;4:k+l8BCzQj4/kSwSOXqfM+oKgGwGQ+WlQDT2jDpLnc/T/wN0fiBgU6Ak5RsWMsfdEL8GZyMyh+0vCQfq0d0txnkvRhRpdQdwEyyIUfKx9WCenrKNOdRUEQS7cDnwFCCERYUbGYE2Keq70FLbw0LGbgxcKHtSdSLXMT0Ic0fpzyYXA7b5DcHcFebDrJS+QfrQm1eb/blMIHH6cgTDyrijVIM7/7HSnjW1dW1ZdcPfgo1v9muj6ZHVRKjzaOo6DGIdU
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3495DD5FA7A461C3AC2D12AE974F0@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(20161123560025)(20161123562025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 0462918D61
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(377454003)(24454002)(189002)(199003)(23676002)(3846002)(53936002)(31686004)(50466002)(230700001)(65956001)(65806001)(478600001)(229853002)(66066001)(65826007)(6512007)(6246003)(42882006)(4326008)(36756003)(6486002)(25786009)(76176999)(54356999)(64126003)(5660300001)(50986999)(101416001)(68736007)(83506001)(58126008)(110136005)(189998001)(6116002)(6506006)(72206003)(33646002)(2906002)(69596002)(47776003)(106356001)(8936002)(97736004)(105586002)(53416004)(8676002)(81156014)(316002)(81166006)(305945005)(7736002)(31696002)(16526018)(2950100002)(53546010);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDk1OzIzOnVxeGhHSHl5ZXJHb0FhazI0aStiZXQrTnAw?=
 =?utf-8?B?WU16aElsVlFHblE5dzBVemRjQkwrcGFiL0tBcHJDVG9wNmFkTEs4bDVNYjFX?=
 =?utf-8?B?SHJjaG1jbENJM1Ftb0JZMXZpMDM1UGFwNmlYMmdUbTlTck8yZWRDKzNMaFAx?=
 =?utf-8?B?VlU5eFo1ekk3d2ZPVGU2ZytIeXRMcHJBeVBkYTBuSnZ6SVdxY08wM2QwVmx1?=
 =?utf-8?B?Mk96R3c1MnNrZzhUUnhkZ2VGYnV4VGh3WVVlSDkwZlB0NHhHWWRCaStNd3Zm?=
 =?utf-8?B?OXpac0dOcmQvS3VKRDlGQ2Uxcko3cWk1d0c4VmpSRnR6QlhBazErQUZUNmNq?=
 =?utf-8?B?V3V2MTc1WjFYQWJtYmZhUi85ZFFDUlZmM3kwaUp6dStXbTJuN1RoYjZTN3Vo?=
 =?utf-8?B?bnM3aEx5Y1A1Vlgzd0piSEhUNjVmc0N5Q2Y3WFBoL3JYalRhVmh0d01KdU9U?=
 =?utf-8?B?YVR1WnQwZGZsc0wzUlhnWXhUb2hCK0RudGprQUpET0wrdlk2MzZ2UGJzcjZX?=
 =?utf-8?B?MlRFK2FMZUt3T1RrS1JnYjIxdmw4Q2NJdmdGSUtkSlJvYlNBRm9pMjdMN2Zh?=
 =?utf-8?B?YmZ1cDZvQzh0U05nc01nNUNvbWxZTGwrQ1NyVGJUdm5DbHhCeVRsemhzYkZJ?=
 =?utf-8?B?eEpldEUrRzVwVmp1bVlFYTZZZ3lsUGhTTFRGekl3NWlna0t6WjlOaktKUnpX?=
 =?utf-8?B?akdKYmJFaGhBaks4TXBRWXFtZ3lMQmZudGVrNjcyRERxSkVRRTRHVjU5ajFG?=
 =?utf-8?B?V2V3V1pqbUFhRWxiQnJpVEh6MGlsNVAySktEa1JYWmVORkNxZVgzbGJzSHFi?=
 =?utf-8?B?Z1I1TWl5YXNpcGZydFpXRjFIbDAwUjBmU01tMmZPRC9NNlNIdVJmZm51bWRj?=
 =?utf-8?B?ajkxR2NCV0ZHNjUvMW5HeVNVM0J4U25wdGoyZ3duUGQ2N29qRFlWMWV1QVlm?=
 =?utf-8?B?WURFN2xSc1dvODNoa1pZd211c1YwOWFtMXN5WnRxOWk1c3hHOHA4Nnh5VFhI?=
 =?utf-8?B?ckZWMk1YOHpQYThGODhwVUZpY2RHWlRXaENFeVdRbHlQaVpZSit3RUpWK2Qz?=
 =?utf-8?B?YmNrbEZtUFNrS09QNFVQODNReFVPSGJOUnZCUmRtd2Jkd1FoeUtJcFdKRmVW?=
 =?utf-8?B?VFY2N3kyVkN4NlNMQnpmK29MS2ZlNmlOZmxNcHg5cjBkL0tCaTRTUDl6eEZD?=
 =?utf-8?B?TnprdlhZYmtQTWxwNFVESU4rSlUrd0dVVEtORTRSYmRJR215ZmhHdUdkT1d2?=
 =?utf-8?B?TWJmYUNwK0FCSnJOWE9KM2lNTmFyZWVyTGptOGZpMWdvVU5pcnVKcUJGenN0?=
 =?utf-8?B?MEEzcmRPYnY1QllnWHJ1dE1TY09XL3hoQzFKcXM2ZExvbGhJeVlXS1ZSL2F4?=
 =?utf-8?B?TG85VE0xSWF2ajhrQU1Vb3pkWWtsbnRTRGY4Z1o2WFoxdUtCSlNwa25mdXVn?=
 =?utf-8?B?dVpnallpTndKcjJPS2NNTlZPeG1pd200Y2JBYzdyWERFYXd3cW5DMGRFNFVa?=
 =?utf-8?B?ZmIwVmJlS3l1TEkzQUMvTE5EdVdVeUl2aDlPbGhnUlFBdTJ4VkxxY0ROazhy?=
 =?utf-8?B?MjFqeWdjd3VUdEl6Vjh1NzNZai9pY2pLbnpQOE14amZaeFZBTG5YUmZmTUNC?=
 =?utf-8?B?Nkl1T0pvajExdDEvVWpkc0tBU0hqTlJrbWw3NnovdmR3bUgwZTIrNytQRi9i?=
 =?utf-8?B?bzY0L2xCTlZoMjVVWVZVNDRvY1VRWEJlY09VbU5qeC9oWVNZSEdBak9rci93?=
 =?utf-8?B?Y3NOR3BrbTlYR0hpTklQajNwOHFWVmlKU1pnZldXdUFhVXlFOTJJcEhILzdt?=
 =?utf-8?B?ejc5UXBOa0ZXRER1SnMrOThPSll3bXFXR2Z1V01GTHdPU0E9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:3A4zleKZRmzcPXg4KGskBKgiRfzGQp/t05EomZbN3Hh15QTyYy8Kvwz+jbrhM4a90tQks9R69c+v7kHcktehY4VP4OM0QE9OYZIVxkDLLfZnrKEiMvXHqxxbZ23mKFuoB4TZVypjkYyaYnn56KuTXqQ0Dn8g0QU9P5tYr/kjf21F0abOGUraXS+JArfA6b1D2LnZcICoRFaGRghZGj7K/TytDp7KOHX+NZtFsQf4p63YurcXv/DlM0M2iFoP/IgLXxaTRKtwEhI7p7ctyXV8qB7YW0zsDVy3ioKSfqROlvK15OalHvvWe/n9dPMFVjbP47KIR7n2Cfl4PVLA+/PFXw==;5:GdDGRN5dJXNs+/92F8FgHFf9XkqswFSqzlEteZbXk38U1ECEOpvC+YO22/PdAv0sG7qF+Vq7CNHdsOapT6cvB4mW2CqWWN37CK7wU6CLoakPC1NF0S5/Md51cAcgb0f4HSH5qukII+p4f0v383SGnw==;24:d2kYwYbcWMkabduBpO17EQit30zVSOVDFQ6XDwp6VW1s7/n2LKlos+bcI03ZuwvVHCS8XUtsf15IVM4GDuiDpl+dkx00Gv1lW5mGGfkmmLw=;7:xf2E+iTnDZdX/RUpZX8IiSn+J1Pxg0OfP7dPie8ZPoz56/j4O7hDTbkZTolMeEwz/L4R4LFn40IiZgpp4MqsvyGxRNNERCwyEbhOsk8GfkbqU03jfopGKnnUH9WkMZ6QbzsB6Dv0rvv6rRK5iMkY6IU5Rm6RG6U56D+fJpcVq4kwirZti7b7M/7igKrcDsWuipG9xnBm21pY7UzZ4MpUhJ9w/YYN0MXBMnRvo5oRVtA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2017 16:05:24.7585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60409
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

On 10/15/2017 11:56 PM, Simon Horman wrote:
> On Thu, Oct 12, 2017 at 02:02:27PM -0700, David Daney wrote:
>> The OCTEON family of MIPS64 CPUs uses a PAGE_OFFSET of
>> 0x8000000000000000ULL, which is differs from other CPUs.
>>
>> Scan /proc/cpuinfo to see if the current system is "Octeon", if so,
>> patch the page_offset so that usable kdump core files are produced.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
> 
> Is it possible to read this offset from the system rather than
> checking for an Octeon CPU? It seems that such an approach, if possible,
> would be somewhat more general.
> 

Before implementing this scanning of /proc/cpuinfo, I thought long and 
hard about this, and couldn't think of how the PAGE_OFFSET could be 
derived from information available in userspace.

Ralf (MIPS maintainer) may have an idea, but these address bits don't 
show up in /proc/kallsyms or any other file in /proc or /sys that I am 
aware of.

David
