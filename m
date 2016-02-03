Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 18:57:17 +0100 (CET)
Received: from mail-bl2on0055.outbound.protection.outlook.com ([65.55.169.55]:47232
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011683AbcBCR5PCBJTz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2016 18:57:15 +0100
Authentication-Results: cogentembedded.com; dkim=none (message not signed)
 header.d=none;cogentembedded.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 SN1PR07MB2144.namprd07.prod.outlook.com (10.164.47.14) with Microsoft SMTP
 Server (TLS) id 15.1.396.15; Wed, 3 Feb 2016 17:57:07 +0000
Message-ID: <56B23F70.80308@caviumnetworks.com>
Date:   Wed, 3 Feb 2016 09:57:04 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <david.daney@cavium.com>, <janne.huttunen@nokia.com>,
        <aaro.koskinen@nokia.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Octeon: Add Octeon III CN7XXX interface detection
References: <1454412318-27213-1-git-send-email-Zubair.Kakakhel@imgtec.com> <56B09528.1030902@cogentembedded.com> <56B23CB2.5090805@imgtec.com> <56B23E44.7080304@cogentembedded.com>
In-Reply-To: <56B23E44.7080304@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR0701CA0058.namprd07.prod.outlook.com (25.163.126.26)
 To SN1PR07MB2144.namprd07.prod.outlook.com (25.164.47.14)
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;2:l3JlmAYotVKTnCvQgKvUEsgWBx/rW+Lq9NY3Y6tSHjoKkpq/UF5Se6cEwge6ZKJ1UCt9DntO3GIo3jH7cznFt4L7GLM5dc6B6UGy+9zMGjQ8Ct98u49WgU2EDELyY0GB6rR/L5ZHLFJbH7x3NC7WIw==;3:4Z3v9ZNV3OqYEw6QqcSL7mL0avNp5HKlmriKLhuyX5otXvOxFVEZyfIKuTnXVpnLHrkN/k+HiQFPFnvcvBLZRRcBVhWaKusjHz2y/A5NeCCvsCOtHq8r1zMvE6+c4TVg;25:1ifkelboh4mGapzrCv+ts5Mqn7nzWv9g4oU84aaZhaBfEfPFQmyD2XkwULx3+45sAorngjdIfgX1GL9g4oHe9zY0/kjYvJDYEI0YFs/0uUaYgTci5J5QOuBAhn/UPeLvNoYAgHasil8svsaOcTjWgdUVKuhxeghC+CxUKmywdqSWhDSV9gDu7Ese4yaxtFBLObPPL+JidqyZrFQX5WdH24hzMZxg4odBikF5OPuU3EdDPU26agO6OT6OWv7ysfro
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-MS-Office365-Filtering-Correlation-Id: 64469e17-1fd8-4d2e-f0a6-08d32cc36ef4
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;20:eP9SVGg45jMjc0Lon7DwCw9aRHNq6Zz/R6V3nDMv8gpfHPl7n1PP3w/x0kvf2rnhBh4CugNhqlVC48OoVnuocRO8fbl/riWozOlgT55eZebiPLjyEQWpUzmbfuGG87KQpyhJTcCEAA45jKY4qo6qIkm7ZWwecxE79S9GCAgvifMRmTxCgPECJIulEbVAMmQEUUX2Zqd4GukHU/BSNwk7khvqzpfBY6vcZX/GXJxzqWymOM36gLfjDTGxWoXb9dOol8hHAvKG/0bLryTUzQg7RYAAZ8jisYloT6iKnSMnlt19PnZU6Q8Z9cRLFGaVZmgyblmGNS7dLEM+iT2XSj1Z6mOAJd2xFty+7Sxa3jAfVZb0psl9Pt0X4loUmnA29T2gkXgB5gQAYWa7zidCnaXNQMY7eF1SEXBLEyGtyFCNOoX5SOZp62Sr4sT7RW5XwbTRbiTx3ADILMLc9w9CD2wCIR7B/s+qWSy7AxNV9wuxHejzbI1b2Jdy9JPJfHVSDGDCCehgZiiuHBRzPDzc76BfT8zxzQtZe/rPNoKlFOsKCc1sHlOLB0tAQviF5woRyU60/0xhhdDFoEHNXwoMw1JO9260Ithlw2vLSi+aVGsaAtk=
X-Microsoft-Antispam-PRVS: <SN1PR07MB2144122EB843D4C5C48D7DD29AD00@SN1PR07MB2144.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:SN1PR07MB2144;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;4:c+qDkvjI8LrmADldao65lGv+cJ6jNJ/JwZDDsCbANRRXGt+L7ADoJawjIO+2HaII8oREVtO3RD0y1FmSrLVP+NAWcca1atw6qbkkqhToP01/tnH4H+cLTpqjjaJ9+DB95qnM6u6PLyYAnnO6fEF7zw9G2velJLxIj70l775GfDRndHUybZASYfA0YhckBA7UmUxjYWfYC3YTOgIsoP+SKjB94T+jCF/A9UIbTGxL/LYGCIs6vziLs1OtIssM6CEJcy88ZgT7Z2znIXYzDL1uDHqUlBNeCSjVfcplN7U1vLWRs12NIaNfEYBKpYdVApV8YNIe8iCCXGgL9ies8w7WhP+YT517df7bGKi5A0jxtDvAhZNYj+EKOpZnB58kifyP
X-Forefront-PRVS: 08417837C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(377454003)(479174004)(6116002)(3846002)(189998001)(110136002)(5001960100002)(5008740100001)(1096002)(92566002)(4001350100001)(53416004)(93886004)(23676002)(122386002)(19580405001)(65956001)(66066001)(19580395003)(65806001)(5004730100002)(50986999)(40100003)(87976001)(2950100001)(50466002)(4326007)(36756003)(64126003)(65816999)(76176999)(586003)(2870700001)(77096005)(33656002)(42186005)(54356999)(83506001)(2906002)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2144;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjA3TUIyMTQ0OzIzOnNBeXFQVElra2hoSW9Ib3FPcmVhRzlNUm9o?=
 =?utf-8?B?WFI3c09KNVkxdHZwR08zNDVUYnZlNHM5MWUyMExTMk50aDQ3WWdtYnpmSVRX?=
 =?utf-8?B?SUlsUThhTkpvTkFOU2xWcVVZT2QvaXBGdzBXRnhJUE9vcWdVY1BZOVo0UXpF?=
 =?utf-8?B?UW8xalJhNGdqTEFiTEtjYVNTOFJ2OEFqU2N0a0lMdHlIdHV4ZTl6dlhBb3NN?=
 =?utf-8?B?bzViSFRJVVVJeXV5WUllZTRIUC9mLytBNFFpN3VlOUhoMk1teDVYNGJuUjht?=
 =?utf-8?B?aHR4dXptTjhUWDBadW02NzludEo0UzNTNWIvMU11Z2NMc0pUV1NFSDRXNnJu?=
 =?utf-8?B?UStGakxFdzhQU1hRSWRvbVJBbXUrS3VLNURpMHk4VzNyWjhGZ2FpWWxhZlhV?=
 =?utf-8?B?OCt2Y3ZyU0FVSGdwbWMyN0tZSHhpSFFab2Q0bUxmVEJ3UFBkN0ZyQkFSaHhD?=
 =?utf-8?B?RVYxT2ovYURkSmkyMWtYZGt1MHR0Rnhpd3l2YWc3ci93THR3VDB0eWgza24r?=
 =?utf-8?B?WkN1ZDdBL2RHb3MyZ2R3QmRtUXlMam5ycmJNS21iUEdlYmxrYjhiWHFqdml6?=
 =?utf-8?B?L0dXSkY0bEcveForMEI4WkhPb3NvM1ZENE1wVjdHYkZqcGtNU2Z4V2dsa01i?=
 =?utf-8?B?YVRnV2JtYWsxM0c5eWdxQ3J4Yzl6K2FNU3g1KzBhbWJRR2V1UWRlZHBPaVNn?=
 =?utf-8?B?Mjl3VURIVGlQY1JVZFUvbEJIYnVPSFl4TnZrbXloWnMvZjd5VThNOVpDUTdq?=
 =?utf-8?B?RmhMa3pFRHU3Z0VVd2psL2d2UG9IckN3WGtUV284THBPWE1sVWtaaVpaQ2t3?=
 =?utf-8?B?SWF4S041NXlNMkFvKzNGZWJ1YUVkMEduaTJWd2Q4MDcydnl4V2JES2cyOVU5?=
 =?utf-8?B?b2YySkVBWWhUVzg3TUptcEpCZUpISDF2SEhpckdwZHZWN2wxb085RmNOam9K?=
 =?utf-8?B?Nm96Y0sxRGZ3Mjk2TW9zL0M3Y2oyOEQ0WlBMZHNVWitzTVJvSWlKOEdxalhy?=
 =?utf-8?B?YVVpTnNpbFNzT2hNVE0zaEJiMWdwSHNwbURvK2g2RjljKy8zQWpYTXRVdEpu?=
 =?utf-8?B?RjZTZDFKNXRDV1pMUWdlYzdXUlY2UUplZGswM2M1NnptaXBmVHBpaCtEZ1dr?=
 =?utf-8?B?UW1QMFRQNUZwUFBWaU1SMHpRemVPUUtEbUZOOEJmSDJpZjlxYnQ3VEdhY0lV?=
 =?utf-8?B?YkdoZFhwbU5MYk5lSDI3aVF0QkFUZGxEVFJzNHBlNCsyNWlUVy9CeENJSGNS?=
 =?utf-8?B?T3h6L2ZENFZOSmQ3cjNRWjBibksxUkYxS1A1NjY0TWdCREhRRk5hM211VC9i?=
 =?utf-8?B?WFRPbitaY2RlQmZ1bis3QVJMdTFZdzBUMk9FNWpEOTlxTFM1aXdUNDVXcGpk?=
 =?utf-8?B?USsyMCs4dXJjNTc1ME41NmdKKzNHK2RMRUJNVDdxTDFtSVdZakZKUUV1NXl6?=
 =?utf-8?B?VGlPQVNiSExiYVQ1VE5ORFFycXA0RzF6R2V1aENmN1pzU1J2TjhVTmpoVGNk?=
 =?utf-8?Q?AfJuetk1fwCyXKvxmeYDiRM0k=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;5:fdU8gMXHtpQaMPavlhA74/7KZEBFCQ7aPcgww/UdN5aOR4ZGzJ6Y7G3xOXc2PtvN4VROvTSHFud+59CFDZ+hUgnz971MSA6FSZWXb4m7IT9tyuMBphWoA+mIVZS56KvIvdKWYXx/U+X+McIVbh8B2w==;24:5rgukkgVYr/Caa58ewek8YRPLCBVAa6ZUyTCx51a6CmYVJoADwyMEuYQkfdYgwUMcWu9JwXoUjaSxCFgQzly5TODJt4sDpTAPSpwseUwpyE=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2016 17:57:07.6208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2144
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51708
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

On 02/03/2016 09:52 AM, Sergei Shtylyov wrote:
> On 02/03/2016 08:45 PM, Zubair Lutfullah Kakakhel wrote:
>
>>>> Add basic CN7XXX interface detection.
>>>>
>>>> This allows the kernel to boot with ethernet working as it initializes
>>>> the ethernet ports with SGMII instead of defaulting to RGMII routines.
>>>>
>>>> Tested on the utm8 from Rhino Labs with a CN7130.
>>>>
>>>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>>>> ---
>>>>   arch/mips/cavium-octeon/executive/cvmx-helper.c | 41
>>>> +++++++++++++++++++++++++
>>>>   1 file changed, 41 insertions(+)
>>>>
>>>> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c
>>>> b/arch/mips/cavium-octeon/executive/cvmx-helper.c
>>>> index 376701f..1a28009 100644
>>>> --- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
>>>> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
>>> [...]
>>>> @@ -260,6 +262,39 @@ static cvmx_helper_interface_mode_t
>>>> __cvmx_get_mode_octeon2(int interface)
>>>>   }
>>>>
>>>>   /**
>>>> + * @INTERNAL
>>>> + * Return interface mode for CN7XXX.
>>>> + */
>>>> +static cvmx_helper_interface_mode_t __cvmx_get_mode_cn7xxx(int
>>>> interface)
>>>
>>>     Not *unsigned*?
>>
>> The rest of the instances in the file don't have unsigned.
>>
>> Probably because it is an enum..
>
>     I meant the parameter, of course.
>

In this file, the "interface" is consistently given the type int.  Check 
it out, it is int everywhere.

I think it makes sense to maintain consistency and use int here too.

David Daney


> [...]
>
>> (⌐▀͡ ̯ʖ▀)
>>
>> Thanks
>> ZubairLK
>
> [...]
>
> MBR, Sergei
>
