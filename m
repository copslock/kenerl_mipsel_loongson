Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 19:11:48 +0100 (CET)
Received: from mail-bl2on0083.outbound.protection.outlook.com ([65.55.169.83]:35104
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012134AbcBHSLqOUDPY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Feb 2016 19:11:46 +0100
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 DM3PR07MB2139.namprd07.prod.outlook.com (10.164.4.145) with Microsoft SMTP
 Server (TLS) id 15.1.403.16; Mon, 8 Feb 2016 18:11:37 +0000
Message-ID: <56B8DA56.9020108@caviumnetworks.com>
Date:   Mon, 8 Feb 2016 10:11:34 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Harvey Hunt <harvey.hunt@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Always page align TASK_SIZE
References: <1454954723-24887-1-git-send-email-harvey.hunt@imgtec.com>
In-Reply-To: <1454954723-24887-1-git-send-email-harvey.hunt@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA079.namprd07.prod.outlook.com (25.160.24.34) To
 DM3PR07MB2139.namprd07.prod.outlook.com (25.164.4.145)
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;2:H0MzwQQWR9Mt2/nJ1Y+1ILCBLAAUi3gWwug1hX4PKxRf0FWKtMBwcJAgAba3l4PTx7GxeV21CwIGPNNOzL8gVD+fJ9qiMXR1CKMQ7CX2XqFUvkZLnUtdYEh4+/py8q+zU/xmX+I/AIHXNCjeEIx0GQ==;3:0jaAbtTV/tVVGNYEHNTG0fHz+rHZH2ulNN5AuWmWWzGtQ5BYtlTvLXs3qQxHIuG1DxRnS2+NR1GO/E4B5VBxUu/K0sp8NpyOo4Nlli8GwZ1hNy1J93T5SWbMffYvxxpc;25:9kuU/XfipmFB0b9d+zGvW7F635XwqX2oTSqfdwIGJQjts61ZfS/V0im32gsmyr9YCUGM3js6v2Ji+AZ3zrZegxcXvAl9ro06kKcrQSKuJAfBk0KzgkOZoS5JERrkyeLvLa0fkUQ/p8R7YRzmaODeD8JRuB3LUP0UOiwGYwjLz7DAC50jMQHEdY0rX6mrz6fNlvND60CjXP9TT4cHljOgI4QSKX40kmYeXo9q7qV3D/JRYVD1M5IxrmtrW+K52/kYjyLaifeIlXwBhV4NpViHLRAiw95ITWgxcmQm/jOMQ72UAzHg2UOG5+i2p+GuLkds
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2139;
X-MS-Office365-Filtering-Correlation-Id: 68d6534f-6476-49a6-21f5-08d330b34a21
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;20:AT5kETDpvIUfWKtLO4vUmX/PQ7WkCD7Ov61MJ38sqaD6vrhq/cmMwnOq0gaUs7LGyTd46nIefuVmkJtL2bjQZwfP880kmdD+2H057Ti4zc0xaODLqIgX2Tb/QI/nicQtZCYRD29i6Pc0yPFmoPM0N1erIixHHhFy+f/PUBlZGgoIk1SEFUPQMef8kybg5uLapHjUuiPY7ve36IUyHKmtno1r47d73MTjbdmn6fy8cLnbtZHhjeYC3toNFicbDPMnIzOJpCTtH+Xdmxpd5/m0Y2CPwbm1YdouuKdxZVEDo2Wk6Hzl480QpQu43/6tHGxnx5XgITRhvGGdeyiK29aMpuX5kIcJGdBc9FJesWsbfXjcDMtKG2fmY9bUYd4GPc8izZcHGrkg1gLufcAYTXLNkCReYtWY/ULY7h9M3PtUjeW2b91yySX83LwT4RXXX00n+3khcO8gbUW6VWYhMAwIPuoMo3tBec0E8FTQ7satJwC+O3AYNPRiqohti7KNuWy2w4r47UQOsAaf3XHuTp8upLrnj/9fv4mCm4QoGWw8QbsjtPzFqnE79d6FFdgO8e8X5aACI5z1Dy2ZUAlCmBrrXAzFpB4drc1sIMEr9XF/FZ8=
X-Microsoft-Antispam-PRVS: <DM3PR07MB213998BFFF7BA7F4D3685C589AD50@DM3PR07MB2139.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:DM3PR07MB2139;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2139;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;4:7TWG0zhIBP2Y5Y/qH7JTUfjbb+rFQQMtxmC4kd9OCVx3WGnsdqHkyWYMyk1JEJiuKERu+0FXhxrFv0G02tC9quniGLhJRBUZQbdFASpFmMw2LYH5X/lR1YfjCUsrjsK1VPE4ve3fWuz3vmxm/vYBAiCGagil5Ny+tAcFgn4Xn1TClm+vwtGX0ZgPzJHY9/YJsg2XCwMT9XRdpVkO1JKzxtt2qQyjWQu6fLt1Wgebz8p4FySsvr8ppNR2StzL7tLMuwpll4TxPf9RQltHmvNXYUh7I7EVELHoyZrW5DbYcqB8bipxhmCZEZt8mBqg7aMjRENToOGyg+bEl4enWdugcKK98wOw3jesjxWE5gVBq4SAOC20FDCznCYnyy9Ge0Ps
X-Forefront-PRVS: 084674B2CF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(377454003)(479174004)(65806001)(5001960100002)(65956001)(83506001)(110136002)(66066001)(5004730100002)(80316001)(19580405001)(47776003)(19580395003)(92566002)(189998001)(33656002)(50466002)(87976001)(4001350100001)(230700001)(2906002)(50986999)(586003)(87266999)(77096005)(54356999)(23756003)(65816999)(76176999)(3846002)(36756003)(42186005)(122386002)(64126003)(1096002)(53416004)(5008740100001)(40100003)(2950100001)(6116002)(4326007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2139;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DM3PR07MB2139;23:gAh+TSifn0UzvUbrABfldi7HrkDD2S0pne//6LC?=
 =?iso-8859-1?Q?EYKhTUY1/0WDAojLl3oe9YZbv64CjW4JKzmwSQEypMXysNAndH5LigiXKp?=
 =?iso-8859-1?Q?TvEZHHIyZfp+hA7fgYa6UscES9X6FAFxdlRR7kp4fa7PSWU6roPMMTmRNJ?=
 =?iso-8859-1?Q?odTd7BNhxRX2rzc+P9X4Nx9RrLYdxEuhYAk4YETXUXNSEVxm0x2uwwQzpQ?=
 =?iso-8859-1?Q?aT+6rSnUdLFWM+oHLgx/OG1UqTB/wQojng2a7ovNCCVGS91clyJ005GmwG?=
 =?iso-8859-1?Q?bZ5VmV/fOkurq6pLLfZd7sR6UjQPbDAOUj81kQrgNwJQ/wwKe8+Y/0ERe7?=
 =?iso-8859-1?Q?B78EqYv7TUugeABFFeL9xSDUS+1gzrOurTB6RNXh5m33Q9T8qD9QVOan7s?=
 =?iso-8859-1?Q?Xk/7KmRtOFqDyuINC9jeqRqyfAZoHdIFFP3vy0ZCmezq+6r8DpMD3g0Ro8?=
 =?iso-8859-1?Q?zVFHrRgqmfveLFu2DbjMPBaGnpufjqC2BrbnGCVpMeoyO0NfnlzyDC1DNV?=
 =?iso-8859-1?Q?5UsXo/WjnqnqZTP5ctfG22Jx7z1e9jXgJE//fbPfxHRB5iHt6ltc15uyOG?=
 =?iso-8859-1?Q?VaIuMMWtUYQRx0qghEuXCGoQNDrl21m3Z2K9B+2g8zn7NXmk2ERnyhD6iG?=
 =?iso-8859-1?Q?1UeT7NOEX3GG3JNOW5vGZGAUmLCE1HouI4PEgCHwe2QL+xyc4q97viCNIG?=
 =?iso-8859-1?Q?EMauvHSECG3blXj5cgqpA8dalQzbr9sI/sK+QarIVfWakyKzM+Dt1v4AxM?=
 =?iso-8859-1?Q?8Td13eHe9rIvYYXcT6fwjVB9uMRITxF5Yc7YKyCW1Qm/1oDMU+/m4V6dnm?=
 =?iso-8859-1?Q?sPzs4OEOsT46PjiWhkBDDPZTr/qhsTaE6/U50EJTagqWOBbiesynuO900y?=
 =?iso-8859-1?Q?HTE9YDJusSjfCpuKC6jFUabdfcSreCv1To9f2zcxWzV1ZfCFeZOdH9y/N7?=
 =?iso-8859-1?Q?+Uyvw8G4xHhqVlgdVONpfoGfPi/mhXKCvjnTBFx1Bd4JKKEVTwxG5BGkR3?=
 =?iso-8859-1?Q?PokmH1W2oxv021GZIsPrmTx+oiTA2IbN3De/956FUmSXQgjHyo4T4M11Uk?=
 =?iso-8859-1?Q?tuopP5KpUiZRb7VjqYKRLug5JYGpw9E9fXJCJBJgl91bt+3A2CxVrE/gyn?=
 =?iso-8859-1?Q?GS8jV77Eyr1NYpHyD06LBQgI5o8x28dPefsUq0BWj5OBNHM+GPK8WoUhch?=
 =?iso-8859-1?Q?xi3rGr03+t9?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;5:hSeZx+BQfPwilgJBAn9dhxlvkN3ITlJ//QR6Af2D6qjxYfFa3aTck+XPsfxM1m/ra2NzAnNnYzdJpbG4Nvc5ZTKLXIS51RHFgbVaRzPh8BGlOdge+h9nIJXNqJd/I4PySZswVxifv0Mop/Vs8fRniQ==;24:UwEZY3mw8fHQ3tf4yTei7oMw6psv4yWdHZjr2EhEY/PJAT+/u4/03qZNS0wYgBOrIN3YXp0Mw6Jqgw8ww4i0x0H9ayWUcguU3ou6h1pB7JE=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2016 18:11:37.7367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2139
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51861
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

On 02/08/2016 10:05 AM, Harvey Hunt wrote:
> STACK_TOP_MAX is aligned on a 32k boundary. When __bprm_mm_init() creates an
> initial stack for a process, it does so using STACK_TOP_MAX as the end of the
> vma. A process's arguments and environment information are placed on the stack
> and then the stack is relocated and aligned on a page boundary. When using a 32
> bit kernel with 64k pages, the relocated stack has the process's args
> erroneously stored in the middle of the stack. This means that processes
> receive no arguments or environment variables, preventing them from running
> correctly.
>
> Fix this by aligning TASK_SIZE on a page boundary.
>
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/mips/include/asm/processor.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index 3f832c3..b618b40 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -39,13 +39,13 @@ extern unsigned int vced_count, vcei_count;
>   #ifdef CONFIG_32BIT
>   #ifdef CONFIG_KVM_GUEST
>   /* User space process size is limited to 1GB in KVM Guest Mode */
> -#define TASK_SIZE	0x3fff8000UL
> +#define TASK_SIZE	(0x40000000UL - PAGE_SIZE)
>   #else
>   /*
>    * User space process size: 2GB. This is hardcoded into a few places,
>    * so don't change it unless you know what you are doing.
>    */
> -#define TASK_SIZE	0x7fff8000UL
> +#define TASK_SIZE	(0x7fff8000UL & PAGE_SIZE)

Can you check your math here.  This doesn't seem correct.

>   #endif
>
>   #define STACK_TOP_MAX	TASK_SIZE
> @@ -62,7 +62,7 @@ extern unsigned int vced_count, vcei_count;
>    * support 16TB; the architectural reserve for future expansion is
>    * 8192EB ...
>    */
> -#define TASK_SIZE32	0x7fff8000UL
> +#define TASK_SIZE32	(0x7fff8000UL & PAGE_SIZE)

Same here.

>   #define TASK_SIZE64	0x10000000000UL
>   #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
>   #define STACK_TOP_MAX	TASK_SIZE64
>
