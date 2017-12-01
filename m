Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 21:01:26 +0100 (CET)
Received: from mail-bn3nam01on0070.outbound.protection.outlook.com ([104.47.33.70]:20086
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990754AbdLAUBRdnQxY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Dec 2017 21:01:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bPbOflf0oNMmxCINO80cu58rpJ8M7fsfE5+F9Xl/u4A=;
 b=FJwOxvMlU9jGrnX5/mgofR/SYtu4TXSse/HWXJhBsNy5aGrUSuVGuNz4LoEU65KqeuSpzKc/ai20Ib61FzVO9bPGfxyzje4uHTqh03odfB8QXgcHAzevmoY0Oy/fSbtc/QmOv8w8KRwqWka95GqX/g8Epp8h55YjPanVuVlaCUs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Fri, 1 Dec 2017 20:01:05 +0000
Subject: Re: [PATCH v4 3/8] MIPS: Octeon: Add a global resource manager.
To:     Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Carlos Munoz <cmunoz@cavium.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <james.hogan@mips.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-4-david.daney@cavium.com>
 <20171130225333.GI27409@jhogan-linux.mipstec.com>
 <CAOFm3uGhRTTrvygBd0dMdzWZQC5kFi8yXuWQsnhDvDLtW2z7aA@mail.gmail.com>
 <99dd185d-6e5d-f474-90aa-ebee63045c42@caviumnetworks.com>
 <CAOFm3uEy52yog4H_Hco0X+OHF5yiHUZYAHaGz4MefKcYQz3LUg@mail.gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <2ac5ec17-cedb-5dd8-6ea7-f065025639a9@caviumnetworks.com>
Date:   Fri, 1 Dec 2017 12:01:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAOFm3uEy52yog4H_Hco0X+OHF5yiHUZYAHaGz4MefKcYQz3LUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0029.namprd07.prod.outlook.com (10.162.96.39) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66fbe79c-7845-49a5-db67-08d538f64257
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:xTlYZGWyDaMm30vv5zcOI0bFNEwvBvg7zR8akm3fe/WKgN7SunJONvBlBpPYKYN/GPqkoF4qk9wXD+7Iks2IY67kUmbAdQ+hTgJ1ghICw+sFF7o6oAPJrDp9VtLuZJ2zkJENIKHGhK2hP1Ec10i6DDS2OTBrUzQr6BMEfnYkXhEC5TD973GBBdydWoa1hHbfkQ0lFQUt9zKg5CdEqUt/+kzsq7vdOi0ND3ZzhBZdVBSfAVW4CNmz6QOaRWxLsIto;25:ouX2UoHYBiIK779QlRI7/p8j+nxriQOROqsWKquO/C9JaPR3mFApIyBxr7TSaRtJRY81yxypGEn/yiRoC6hh8bqR5dXUlVmw0+99oTY9z9MNlXvjJSSbPjPgvtFN+n2KBwoAD14oVyOpZfH3rqeMOqDi21VmvyzixdcC9hD3D5UDZEbRkXTMng7wV7cZ2cUawnfP5n8bhq+tMiaz0DAxYk44yUydjlqBoKXMY7g5m8Wb/ntgrn8gqlONKR8rllVMnNLAinvzi8tSqR/kLIvP6HpynjvWQDXNrnyJQYwBJEr8RVvHq08xaBDN77IHdjKOF1OInHzbGRlxfOlhBzGcCg==;31:m3p0ORNDkFwGRNxif+bWKwnqIqdl0K2CoeT6mB9OckYyqq4E6VtWBIEzBv7Yly54GpYBLL+8nRXJKFhltyv49QzfDsHThYMsHMlwXXTZCHpLzk69JI1g2Wwg/fjC0jRq4PJ4ZYbRooUZtvmygE5hCMe2swtCOY3rW9C5Vd3gF0HJvs9C2q7wrk/3siOFD/HAl/AZCuHMTxoxjvXo74BfDL2Zu1sKzebUR658P5nQHqk=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:q5ZHFF0e3lKejjvpuw0eVSudKhr317Njsz9gFxhUlcjAES/5yqMsBvAgDflK3XRz1/HgGXFJJJtvu9BZOVl3AFJTGf3Wcx8QkKnZxOEkjsOt8rIW3QRyU6455WY3T2J5AetXuBI1s/Jv/pWv+eV5O9LQ7L3AhLb7kDQZus8wBNhuX4fLQJZEqPMKFUSMOsVXJGk5nuMLKAHObls9blaoVxf0uA8UfN4qOi2bBVTf3AVeBlmDIl+aBk+Jb1YWvf4NXg88L/X3U/yNRhmbGv6VRdw0BAVSX4ey+YVQWXKffFqGclNwOJTdIZFI0fJQ+J2/SU+vrP8NzX94HC3ALVfoFixv9mGU+Lny/SkiA1NmCbu5G4wlgeZ4x8zxEV5JSUesP/zzxag8SzuSu1xDvsPw14RtWdhl/I1JEum23WYF6Z6CsYp37Mrj0PjXmHOTMFL2oYxfa8UjpF03eCd7FtEbffOwcmMyz5Ekhu2WN8ZS7eiVAs69aJ+omvid0V1Kbbe+lkp7qA7IO5MzoydpN0FE8gEoKgL/SaXxaWhC2qP6hQC4iPP5rwTXRkf1mMbjFNg/ls5EKBp4Z7YMg4hcF++RJIzC4xqWgEh7yapXLTOLVzQ=;4:HkQFPVmZrVu4xXBzPhMpY2Ukzy3ZzjKToNArXqXwcQJgaJBO/33ZU/H5c8AoUJWcAxsc7qmTqGagzkX7CSVUkCHruJQ4/qbmbJc27LLWg99CUhVTCGj2ouemD0C6B0QDWpZ950BCDOA14IXSX1z4FD5hm5i7RB35LiZe12nwtDJquuTUwG9eanMTHj5LCwWEFpQpeEpGB1+xyuSR9QocpKTnIQegxJlk1b9vkg2iXGUEIQNDtLltd/uoCeO2XvbWawXQljjlHH6Iz0xftnBDHg==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3496F35EAC271CC67E8D4A0697390@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231022)(93006095)(3002001)(6041248)(20161123562025)(20161123560025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(6072148)(201708071742011);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(366004)(189002)(24454002)(199003)(53546010)(97736004)(36756003)(67846002)(31696002)(6486002)(68736007)(6506006)(25786009)(8936002)(39060400002)(33646002)(65826007)(2950100002)(42882006)(6666003)(229853002)(23676004)(72206003)(478600001)(2486003)(189998001)(83506002)(54356011)(76176011)(52146003)(52116002)(50466002)(316002)(105586002)(6512007)(101416001)(3846002)(6246003)(47776003)(6116002)(64126003)(106356001)(54906003)(110136005)(58126008)(16526018)(4326008)(5660300001)(8676002)(305945005)(81156014)(93886005)(7736002)(81166006)(230700001)(53416004)(31686004)(69596002)(53936002)(7416002)(2906002)(65806001)(65956001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDk2OzIzOmgwcXZGQm1wUjJiSm4xZjBYL3p6VU9QN05J?=
 =?utf-8?B?SmhycEErVFp6NHg2c2NORkpvQWcrU0p0Zjh3RVNhTkZwNE1udm1MUFVwN0ZT?=
 =?utf-8?B?VkNvMm1MblgxTDB4L0drVFJ6QVBMM0lLZExXQklLaUVVanBEMHI2QitWRUJT?=
 =?utf-8?B?aVdUVU5SMngzMzQvcHhoYlRNVFdJdnlIc1kwV2ZHdU1BVTBMeUptbThaQU5n?=
 =?utf-8?B?U0JmZjY3MmpCMDV2MGJ4NHBxTjdMOHIrN2JVNHRpRjNvRXBqU0JUZ0pYTmJ6?=
 =?utf-8?B?RHpLRGpBazFpYXJmNlNEblNnMENVRXBBWVB2SDlrbExhSVIzNEEzR2Q0TVFQ?=
 =?utf-8?B?UU5BMFJTNzk1RE9jL1Rra1l0TlFLOXFSbnJrN1lkWTRWOW82ajlMSTFuZVVD?=
 =?utf-8?B?Zm8veTVuMkN2eGdSMG9SVlIybWE2UkNvU2Q2bTN3ai9ocGxjSS9YV3JWb09U?=
 =?utf-8?B?L25SNVQrVFdDNGozdmlHNzJUQ0M4bGJheFVyR2FEeTlJMEV2QVVMK1JJRWd4?=
 =?utf-8?B?eTQ3ZFR3K0FvQmdUejgrbFBDVjRNZEhFL0F4ZnE3ZHp1MXlqSzdqcHNBTHEv?=
 =?utf-8?B?QUpweWhsRzVGYkpUdjhNTStGWVRsSXNGcVphczg1c1poY1lXRks1TEN0Q3lT?=
 =?utf-8?B?TzFQbDkxblpzTk9MaDZLVmxBVDZYZis2b244NkhPWkUvUU4rRzJtUE9BM25a?=
 =?utf-8?B?d29qYzJlUVAxcWt1NzhWa1BoWWRKVW9vRUF2ZVJ1TmpUWFV5ZXFLNm9wVTVp?=
 =?utf-8?B?UGpMTTRPdVFxNDN3QnpzM3dSMFI0OHAvYmgrT2V6Zis0MzBOTUJQMVErbXV2?=
 =?utf-8?B?YXc3ZzExYWhpOG1BQTA2cG91eGRPVU5hcytVWm1CM1dPQTJ4TDAyVnAwNWJa?=
 =?utf-8?B?TEE5VzJycEQ2eDRkeHE0MGNhOERLV1lINjA0NnBpUjNrUkw2VXN6ZE9yVXZ0?=
 =?utf-8?B?aGVkUWtHSjNXdDBzZU1FYThJVmtRSXlWaThmRHU1Q1pOTUdFakdQZVFpVVhE?=
 =?utf-8?B?aDJtUVFycFo0S3o0eHhUNXZ6QTFJVnpDMzJSZVVLdURyR1BHZVlNeWErbzI1?=
 =?utf-8?B?Yk1zOHpVWnd2RFBuOEF0Y3pWSGppUXdPTmV0Z1VadCtPM3BVTFZsMWM1TUxB?=
 =?utf-8?B?Q004RTZhUlIwdHh6TURITStWVVJuS3pzYUxhb2k3eHpDeitUMlJTTmpPMUxT?=
 =?utf-8?B?V1dPamxvSktmTERKelZsQWdwM2pGWDFxSE1zRnNqbklRcDFLTXFQZkJPd2tv?=
 =?utf-8?B?SGpza3d1QSsxbE01ZmVYZC9uUklwc1VYZjQreHlCRm8wZW5iNTRNcmh4ZWNT?=
 =?utf-8?B?VWx3elNmbXhLQjZFYXBucjdoRzlMRVl3TzdFRzNETllmNUFvYjZoNWJLa0xa?=
 =?utf-8?B?VVZhUUY0ODhoV3BhSnYrUFJOZGdLdkkyMXkwanJBZFEzWEJ0MEE2NUVTYTk4?=
 =?utf-8?B?V0ZEMHlsTDVPMUlpU25uaWF3Q2tKdEZWNjRzUzN0aDd3S3JKN0xXckRsNENl?=
 =?utf-8?B?N2t5azBkN0JyMEh1aGM3L2w4VmJZUERuZkxKbHNVdFVtYTNwdEUxMGhadW04?=
 =?utf-8?B?QWtQMTdxYzU0NjdVTENyRnpOOG5ONmZVa3dsQkxQUVBlay93OFBiNU16V25D?=
 =?utf-8?B?YnluYW5OcWtHTFlvQklXeUVPVk1Ub1hQWGZ6NE41c1hTQ2dUcHRwY1ZPOVZp?=
 =?utf-8?B?d2t3TTYwRDdaZTd5VXJ6bkNrRjUxR1oydW82WExzZTdyZS8reE5XZTU0T2Va?=
 =?utf-8?B?ZkJ5bEhxVWVDOXF0NDh5d2xneHFhWlpSOUFrMmRjakpjWFRhVHluTzRJbXJo?=
 =?utf-8?B?dndKM2toWTBmM3hWSlB6c29lV1RJb1JoWWVkb2N2d1hUbVBmYmRid2cvK2Zr?=
 =?utf-8?B?dDBNRXdaYkdpcllKZWFYWUJWaFVEMTlmMmJDSmJuRUNyUXNETzJ4emJ1c00w?=
 =?utf-8?B?OHYvVnNMbE9aU1N5eWVSY1ovV3FickplOFBUaXJGZjNOVUpDWDhMMlJPNjVM?=
 =?utf-8?B?TnkwREhkOUtzclJSaytOWWFUdlhzS0VHbUZ1eHZ2Sk1vVzhMSlg4cWxlMG5o?=
 =?utf-8?Q?lDMVDMS1XGvZJ8YExXcJcL5QQ?=
X-Microsoft-Antispam-Message-Info: b3xJLELhJBUTy4g9JDPI/ZyVm7m0cwmzmX12lPhTxksw3tXkpKX1G5mahXslw+pReHvCKVHLp6nHpJl2QMlGmw==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:0iaKOw6Chr46fpjgL+LcvDdJbCnwIjHKoRdStaZdA45u2Wj8yauJOh6pvkYiheoZzlbpVTjNmBz0rnMmJC14F00FZd7me+uPyeNxICYqoWUrAHMM8nQ9vOMiWOXPIkEfQD7jgZuNPMrD/damu9KtxWqb8sXpEwv9CzSaHr4g5/hQWFhyHjC86qeygCHbA+Ip7Zz6GC1GtwN8FnZv2tMBZx7tPgrWP//nK4pvberMnoKeIFZWvKw/AbOlGt+en0MmAA11fftpFtEmr6xRq8R58cCK5UnvPZcyi48eAxdS8ZDH2CRCLvDZ/22AbN19yfJkvA8FH86CFXTcqMNGQCeRTZJhTrjfL36PyFXBMhq/YK8=;5:Nq31wwzwMe9cxM0z7G0esfxV0eVGF+WHCe1u4JjO6909cYf0iZqshY8XDS8E9B+ZEMmLeelKa70dnZoVLiLlhldTajijFAbJsP3vVhMtLQvB7PpGcdbunym6zyVwWrydgEsq5mIvR1trH76UDOgerN9y5nYoT85p/h7OjtyQwVA=;24:Y7yDdw91A4q+VPiURZczzhSHIdMh7S0B7IzhaskRlwb5wwwPz6V6UirHevVRzs0a3HCyalwffolnKWMEwM6tTiNPGhCThIor2d7izedFEd4=;7:q5DSWLXLKVmf1SE9U8dgiJMoWGRikxqezOgLsqgRMwtLhlelGt6t9+uDiW1Sc5PPij7nFte07WxFebuSteDvTvgKPKnaBt4+Qp/AOh5ZUv+dmWsW6NnhyQClhn48bt9U316l3Qag/PU7UhRyM3QyT34tPyh1rIovkLk2bqzY3vFsDLBmNuNU8EaJFFHjW3jzphghK6kqqXISji/IqK/cyM9hH07CCOLSPYrTKFSREvkOGYU2p96G/ye+nKdBdois
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 20:01:05.6068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fbe79c-7845-49a5-db67-08d538f64257
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61266
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

On 12/01/2017 11:49 AM, Philippe Ombredanne wrote:
> David, Greg,
> 
> On Fri, Dec 1, 2017 at 6:42 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>> On 11/30/2017 11:53 PM, Philippe Ombredanne wrote:
> [...]
>>>>> --- /dev/null
>>>>> +++ b/arch/mips/cavium-octeon/resource-mgr.c
>>>>> @@ -0,0 +1,371 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Resource manager for Octeon.
>>>>> + *
>>>>> + * This file is subject to the terms and conditions of the GNU General
>>>>> Public
>>>>> + * License.  See the file "COPYING" in the main directory of this
>>>>> archive
>>>>> + * for more details.
>>>>> + *
>>>>> + * Copyright (C) 2017 Cavium, Inc.
>>>>> + */
>>>
>>>
>>> Since you nicely included an SPDX id, you would not need the
>>> boilerplate anymore. e.g. these can go alright?
>>
>>
>> They may not be strictly speaking necessary, but I don't think they hurt
>> anything.  Unless there is a requirement to strip out the license text, we
>> would stick with it as is.
> 
> I think the requirement is there and that would be much better for
> everyone: keeping both is redundant and does not bring any value, does
> it? Instead it kinda removes the benefits of having the SPDX id in the
> first place IMHO.
> 
> Furthermore, as there have been already ~12K+ files cleaned up and
> still over 60K files to go, it would really nice if new files could
> adopt the new style: this way we will not have to revisit and repatch
> them in the future.
> 

I am happy to follow any style Greg would suggest.  There doesn't seem 
to be much documentation about how this should be done yet.

David Daney
