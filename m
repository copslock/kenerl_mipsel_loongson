Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 19:45:04 +0100 (CET)
Received: from mail-sn1nam01on0087.outbound.protection.outlook.com ([104.47.32.87]:61177
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990475AbdK1So40aaii (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Nov 2017 19:44:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=znDWNgtkEprD5KxltulXLeSBw5a1Qxt5eKjAyg9HeSI=;
 b=cK0HMosI8sOvW8SeBBffVV4zzqOqBeTQcPgSQArD+5FXsIqNV2BAVkWtFCa0QK6NivTunv8RZj4Knw3c1Fl103AbjxL4yxCqchF71lqvn4L5CGamk6CnzEJ2QnaxzMjPVwIO1kNVLClW3+lKBDtmlYXyoajeZv68ZyJTIE3L09o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Tue, 28 Nov 2017 18:44:45 +0000
Subject: Re: [PATCH v3 04/11] MIPS: Octeon: Remove usage of cvmx_wait()
 everywhere.
To:     James Hogan <james.hogan@mips.com>,
        David Daney <ddaney@caviumnetworks.com>
Cc:     "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
 <1510633827-23548-5-git-send-email-steven.hill@cavium.com>
 <2f2def3f-e047-1a46-1cd7-ebf4744dc2c3@caviumnetworks.com>
 <20171128110434.GE27409@jhogan-linux.mipstec.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <f348b767-c0b9-aeea-c5fb-3e779c914917@caviumnetworks.com>
Date:   Tue, 28 Nov 2017 10:44:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171128110434.GE27409@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0041.namprd07.prod.outlook.com (10.168.109.27) To
 MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c11f3b-62aa-483b-2d62-08d5369018bb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:MWHPR07MB3502;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3502;3:NqDmiOU7Pwle7yvQ26twhXjVXtgkQnpJUdWOVJ4NUQefo4EHGtR1AFZsFCxYOlI/s4WpkIiwBGF/I82RpxgFylwWaH00HaYjt1FKcwtNXMWEcOSDuJ53libeoJHkBVe+ixDLCUha4OXwaEoTEu2+/S0A2cDTdS2LixmBjJ+uRPMKja+n9vM8/ak35sL7yKuQYxz9uGUq/GIOdG1WbjzbSw6Z+hDkhEOdEuYhfr+AS/XmThtmMI96IdmVTSR9N90Y;25:G2nCQQ8CUL7V25gKvZEcM8ewpQsNzNBqgFGdJzRGJj65KidvLmIe34/nrqjQC5aDQKY3i5ICyCCzxAgRgqfzDo8gFJIe3EgaXh1pxr+e+QOb7pyK57idlPUUtAfOSgbc42m4BxGFaEQE5uqWQno7LwwdX6X3+/T8skmhpv9iRVvPa415YnNUIFkAUxUSkUbL/WxS6VbHJtQgY3S6Socr7h1gK3f0tVIrc/hf9b9OKXjYFiMzAn8VFXbkj+VWtw71qSM/kkATyPJLgaGfakfR1fJyj82UvIny+FjHEBhVtAvklHUfFOWnXVQ7nPJyCJcByJfMNkveBMTJIl3lHCE0Jg==;31:Zyz8RHaMQ5WxBTbuOvnUcHCrlaZCEyoWV07p1cdozhwpY5Z01gy51YptCeObPA1RPKS5Fq/pd1QRicWY2yFVzoWyAMAGSxdH3N4mKJYDAw9xmrBKh7S+nJaqq2Fc0pRBw9hgn/XTsRdYcYvivrgjx14yEk7qln2zKnnlHhhxZ/FgVQNaudPZFC55lAE6+/tP+psyuzBmv2m0x0rai+cbmv5LtzP81lDUAe6o8TWQL7c=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3502:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3502;20:9RpXgc9IJ8MzKPB5jPlQa+i5LjXtCYi24XTLhXE4TnBFZs6kCmGpmmjYZiwXkHIFrlbCCzImSGUt0xmnMHOAbMDVzRaKcaxdlv4sPXTm7GdY2Ce9uOqniQeOepZmskcUo7wwWgGud4pclzH3dqXtBt+cN6MIrq7RYrseY5rAzl1sab3ebS59yXF/dKRuqDianu/bhQ3EHdqdIgud1BnrhPiuZmDtHtTY1n72PRwj2mJiBrAjj3e4XJCYDJ0btXM3oluPLhM8/OK4IpkKBK2H+C2MP5m6ELcb33SiTLKPOKwSXCi0KJ5z9QCC41wyo6pl48tmat/BHxRgVZzxi0pQBC4zvlO4JvkiJGasYUa4qFPiLVSVbHrE3pDVRBMV7zY5ZT7TusX+5FD5kn5pw+AoyojNW+vpj1Q9vAvIFXBi2ZJ0137bT37Qbs0e/HGcnJM+AbyytajASTpt8QtU+BnR6ivLCIOMJdAoJ75vBUZO69t7gbTOEsnDHJDk4jaGaJcx/uMW9TI5FDb57Nx/WRdQuVGVbD07y5S/8AgXodmJrLICHwc4on3FuvJ424O36qETLrrUCvzOLUe/iemZEditeJLXlSsLpvOTG4S2ODcFu4U=;4:/VgvWG+T7pXUPKJgy4fGQoPOdnwhINFEi2kQpFz6234gmWDKgwaXrQSNbkRnJ7EvL+kemKZtj8IDSuWKmCLLnmxJs1zxUwD8EAJLWvzF4OmEmXDMf6pr+rUb+2gl4jiiAntL2z3f2qjbLgVmEZ97bGhzO/p19f+pkIgIaVuuxglyalLlf1w/j7b7oGVTYxNXZ2P+NfxpwmAVzzzOARbr+shslI4uyUHFXXasOmQmGwfbfOmb4qSMB9ph5uWueMke7jZ3KuCIuIHw98Zsr7d/mL3vxQYnV8LsX3pfrkUBKReFcqXiucsobfpvIZZ+Bbhw
X-Microsoft-Antispam-PRVS: <MWHPR07MB35024BE7F7AAB21EB7BF652B973A0@MWHPR07MB3502.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(10201501046)(93006095)(3002001)(6041248)(20161123560025)(20161123558100)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(6072148)(201708071742011);SRVR:MWHPR07MB3502;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3502;
X-Forefront-PRVS: 0505147DDB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(366004)(189002)(199003)(24454002)(6486002)(966005)(7736002)(25786009)(65806001)(66066001)(65956001)(305945005)(53546010)(6116002)(3846002)(16526018)(33646002)(31696002)(36756003)(101416001)(81166006)(229853002)(67846002)(2906002)(8676002)(6306002)(6512007)(58126008)(81156014)(110136005)(478600001)(5660300001)(316002)(53936002)(42882006)(83506002)(4326008)(47776003)(105586002)(31686004)(72206003)(50466002)(97736004)(6506006)(106356001)(93886005)(69596002)(52116002)(230700001)(189998001)(6246003)(50986999)(68736007)(2950100002)(65826007)(76176999)(8936002)(53416004)(52146003)(2486003)(64126003)(23676004)(54356999);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3502;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAyOzIzOmJiM0VNeTAvK1JQUFFxbW45anBhMEQxWTE0?=
 =?utf-8?B?d3pmK083SlJybXl1NjBNV0tWL2poOHB4bWZacTFQYTJpU3NCbi9FL1g2b2ZX?=
 =?utf-8?B?TWYrZkh6UjdaY21TM1RGU1J1NGtHdDR5bDdwTnFHdmJRL0IreFlIbE5UNk5h?=
 =?utf-8?B?Rk95YmRUaEdNdGpMeFJvYUs1b1huTVg3N3JNUllaalVkZlBvRjN4bDNWbGZB?=
 =?utf-8?B?WVFvK2hLRmZoWXUycGpDTVpGbk50ZmdPck8vNHFoTEYwN3hJRGJub0dlMHBJ?=
 =?utf-8?B?OTQwSGNaR0w3UndHMW1rODVCSDFQdlBrUjlteExwSFR1MlQ3d0VDRm1EbkF3?=
 =?utf-8?B?YmFUaVpCaFdLNXdzNENZZys4OTZsM1I1MlZkTWtqV3JVMlNhOTlCOHlCZDRX?=
 =?utf-8?B?b3VnU0VDd052SjBBUE4vdzRCbDhYRkQ3ajVTWkNWUGFsSGRVUWFna0htMVNt?=
 =?utf-8?B?M0JYZ2VLTzlIam1MdWVIOFR0ZS8rWWJEQjh6b2YzcW1FQzNWcHdHNFpOLzFS?=
 =?utf-8?B?bDlZQ3I4NFlsdngrd1FLQ2JJVHJBTVlHVzNseWJLS2F5WmVpV2p3SEh6WUZ6?=
 =?utf-8?B?WEVLRE03RmtuMFBzMFIyUmhyZDhpSDh6L1p5ek1BMHlkL3E3azV3cWhXYnM2?=
 =?utf-8?B?NTJPM2dsK1VIYnZaWTE4dXBSNUVydUJMTUpPTlR3cmxLNHVydDBySTc2Yndv?=
 =?utf-8?B?UHBzRlZPdzZVdDQ1NjFjQkQ5T0FiZGZkbUhvSXVma1B3S0JwRHVsM3RDT1Ex?=
 =?utf-8?B?cGtSTnBZTFBmSFFybW5GcXdpaGMyWkVOMU5wMW5OUmhRUFIvaERWTVdveW1D?=
 =?utf-8?B?eWR4ODNRVFhSWTIrMmVjNXZGbnB2UWFxTUcyNzBva01YMFFIODBZcWxHNUN2?=
 =?utf-8?B?VU85MGNLNUFLRndHS3R2YVlGSTkzamVId0tYU2FheTdkOTlYWVdqQzA3enlT?=
 =?utf-8?B?WWpVVWN0YWMxdUYwek1ZcExNbzJYbDRFcERyMW9HbHhpSWZCeHdjcUc2MzBQ?=
 =?utf-8?B?RjZ6eDhRaytaUDU4YnYrSGR1RFNwYzZmUEhNY1dqd1pWYXhyMFpZbVdoU05I?=
 =?utf-8?B?Y2VJcnJ3NW5mS0pFeCs2a0x4MEI0ekpzSFJoaWdpSU1wWk5FR1h6ZXZnRWt5?=
 =?utf-8?B?TFdXeXc5bm1hc3hrWmVEUjVDMG1QVU81MXgzcmNwNHhrVW9UOFRTaldNbEdG?=
 =?utf-8?B?REhnVG9KQXpTekNOUC9kTmprQmtEdXRLN25sTmp2c1RXNXMvWlRUdDBIeXNn?=
 =?utf-8?B?MEpOdHlHdU05TjE5K05OOVozc3RPeGRHUERnR1BnWHNHTkszZGhlRVQxSVMw?=
 =?utf-8?B?SXJyNGFSYUJkWmF3SU5TUlRTTnpNazN0V1dkZ2huUExPNk5VQXlRUzR4N0RQ?=
 =?utf-8?B?V1p1d2haM3padm5KUVZWT0xFZStZNGxNS2RkU0hjMnFaUFc2MUwwS2R5MHpo?=
 =?utf-8?B?eGFsQXhadHVrckhQcTMzeUR2WlFBaUpnODlWZ3dLNUJueHVQZ0MzZFlCUXR2?=
 =?utf-8?B?UXgwK09JWE1xRlRVaXRvTHF3TTUvUGxnbnFoSWROV1RneHhqZmpveHBSUDFl?=
 =?utf-8?B?UWZ0SmJnNWcySVp0SVZUNk45OHFXSDV5aUt5RU9yaFNXNFFBSlBZdVpmb0ZF?=
 =?utf-8?B?dnRJOW0yeDlLRzh4NlFad2pWNmNHa2dOR1hqRDdHRSsvbXdLQ3lOdTE4MFM2?=
 =?utf-8?B?TER0VFdFMFBFRThhMUFCdDE4U09QQkRHM2dFRDkzQjV4N1pkSUd6QzZmNzVO?=
 =?utf-8?B?ZWt2RmZSK3VXeTJEMVRpam9SWTdVTmtQSW9zM1FsQkVsZmgxV0lGZ2JCZVNk?=
 =?utf-8?B?bWUzR2ZMcWRGa25hVUZzSDVwbFFPZVo1Nk90WUN5VHRFVldxb1FWMll6Qk5r?=
 =?utf-8?B?eHBXUHpuSDAvbWZGd2hGZDlrYkhPY2JKVXJEdERPVW1BeTBoZTZQa21aWjR1?=
 =?utf-8?B?aGRmb0h0ME9HLytxdUQ4TklhWGpENmRBZC92bVhYdmpQL2lTNkc2bEI2Z2Vp?=
 =?utf-8?B?aWU1YSs2T1VWUzUvcWJlV05qckxuMzFodWNpZz09?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3502;6:AUFMrSNS3cf/D10tpCaAmmaHC5ob80gPdQqciSsF/TH04aee/kB1rzEbXcLT5k55Slc4xaH0rtJGezrizQhsZNToZ49A0GV+GarbHbnxofoBdeQfOtHgNB6VZPkQ2kzVs8hfmfkhmpuzC9OSQ/QMJyA1svLEd3lwqJowWsI+a90sYBC/tHQONhXJaOl+Ra0swN7Cntb5mJ3xQYKvAj0OPs4t0PFhAp6//ANlYmfGaj4hEae6S9K4lRVXMKSrS2lK8twxvl6iXqGuiMqM9bKLZZ36FvQKwTmXzyAj9PsNkkM8hV/8uON5Vfbkejw1cd87ykk1LhVzkb+oGajPhmCK0P3mAhODCEbQQxWmCNeCERk=;5:6Duy51YlS1ZkX3yfPS4w0XQd6pCK01R6QTkQ0V1vr2/AEyY7IH3XjyIl+jC7fR0PAsEC/U2hsGKFQZH/2iJHA0ujGwxUfloApPzhnEwdYnTqKocJqBiKX4/VOKfqUGUW2g+DjFFiveJ7ncmALwLdqHvmuGil7+x5S5rKCljNjtw=;24:5639Wv2+rddfFLNAIz0UPDgH8F2a4GdPngHHx8oAi9DbcaJGFXFWHR2UEmO3ngQtSysPj9ONHTz5kL+YvyIOwBh2YPqRKo8h0cK3WrUS5Mo=;7:aGyuwcUFRPelxAT2B8ywqFAWrJSAPKp6RgZx48iKn+wk975spE9V5Qh/NT8nHce6Em6RoyMmA6Q4CxW8zXkOmdU/ohomm5WlP9HPVea0xU3Bv+EeFFHI8/UaGsCp2yMasoj/Rq1Cl4mSt4I3dZpY38rUGpf2ZssjqiB3GTYOstVTsRTMJfFLb5at/B3HWr0/PekfUC8RUcfG8uSBbADv6C8VxrjYHIRKk/17hwJ7IbDnQEE59VF4wXmt5MZnwU5j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2017 18:44:45.4341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c11f3b-62aa-483b-2d62-08d5369018bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3502
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61162
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

On 11/28/2017 03:04 AM, James Hogan wrote:
> Hi David,
> 
> On Mon, Nov 27, 2017 at 10:56:33AM -0800, David Daney wrote:
>> On 11/13/2017 08:30 PM, Steven J. Hill wrote:
>>> From: "Steven J. Hill" <Steven.Hill@cavium.com>
>>>
>>> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
>>> Acked-by: David Daney <david.daney@cavium.com>
>>> ---
>>>    arch/mips/cavium-octeon/executive/cvmx-helper.c |  2 +-
>>>    arch/mips/cavium-octeon/executive/cvmx-spi.c    | 10 +++++-----
>>>    arch/mips/include/asm/octeon/cvmx-fpa.h         |  4 +++-
>>>    arch/mips/include/asm/octeon/cvmx.h             | 15 ++-------------
>>>    arch/mips/pci/pcie-octeon.c                     | 12 ++++++------
>>>    5 files changed, 17 insertions(+), 26 deletions(-)
>>>
>>
>> WTF:
>>
>> drivers/staging/octeon-usb/octeon-hcd.c: In function 'cvmx_fifo_setup':
>> drivers/staging/octeon-usb/octeon-hcd.c:636:2: error: implicit
>> declaration of function 'cvmx_wait' [-Werror=implicit-function-declaration]
>> cc1: some warnings being treated as errors
>>
>> Why was this patch submitted and merged without running git-grep on
>> cvmx_wait?
> 
> I guess I put too much store by your ack ;-)
> 
> Lesson learned, I'll grep next time.

James,

   I didn't intend to suggest that you are responsible for checking 
things like that.  Both you and I were fooled.  It is the patch author 
that I was hinting at that should be responsible for checking on things 
like this.


> 
>>
>> Steven, send a patch to fix the breakage.
> 
> See this patch & thread which you were Cc'd on:
> https://lkml.kernel.org/r/20171117075010.24131-1-aaro.koskinen@iki.fi
> 
> Cheers
> James
> 
