Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 23:12:19 +0100 (CET)
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:13647
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6819678AbaCSWMQkMM4N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Mar 2014 23:12:16 +0100
Received: from BY2PRD0711HT002.namprd07.prod.outlook.com (10.255.88.165) by
 CO2PR0701MB792.namprd07.prod.outlook.com (10.141.246.22) with Microsoft SMTP
 Server (TLS) id 15.0.893.10; Wed, 19 Mar 2014 22:12:08 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.88.165) with Microsoft SMTP Server (TLS) id 14.16.423.0; Wed, 19 Mar
 2014 22:12:07 +0000
Message-ID: <532A1637.5080803@caviumnetworks.com>
Date:   Wed, 19 Mar 2014 15:12:07 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <ralf@linux-mips.org>
CC:     "Yang,Wei" <Wei.Yang@windriver.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: octeon: Fix warning in of_device_alloc on cn3xxx
References: <1395118084-24018-1-git-send-email-Wei.Yang@windriver.com> <532968AD.4010402@windriver.com> <20140319162008.GA4368@alberich> <5329E343.60309@caviumnetworks.com> <20140319220330.GC4368@alberich>
In-Reply-To: <20140319220330.GC4368@alberich>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 01559F388D
X-Forefront-Antispam-Report: =?utf-8?B?U0ZWOk5TUE07U0ZTOigxMDAxOTAwMSkoNjAwOTAwMSkoNDI4MDAxKSgyNDQ1?=
 =?utf-8?B?NDAwMikoNDc5MTc0MDAzKSgzNzc0NTQwMDMpKDUxNzA0MDA1KSgxNjQwNTQw?=
 =?utf-8?B?MDMpKDE4OTAwMikoMTk5MDAyKSg3Njc5NjAwMSkoOTM1MTYwMDIpKDg1MzA2?=
 =?utf-8?B?MDAyKSg5NDk0NjAwMSkoOTMxMzYwMDEpKDU5ODk2MDAxKSg1OTc2NjAwMSko?=
 =?utf-8?B?Nzc5ODIwMDEpKDM2NzU2MDAzKSg2MzY5NjAwMikoNDM5NjAwMSkoNzkxMDIw?=
 =?utf-8?B?MDEpKDY0MTI2MDAzKSgxNTk3NTQ0NTAwNikoNDk4NjYwMDEpKDU3NTc4NDAw?=
 =?utf-8?B?MSkoMjM2NzYwMDIpKDgxODE2MDAxKSg5NTQxNjAwMSkoOTI3MjYwMDEpKDY1?=
 =?utf-8?B?ODA2MDAxKSg4MDAyMjAwMSkoNzcwOTYwMDEpKDY1OTU2MDAxKSg0Nzc3NjAw?=
 =?utf-8?B?MykoNDc5NzYwMDEpKDQ3NzM2MDAxKSg2NjA2NjAwMSkoNTA5ODYwMDEpKDU0?=
 =?utf-8?B?MzU2MDAxKSg3NjQ4MjAwMSkoMTUyMDIzNDUwMDMpKDk3MzM2MDAxKSg1MzQx?=
 =?utf-8?B?NjAwMykoODM1MDYwMDEpKDc0ODc2MDAxKSg1Njc3NjAwMSkoMTUzOTU3MjUw?=
 =?utf-8?B?MDMpKDMzNjU2MDAxKSg3NDY2MjAwMSkoMzE5NjYwMDgpKDk3MTg2MDAxKSg0?=
 =?utf-8?B?NjEwMjAwMSkoOTU2NjYwMDMpKDc0NTAyMDAxKSg0NzQ0NjAwMikoNTM4MDYw?=
 =?utf-8?B?MDEpKDgxMzQyMDAxKSg4MTU0MjAwMSkoODA5NzYwMDEpKDE5NTgwMzk1MDAz?=
 =?utf-8?B?KSg4MzMyMjAwMSkoNTQzMTYwMDIpKDUxODU2MDAxKSg4MTY4NjAwMSkoMTk1?=
 =?utf-8?B?ODA0MDUwMDEpKDkyNTY2MDAxKSg4NzkzNjAwMSkoNjkyMjYwMDEpKDUwNDY2?=
 =?utf-8?B?MDAyKSg3NDcwNjAwMSkoNzQzNjYwMDEpKDg1ODUyMDAzKSg1NjgxNjAwNSko?=
 =?utf-8?B?ODMwNzIwMDIpKDkwMTQ2MDAxKSgzMjU2MzAwMSkoNjYwNjI5NTAwMik7RElS?=
 =?utf-8?B?Ok9VVDtTRlA6MTEwMjtTQ0w6MTtTUlZSOkNPMlBSMDcwMU1CNzkyO0g6Qlky?=
 =?utf-8?B?UFJEMDcxMUhUMDAyLm5hbXByZDA3LnByb2Qub3V0bG9vay5jb207Q0xJUDo2?=
 =?utf-8?B?NC4yLjMuMTk1O0ZQUjpFMjZDRjM0RC5FMDExOTQ4OS5DQ0MxRTJCNy45QUU4?=
 =?utf-8?B?NUFDQS4yMDQyMztNTFY6c2Z2O1BUUjpJbmZvTm9SZWNvcmRzO01YOjE7QTox?=
 =?utf-8?Q?;LANG:en;?=
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39513
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

