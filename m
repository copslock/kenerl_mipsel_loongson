Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 17:17:41 +0100 (CET)
Received: from mail-bl2on0067.outbound.protection.outlook.com ([65.55.169.67]:4942
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011873AbcBKQRiu4wlN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Feb 2016 17:17:38 +0100
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 DM3PR07MB2137.namprd07.prod.outlook.com (10.164.4.143) with Microsoft SMTP
 Server (TLS) id 15.1.403.16; Thu, 11 Feb 2016 16:17:29 +0000
Message-ID: <56BCB415.2080600@caviumnetworks.com>
Date:   Thu, 11 Feb 2016 08:17:25 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        <Zubair.Kakakhel@imgtec.com>,
        Aleksey Makarov <aleksey.makarov@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com> <CAPDyKFrMgt9snP2NLbQ6EQ5X7gjQLA+e+TEfqgjzLYTuH+G1OA@mail.gmail.com> <56BB9877.9000305@caviumnetworks.com> <56BC4538.20207@imgtec.com>
In-Reply-To: <56BC4538.20207@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN2PR07CA003.namprd07.prod.outlook.com (10.255.174.20) To
 DM3PR07MB2137.namprd07.prod.outlook.com (25.164.4.143)
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;2:DT75+ddriCO3tMd5kQ6OGTH+xxw6/4o+C7eN+BiykXJPuTcs54/rux3N7ABH+f85X1pSquZvkgxmknbt/hsnJRXVTjuXr2bRrqCVl2TWjPtGIQDRxF+bOHVrUG9SroSgy8RxLGZsjvWx1JvBi7/f/w==;3:VReNEA8deIGSHDCQ5yrHpImECr9xOvlPI5YTZnwHU1qVZNQpqJV4ik/7CFMIGPVOQ+kWdcwft4LLEfdcjIg5QZnOilyVh2Eiov4WjurR6jHKvByR3mOzLOjiIpGJFDiA;25:qww5DAqZJCn3382/t4Kqbu33dzMRliocfFzTXqJkf6FRYVAldXR40LjeY15RbtKWJrR4yss4TcAIqnOo7yeK9lVhLBpobd13FTb9ww7PiZezlaGmCWMoi/uuefl2vddCNTzaMynerNijSp0I5bdtDANMOUJS37fiuCZDoFib2SYiKTkf3RGWXP+ANsG0/PFQrkdY0dmrnI8BmreBSdB/Iz+OJwikF7BlAjz0z7yOPWhYhxPwvw56X9HR71SCbFTjtZk6Bqw4oppIgmGyykC2YaUU9/tm8GXNQTd+bgQjGWZzHmDU/Eh6+jcyK2JJtp/0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2137;
X-MS-Office365-Filtering-Correlation-Id: 518dbe58-a65d-4567-a6dc-08d332fed759
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;20:cWgLoD8EotgkZ8LWcwvD1JU4z+6GNa6QctoRs4FyUZah4vUBhCsOfMoeJeQYYrYPsaaB2Tnb7AZfMQoI5AdK4XSYj3B+P0TRnFyFyFVU+YvHwEJ1NV9zO8ReRhgBv0sFy+U9iQx8pMZPiK2ruLFGsdDoi0YOifOqIMbvWICFF2JVGxjpXA4D1FUnSjAqzm8VQxRqHgduERhGiJIOatjSofnx4p1vj6cnaChl73AfSjtV0qvrk/QBDmEWiQfrZB0zZMa/sYrq57F2g21fLbpo/vTLKAaT1mgyD/Aa8kZUWjetzixJQGi0GSZ9Km+0nztPLaRlT34xUo1jhPOJnZbBL4nckICxGYWLtH4m2O/wtVzozcvZ4zzzpoofpaQWxobX15MZJt4YcJ6w7K8JBdufVbFVnkZcXZMJWdVH92tEjeQoyJH+hSIgI5CpUE5tT4aRmahZL8P6DzZjoMFFonEMXu95pUPTTMHw1NALN1eQLdvp0HhK+IxiaC5PLyGMkJA9ky9meR4EBFgrP7GwftFLqY70KTw3YMwx1BNv/PKSEJ7JPYEb92GhMAHC9cI3w8QSnzT5Tv3z2k7KAI+KZv/iJurLjosLFRQSmgMmZiJkVJk=
X-Microsoft-Antispam-PRVS: <DM3PR07MB213789FA1A2F3C4DCF34FA709AA80@DM3PR07MB2137.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:DM3PR07MB2137;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2137;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;4:297wOz694lmVoHe7yivLLIfQwdBkq8xiMDx5ZK06ELTHym2+NIAGAHCrn3M0aHMdO1rQ5iVNT4LvftWyp6rDEKbpmBC0M4vqaGSh7QJDMxR2Ad0M4EoRhAhwtVqA2/3ieHUeq3xZWkLb9C/Bn2SeHfh8PGHdr07hOHsLw9HyS/Pje6XTNxfuKPnC1mLTEULfoqAVdZi12Rafa1rzXkHRJ2xVFBOx/Fy0ayA4NaBCO9NIik/oHBT+WdAsCMXIVK6I1MBHHhjmCer8Gwvc5RfhEU5KMIl91nBH1RAiynWS3Np6FQEZpCuioyrpL9aOHn2YHZj4Fsswj79m9n+QwqDKkXfLl2HrEycWWu7bhEWILOoaCg5zX/aum1Ui86RvsfUr
X-Forefront-PRVS: 08497C3D99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(377454003)(479174004)(164054003)(24454002)(80316001)(19580405001)(87976001)(15975445007)(92566002)(5004730100002)(33656002)(77096005)(47776003)(2950100001)(42186005)(54356999)(65816999)(76176999)(93886004)(53416004)(5008740100001)(50986999)(59896002)(23676002)(64126003)(87266999)(50466002)(40100003)(65806001)(65956001)(66066001)(122386002)(4326007)(83506001)(19580395003)(3846002)(230700001)(2906002)(6116002)(189998001)(36756003)(586003)(5001960100002)(4001350100001)(1096002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2137;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTNQUjA3TUIyMTM3OzIzOmlhOWt5VU5vditxZnFsWllOazMreEowbTMv?=
 =?utf-8?B?ajUrd2NqV29MdS92MGxhVzVrYkFnKzkvWnlsQzErekMrMVZoOTBOcy9NUC9R?=
 =?utf-8?B?MjFCa1k5Qy9vSC9yMGxFaFBwV2ZMMjNtZ2Q5dUJlRzNnMWJZYkc1VncvSnov?=
 =?utf-8?B?VjNhVWw0bSswclBoYWRBQlJOeGM5ZmZreTdyWXJpSjJ4aDhNVml3d0U1S2N1?=
 =?utf-8?B?Skc2YUVTbmVUMzl5QUpOcW00aG9nb2NNVDJCRXlWaUtlaFpEQ0g2aU1YUlRW?=
 =?utf-8?B?QVFKRklRZGxBNjRQZFEydVVjUG1ybUZhNkd0Y2NRRjF1eFMyZXk2SGVsaDJF?=
 =?utf-8?B?MjRhYi9VWjlOdE0rZWVNS25LUm9PRW8rY3cvYVdwcFRIQUFnZUZNbXhWNVVY?=
 =?utf-8?B?MlZyaXpsR2E4YWd6ZFhLZzlXVzFJNlRoQVgyMktUOHRsOUhVckhidDBFb2dZ?=
 =?utf-8?B?U0dYRjhVOElKeStET2oxOWxROVgvZ3ZvRCtBS2daSHNjZVE0clBxZVpqMjB0?=
 =?utf-8?B?QjJHMjgvTGhKMzhvMmZRSXprbitPUGFWeWdldVp4VXRZbk43a29LTzF4Umlk?=
 =?utf-8?B?NHMzWlNndk03MXc3MTB5Y0VlRzgya2JyNDFTbXhJcWlkbFE2eFJoQSt1bjdK?=
 =?utf-8?B?RVY4T2d6K2V1aVd6eWpkZjl2ZEJjTklhNUxLaDRINnU2RldVTEdjV1Nrb2xW?=
 =?utf-8?B?dW13Y2lvbldXNFRJRnFKU0dINlRpR3N5ZHRmRTVQVnJzVXZ1ZVg2d0tzOTVh?=
 =?utf-8?B?SkhkakFpd0xDK0xDdk1hNXQ4cFZtM01OMlNma0hHdS9iY25HLzZkSHRiWmxs?=
 =?utf-8?B?UGZTRytkRFNZRTZGdkxQQ2VTd2tDaTB0bDlNWjBXTTFyVzlMYWNBN0U2djJw?=
 =?utf-8?B?MmxjUWdsUS9remhoZlYyTlJONFM4NU9jeGtCZ0JaTWlMdEppZS9IU2VnL3dv?=
 =?utf-8?B?SXN3Ry9YNEFtbm9rcXdCdVZqT1lxd0FGM01hVVRnZlU1T09IdUlyZlRXTVZM?=
 =?utf-8?B?QjR5YUMxZnBCdkcvNE5qZUVqSFFvMGh3eXJCVkhkWms4N1B6WTEyTWpjbGZj?=
 =?utf-8?B?YXdKN204M0l0dytPMnNjb1VBeVVWelNJNHUrb2dKTHRPcEJoTnFFSmFsWFA1?=
 =?utf-8?B?M2JUd3RqaFArNkM3cTlxSGRCUHB1T0VzU1kzNlEycW1ISFFEcmp1bzFYSWxV?=
 =?utf-8?B?K3RiSnRNNzJSdjdBeE9LWFNGVTdldUw5eHpJNGlrRThJc3JFekt1VXIycHMx?=
 =?utf-8?B?VjJOWHl6NlpSRXZ2aWFLRkx6eG9WaEhpMG56QzIxWnMrd0VWRmZWYk1CWkc1?=
 =?utf-8?B?aHI4djhjUEJIc1VVWldUQUxTTlE4VllJdGkwYm5WcXpCTVBySFU2eWZ4Z3FR?=
 =?utf-8?B?VjRDZGg3K1FKcXJjWVpvTlBxSlljbldNNnFaQkp4SEZ4U0tDUnpLQlQra2JQ?=
 =?utf-8?B?dytXM2xsa2I4dVlLQktjUGZCTDZlT0szVUFYQk1IaGNrSzFFQXN2KzJqMFZi?=
 =?utf-8?B?bDRrWkVkSHYzS3ZmS01oeEN1ZVNVQzVXbVhyLzZqY21wK09xWjhTRTdkQ0Yz?=
 =?utf-8?B?UEoyVEhBZThzZmNyMGxhbFIyME56MVRlbFl2R3BTZnlIK09TOVUvWVplQWYy?=
 =?utf-8?B?Vnhxa0ZpS1NBY1N6N3F0ZkswaW1wa1dBNlpQZk5Db0sxUVB2Z2FRb2JBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;5:yILKJHXdHuUXD0Kk8MTcAxC5bQDkBT3xK1DSzDDhmXFeh2bo0d7c2iDEUIu4fQ4KsiPCqy7bOFlEIxZXFOwYHJOs1304eoGWInhqQU3P4IwXKrysGnvVq8687O/ai4UvbdB4bIAkb+5ogstONj0dMw==;24:MAsUpnq+S0DQbnZcpsQC4LURl36gJ38J2ztiE/GRBzH3BjlNAUSlxbCViCgUyRcCZu9W+XIrALtz2FcfoKFJZsIGwycft19Q/LCZi6OktNg=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2016 16:17:29.4180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2137
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52012
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

On 02/11/2016 12:24 AM, Matt Redfearn wrote:
> Hi,
> I will split the DT binding document into a separate patch,

Good.

> and move the
> legacy FDT patch-up code to
> arch/mips/cavium-octeon/octeon-platform.c as suggested by Florian.

NAK to this part.

We are just talking about a couple of property names.  The code overhead 
of handling a few alternate "legacy" names is much lower than building 
infrastructure to patch up FTDs.

We should concentrate on making things as simple, understandable and 
reliable as possible, not building Rube Goldberg machines.


>
> Ulf, your objections to the structure of the DT and driver were the only
> driver for the changes v4->v5.
> I changed the DT binding and the structure of the driver to more closely
> resemble the atmel-mci driver, which has the same concept of one
> controller, multiple slots.
>
> Thanks,
> Matt
>
> On 10/02/16 20:07, David Daney wrote:
>> On 02/10/2016 11:01 AM, Ulf Hansson wrote:
>>> On 10 February 2016 at 18:36, Matt Redfearn
>>> <matt.redfearn@imgtec.com> wrote:
>>>> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
>>>>
>>>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>>>> devices.  Device parameters are configured from device tree data.
>>>>
>>>> eMMC, MMC and SD devices are supported.
>>>>
>>>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>>> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>>>> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
>>>> Signed-off-by: Peter Swain <pswain@cavium.com>
>>>> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
>>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>>> ---
>>>> v5:
>>>> Incoroprate comments from review
>>>> http://patchwork.linux-mips.org/patch/9558/
>>>> - Use standard <bus-width> property instead of <cavium,bus-max-width>.
>>>> - Use standard <max-frequency> property instead of <spi-max-frequency>.
>>>> - Add octeon_mmc_of_parse_legacy function to deal with the above
>>>>    properties, since many devices have shipped with those properties
>>>>    embedded in firmware.
>>>> - Allow the <vmmc-supply> binding in addition to the legacy
>>>>    <gpios-power>.
>>>> - Remove the secondary driver for each slot.
>>>> - Use core gpio cd/wp handling
>>>
>>> Seems like you decided to ignore most comments realted to the DT
>>> bindings from the earlier version.
>>> Although, let's discuss this one more time.
>>
>> I think you may have misread the patch.  The DT bindings have been
>> changed based on the feedback we received on v4.
>>
>>>
>>> Therefore I recomend you to split this patch. DT documentation should
>>> be a separate patch preceeding the actual mmc driver patch.
>>
>> You may have missed it the first time it was posted, but the legacy DT
>> bindings have been around for a while.
>>
>> See:
>>
>> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-May/015482.html
>>
>>
>>
>>> The DT patch needs to be acked by the DT maintainers.
>>
>> The legacy DT has been deployed in firmware for several years now.  We
>> are adding more "modern" bindings, and the DT maintainers are
>> encouraged to review that portion, but the legacy is what it is and it
>> isn't changing.
>>
>>>
>>> Until we somewhat agreed on the DT parts, I am going to defer the
>>> in-depth review of the driver code as I have limited bandwidth.
>>>
>>
>> As I stated above, the legacy DT bindings are not changing and must be
>> supported.  Waiting for legacy DT bindings to change is equivalent to
>> infinite deferral.
>>
>>> Does that make sense to you?
>>>
>>
>> I understand why you would say this.  However, I think it doesn't
>> fully take into account the need to support devices that have already
>> been deployed.
>>
>> That said, Matt really needs to get the DT maintainers reviewing the
>> new DT bindings.
>>
>>
>> David Daney
>
