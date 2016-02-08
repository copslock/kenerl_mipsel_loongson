Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 23:08:30 +0100 (CET)
Received: from mail-bl2on0061.outbound.protection.outlook.com ([65.55.169.61]:50528
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012212AbcBHWI2VS0Xh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Feb 2016 23:08:28 +0100
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 CY1PR07MB2134.namprd07.prod.outlook.com (10.164.112.12) with Microsoft SMTP
 Server (TLS) id 15.1.403.16; Mon, 8 Feb 2016 22:08:19 +0000
Message-ID: <56B911D1.2090402@caviumnetworks.com>
Date:   Mon, 8 Feb 2016 14:08:17 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Harvey Hunt <harvey.hunt@imgtec.com>
CC:     Joshua Kinard <kumba@gentoo.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Always page align TASK_SIZE
References: <1454954723-24887-1-git-send-email-harvey.hunt@imgtec.com> <56B8DA56.9020108@caviumnetworks.com> <56B8DB2D.3070604@imgtec.com> <56B90A3E.7000507@gentoo.org> <56B90D30.5020904@imgtec.com>
In-Reply-To: <56B90D30.5020904@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA0028.namprd07.prod.outlook.com (10.255.223.141) To
 CY1PR07MB2134.namprd07.prod.outlook.com (25.164.112.12)
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;2:QDWstjCY6TfYPrk93k1qQqNkgpHB9LfxQIbyIqxD8YnlFu2S9n0uCFFjiCw/cBaCWUL1uklGNG3Eu4/nUbNnjwvppfGBvHb21EWgheWJvbQpy1Fjr7afZn1CyzGLLX36YVvFD44aOBb1dQzun5cOIA==;3:q0IPTTgRmRfhTQOt0TNA3Sup+GfD9bMKYa98mr1yenRXzVjOS+2PBbFSUeLmAds4TdUV5HpIcaO7b+3x0HuckPdwWSNrScmXWf4m+2aWJGxLN7xWfwSjAlxkhkIx6ged;25:VKK9N7zyE+yCl0YzxGBijVhPn6NBBXWMOajjFWfwzmotvuyHAGq8zjNFzOIDS+ulMPdQncRnfbftbKHdelQKyj4xkReyKhTjMSSd1pJcPvt61iwi3TqVOSiKytUT63TqAkJ4sjOUj7fjT13iot0IIxa8yMwmgePCHy/dMKx8NrH/YWh/xBMnTAem36OaOzpNMeCyzw13t7otyKOzKA+23vCCyXmznpOXgAwVojt34QJPMeHZjQvegHbXrq+XO14rA4sRuzRHEXSGb6xcBSIXmZ/woIjgvAdPWz/i6IZ5RWYx6V5C9Z2i41SUV/4R6ko8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2134;
X-MS-Office365-Filtering-Correlation-Id: 02cc18bd-1ba1-4bb9-a0f4-08d330d45b33
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;20:uN4RBgavKVJm/PZsIMfFCKDIZnfDaYF49Yovn+cJTY0n0EWAKrRt6FeO35abhT4UdCEntia8dMvr4NZQ0QRB+XH4soCNWVkdVp0n1csFnFzSRobHzy1+L4UeVeGbD354cN3WhmkNXBvYdfx5ymKV8NQRlUmYT3OR9p3fB3dqRAHf/IHgQgb998NHz7/63ZDmpiJP6Us43X4k6NlQCIGqpsXRTSh9Se6rJYC1ZU4BN3EiMj6QVxwg4EX3HtXEapuEGch/WSykjM4DgGQzfg3U8ly8awg84ta5nqmuyzvJ3RGIwvtKpxrf97CaFg45ayoVdlUFweTW1NMGPHsyBHs/Xtjo/3urMhtiLGxLHmiEdJxFjhww+8+euhNOmcVGF+AKP/FDc+5TJC8hlw09r69DbDet/s4ZoAXbUjx7gYdQe1C0jirTI6DEt1ivnJDRPFN+gv6gERiNU3zCcswrKUkOAyK/nFlg3F9xHyvrFmOVLSiRcf/ZogBKBKHlSHsTIaGB6WFhjKlk7jC6PFoept9G3UEOJ6F5ZXeZZEV/mI6ZUHqkb8zmJSARzCyJkA7OpxpASiOpzHAEykoWnQp8qn983IEo1DhGrivKQjZ0QJ67g7w=
X-Microsoft-Antispam-PRVS: <CY1PR07MB2134EBD0EB8CEB1568945E319AD50@CY1PR07MB2134.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:CY1PR07MB2134;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2134;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;4:YhsVfkk3rdUmb10UFfrD7UEbEFY36VafR26CZQaPnf1vmAD59hC1o4xEIemBRX4okKtG7xGYo3RczggUqFk4eYBmEHPPFXIi0as0Lwuv/lRavhYNn9dFFqBxDcHmBS6Uvp9BLxD0nO++oyyDoShYu76dZabb+vcDkb8noqMu4u3hhYZMV3o8ff8veolD7L/LB6p/lIE4xnkKOGdp9pG/4ssIxMEqM5jTJ9LewsDAKjymN5Tiui2TL3Dlhs3ykJzg3AVGhMkzWgQsvv7GcwIaEDOiA1W4lN3V/lyArf46soAT6NEHCmo7Ki1jbWS/VhzOHFM/gq175BQR8Bi3PfIqVvcyXj6bkQyPME+/TaoC8pWgEzzaix2UxDQfuV7vqtW7
X-Forefront-PRVS: 084674B2CF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(69234005)(52604005)(377454003)(479174004)(24454002)(164054003)(5004730100002)(5008740100001)(80316001)(19580405001)(19580395003)(50466002)(5001960100002)(64126003)(230700001)(6116002)(47776003)(3846002)(59896002)(66066001)(65956001)(65806001)(76176999)(50986999)(83506001)(586003)(65816999)(42186005)(54356999)(87266999)(122386002)(1096002)(92566002)(53416004)(4001350100001)(33656002)(2906002)(110136002)(40100003)(87976001)(36756003)(2950100001)(77096005)(23746002)(4326007)(93886004)(189998001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2134;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR07MB2134;23:AncAKXje5bFpeSzMejrH8W0bdWxv/kd+Ws/+s?=
 =?Windows-1252?Q?t3FhEHP1FOm2Vunm33Cn3MRTF7r976eW3z+++xcANXqRqYdUeYU68/iU?=
 =?Windows-1252?Q?d0+CdOF70GZmlcPMt7EAycMITLF+oaJiCZQR7zdJozAsIDyJuCB01Yne?=
 =?Windows-1252?Q?fVnC9qOl7VlR6K24Wcz2CL7mNOCrLpHkRqQXIvcXhkUuYA+LSB+tLS40?=
 =?Windows-1252?Q?eEJLxtWTQx0nWXuFySGOCo7wdfvLuCHXtsjL71GHc5AJFGIvJNxCLOek?=
 =?Windows-1252?Q?zfuD3rGSDPBIXrk9WyXYwc2g/FhMSBgyIa0S1T24iK8prnVhxKpXJ7QX?=
 =?Windows-1252?Q?CeY0ujdgMCcHpBQbBJBnmoN/rQxGVi0iwBhYPz2OZIWf1NR3Hyddj8Nk?=
 =?Windows-1252?Q?U14F5R9cHbK8HPycW9Sgtfi7zWQzGkoL2Go73SVaozm+aUQvM5RdIH8j?=
 =?Windows-1252?Q?rNWmm9PMsGYDBNfX5erW5osdAAeBfqQXGpmLPrSpekoapwgkdVBLTHGu?=
 =?Windows-1252?Q?nA2Q2dvgNcQB2htOzfo0cwFf5HnmZLhTPpV6HFKwXh6vbxEbIxvTDsV6?=
 =?Windows-1252?Q?Xt37r3XOoYXo6c1WkGshzUt50KLhNkRCO+czbtZFnD0baF2M/qk4kffi?=
 =?Windows-1252?Q?OV2QBMCW+pVotnSGqKL6dafrcLRdJq9GvGwH+f48OTEmwWoy8NmFA1N6?=
 =?Windows-1252?Q?6+Ln+YIA6RNXSKDkF+gC5QhnAq5CwoiBVdJuCYKJudh828aC903Lxifj?=
 =?Windows-1252?Q?bxLH5raFbOqiHwBTV+kapyjMhe+1NKBPjcnEi4Kt0nX5I61DFBme8CtI?=
 =?Windows-1252?Q?f6gRoaDLop9tiXpRcKvW/EpiKhIAvV15wdQSp0CmQWZ62SUwfjLKgILt?=
 =?Windows-1252?Q?SSF6MALEKRXBre2fbSt6+ko99H5hlZVEDyHBahrn1FWxzDhyldg/5Xyp?=
 =?Windows-1252?Q?LwlS2zIeTstX/0xBph8ihkmA1jQsAVqzZRU05jyVx85hITCUPFfhUsOM?=
 =?Windows-1252?Q?gt7DzmjALHLXCd6JvH0dSzj5zyIeoP2GKZqljOw0DfnW+kHThoEn3ekZ?=
 =?Windows-1252?Q?slYIJkZFhRjpHXerR3kx3IRReQu0d/BZhS6kgkcMFhZIAGimnMtZyvaV?=
 =?Windows-1252?Q?32u+mX6SSdhj5JvFKXAO6j1X05AU2GveQQHUaXFg6xpISv6Vjf1wMhz8?=
 =?Windows-1252?Q?Gj561yIUJH71ipKnchvBnO0zgtC1tRqYOtx20kL2DSsEuBksxRKYyHlr?=
 =?Windows-1252?Q?dXjFFlxbg31aZUonfLtJuFlP2m5gC3J+rXzyZchisl4+mAMZjOkcSoYe?=
 =?Windows-1252?Q?r97Z/rtr1pt7aCg9KS+QzSw+LUg+WZn/myQGSRlz4m4UmQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;5:DhufKuYZNVWfWG8A6qorenTv5h+TjqHlZ77DQFt9X7dmnBB2dnxKpm2m9OyesZRCNjlX3IE2wLLUfjfvun+pNk19SJTz4ZRJENoGGkAyT4Z1gxS7R3Pm+1dY7WNgZKmYG4NnjKby9zgN9A21MfPw9w==;24:OWpqTje2yJ5JxkRisLU2eVI2kFpdqdKQ1O0fpZKAPuq8B0qmbdgs4Aa+GEObMBj3FagliMz+hWmBPwkLq+2jAA2nzlpjasr/dPsXE81cPCw=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2016 22:08:19.8494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2134
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51871
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

On 02/08/2016 01:48 PM, Harvey Hunt wrote:
> Hi Joshua,
>
> On 02/08/2016 01:35 PM, Joshua Kinard wrote:
>> On 02/08/2016 13:15, Harvey Hunt wrote:
>>> Hi David,
>>>
>>> On 02/08/2016 10:11 AM, David Daney wrote:
>>>> On 02/08/2016 10:05 AM, Harvey Hunt wrote:
>>>>> STACK_TOP_MAX is aligned on a 32k boundary. When __bprm_mm_init()
>>>>> creates an
>>>>> initial stack for a process, it does so using STACK_TOP_MAX as the end
>>>>> of the
>>>>> vma. A process's arguments and environment information are placed on
>>>>> the stack
>>>>> and then the stack is relocated and aligned on a page boundary. When
>>>>> using a 32
>>>>> bit kernel with 64k pages, the relocated stack has the process's args
>>>>> erroneously stored in the middle of the stack. This means that
>>>>> processes
>>>>> receive no arguments or environment variables, preventing them from
>>>>> running
>>>>> correctly.
>>>>>
>>>>> Fix this by aligning TASK_SIZE on a page boundary.
>>>>>
>>>>> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
>>>>> Cc: David Daney <david.daney@cavium.com>
>>>>> Cc: Paul Burton <paul.burton@imgtec.com>
>>>>> Cc: James Hogan <james.hogan@imgtec.com>
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> ---
>>>>>    arch/mips/include/asm/processor.h | 6 +++---
>>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/mips/include/asm/processor.h
>>>>> b/arch/mips/include/asm/processor.h
>>>>> index 3f832c3..b618b40 100644
>>>>> --- a/arch/mips/include/asm/processor.h
>>>>> +++ b/arch/mips/include/asm/processor.h
>>>>> @@ -39,13 +39,13 @@ extern unsigned int vced_count, vcei_count;
>>>>>    #ifdef CONFIG_32BIT
>>>>>    #ifdef CONFIG_KVM_GUEST
>>>>>    /* User space process size is limited to 1GB in KVM Guest Mode */
>>>>> -#define TASK_SIZE    0x3fff8000UL
>>>>> +#define TASK_SIZE    (0x40000000UL - PAGE_SIZE)
>>>>>    #else
>>>>>    /*
>>>>>     * User space process size: 2GB. This is hardcoded into a few
>>>>> places,
>>>>>     * so don't change it unless you know what you are doing.
>>>>>     */
>>>>> -#define TASK_SIZE    0x7fff8000UL
>>>>> +#define TASK_SIZE    (0x7fff8000UL & PAGE_SIZE)
>>>>
>>>> Can you check your math here.  This doesn't seem correct.
>>>
>>> Thanks for spotting that - it should have been:
>>>
>>> (0x7fff8000UL & PAGE_MASK)
>>>
>>> I'll do a v2 now.
>>>
>>
>> FYI, TASK_SIZE was recently changed to 0x80000000UL in commit
>> 7f8ca9cb1ed3 on
>> the linux-mips.org tree.
>
> Thanks, I'll rebase.

You may find that in rebasing, suddenly you have a completely empty patch!


>
>>
>>
>>>>
>>>>>    #endif
>>>>>
>>>>>    #define STACK_TOP_MAX    TASK_SIZE
>>>>> @@ -62,7 +62,7 @@ extern unsigned int vced_count, vcei_count;
>>>>>     * support 16TB; the architectural reserve for future expansion is
>>>>>     * 8192EB ...
>>>>>     */
>>>>> -#define TASK_SIZE32    0x7fff8000UL
>>>>> +#define TASK_SIZE32    (0x7fff8000UL & PAGE_SIZE)
>>>>
>>>> Same here.
>>>
>>> As above.
>>>
>>>>
>>>>>    #define TASK_SIZE64    0x10000000000UL
>>>>>    #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 :
>>>>> TASK_SIZE64)
>>>>>    #define STACK_TOP_MAX    TASK_SIZE64
>>>>>
>>>>
>>>
>>> Thanks,
>>>
>>> Harvey
>>>
>>>
>>
>>