On 03/19/2014 03:03 PM, Andreas Herrmann wrote:
>
> Starting with commit 3da5278727a895d49a601f67fd49dffa0b80f9a5 (of/irq:
> Rework of_irq_count()) the following warning is triggered on octeon
> cn3xxx:
>
> [    0.887281] WARNING: CPU: 0 PID: 1 at drivers/of/platform.c:171 of_device_alloc+0x228/0x230()
> [    0.895642] Modules linked in:
> [    0.898689] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.0-rc7-00012-g9ae51f2-dirty #41
> [    0.906860] Stack : c8b439581166d96e ffffffff816b0000 0000000040808000 ffffffff81185ddc
> [    0.906860] 	  0000000000000000 0000000000000000 0000000000000000 000000000000000b
> [    0.906860] 	  000000000000000a 000000000000000a 0000000000000000 0000000000000000
> [    0.906860] 	  ffffffff81740000 ffffffff81720000 ffffffff81615900 ffffffff816b0177
> [    0.906860] 	  ffffffff81727d10 800000041f868fb0 0000000000000001 0000000000000000
> [    0.906860] 	  0000000000000000 0000000000000038 0000000000000001 ffffffff81568484
> [    0.906860] 	  800000041f86faa8 ffffffff81145ddc 0000000000000000 ffffffff811873f4
> [    0.906860] 	  800000041f868b88 800000041f86f9c0 0000000000000000 ffffffff81569c9c
> [    0.906860] 	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.906860] 	  0000000000000000 ffffffff811205e0 0000000000000000 0000000000000000
> [    0.906860] 	  ...
> [    0.971695] Call Trace:
> [    0.974139] [<ffffffff811205e0>] show_stack+0x68/0x80
> [    0.979183] [<ffffffff81569c9c>] dump_stack+0x8c/0xe0
> [    0.984196] [<ffffffff81145efc>] warn_slowpath_common+0x84/0xb8
> [    0.990110] [<ffffffff81436888>] of_device_alloc+0x228/0x230
> [    0.995726] [<ffffffff814368d8>] of_platform_device_create_pdata+0x48/0xd0
> [    1.002593] [<ffffffff81436a94>] of_platform_bus_create+0x134/0x1e8
> [    1.008837] [<ffffffff81436af8>] of_platform_bus_create+0x198/0x1e8
> [    1.015064] [<ffffffff81436cc4>] of_platform_bus_probe+0xa4/0x100
> [    1.021149] [<ffffffff81100570>] do_one_initcall+0xd8/0x128
> [    1.026701] [<ffffffff816e2a10>] kernel_init_freeable+0x144/0x210
> [    1.032753] [<ffffffff81564bc4>] kernel_init+0x14/0x110
> [    1.037973] [<ffffffff8111bb44>] ret_from_kernel_thread+0x14/0x1c
>
> With this commit the kernel starts mapping the interrupts listed for
> gpio-controller node. irq_domain_ops for CIU (octeon_irq_ciu_map and
> octeon_irq_ciu_xlat) refuse to handle the GPIO lines (returning -EINVAL)
> and this is causing above warning in of_device_alloc().
>
> Modify irq_domain_ops for CIU and CIU2 to "gracefully handle" GPIO
> lines (neither return error code nor call octeon_irq_set_ciu_mapping
> for it). This should avoid the warning.
>
> (As before the real setup for GPIO lines will happen using
> irq_domain_ops of gpio-controller.)
>
> This patch is based on Wei's patch v2 (see
> http://marc.info/?l=linux-mips&m=139511814813247).
>
> Reported-by: Yang Wei <wei.yang@windriver.com>
> Cc: David Daney <david.daney@caviumnetworks.com>

Thanks Andreas and Yang Wei.

FWIW:

Tested and...

Acked-by: David Daney <david.daney@cavium.com>


Ralf et al.  If you are sending more patches for 3.14, this would be a 
good candidate.

Thanks,
David Daney

> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>   arch/mips/cavium-octeon/octeon-irq.c |   22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index 25fbfae..c2bb4f8 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
[...]
