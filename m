Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 20:50:57 +0200 (CEST)
Received: from mail-cys01nam02on0113.outbound.protection.outlook.com ([104.47.37.113]:54937
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993047AbeG3SuwxPyQH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2018 20:50:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIbiyJkRKsonZ/Ns/LFMbhSBiQlHPXH45N4iSy4PLTU=;
 b=e8SUBTcApD2T9F3un76P0Q/Qj7dezO4JXx1nbli9IoXCxSD3s2lVkFrz81+QqcGkFn2yf6IDgwCljfbrTsdt7fFR1jaV+kf0NYb2sBiPKG2oSwzjJ2bfhWiAoAFUlkcY42SMNM0IQ8Ss/iJxjQFCPUtpe2CppNEntEI+hyBXQk4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from [10.20.2.221] (4.16.204.77) by
 CY1PR0801MB2155.namprd08.prod.outlook.com (2a01:111:e400:c611::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Mon, 30 Jul
 2018 18:50:41 +0000
Message-ID: <5B5F5DFE.9090702@wavecomp.com>
Date:   Mon, 30 Jul 2018 11:50:38 -0700
From:   Dengcheng Zhu <dzhu@wavecomp.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@mips.com>
CC:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v3 1/6] MIPS: Make play_dead() work for kexec
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com> <1532357299-8063-2-git-send-email-dzhu@wavecomp.com> <20180724232355.z6j2wvs6srigr7kx@pburton-laptop>
In-Reply-To: <20180724232355.z6j2wvs6srigr7kx@pburton-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:5:80::49) To CY1PR0801MB2155.namprd08.prod.outlook.com
 (2a01:111:e400:c611::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa1b0a73-03d2-46e8-a48c-08d5f64d59a6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2155;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;3:Locvokz9nt7f2QaYYzN5hlBC0mSYZSfgxhMtky8b/gp4XfNB+EfZUDbzSw70N2XJZZL4dNxAFrA1ZiDh7hOzUR8QLo00FDrLFjUbE2cRa8rD8eZQnxmiIfC7W0NjGH2kCS3MIimv3jOb0KmzFRSdvIUI6w6e9i3XROkMAwvU9zUbI2aRiX+nxmNgVg8S0pV3YYczGBdd0gf+Y+vrNiHKhJwfZQvlP2knMngusuwBT+IlZQ39bd6X2DbOaubxhJvt;25:Z6OoXLg/IH9KdYM7AnEwp9iz811elUOU2lEZetWaJA4AwN6byx6dXYdabTUyOLLsf1oFEi9CoTm8WmMirVb2V5X3eSUHJJrOtWL8hDq7Y8AvWyEWOLIlUWW5CZWltaohIjhFRwGN24+hmeMTkSJn120nnfQgvKkUeWriuOQfktJjfyPiFhAceqVsI3gZbqbB5gJ1oAlXtXjS9pWRtS8F4XqDJcNuNaqH/kXptjIjHVGYnU3fdYZ1ziYdMY1ZQc/8Qr5kVbnYHardiXfegpy6uRVINGccNeSZ7LfkfGoaF956H0uvVA++fFqz5hgIBEF0c1nnFyerlNDJHkn+E4qyXQ==;31:T+EQFs7UNJZB0rHLnOcT+rySH8HIQYkF2gJSPtnJBjGUSlHnB21Jdfx/7d2lUUt0GxPXtNAzCg3QtZH0lqlxPTgSZBIdnxtZG76mSSbfZfd4XWI9q78Q7B+/lBO4fHrseZ2lQJlJq9V6iOIiGDHE6I/I/Fn9nskTfskYz9axQfcXpcSUYQ/PfOZvQehkkoQdR+mbETw6SNCP/IahZblbcA4SITofO1QPte4SBlCU11g=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2155:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;20:+Q0Ty2z1seqyuT5cZ5GyLr17ytj3rRy9/vHzyjGDSqNzHqf/E1h+Jz0C4r7qdG7Q9fGytGfmmwcKTkE2HumbMbkigBtMFrqtNhOKXlAqHJ6YmXQypEPXuwUOk6vj6pZnm/Tdfy/bd9HpFf5V1fDQvlmeKqSpFearNeO+rLjo9SVISg1oPs0q9B5ORBGc+7bMnnZ4Gez4kFyvFqN2bmnIxoh/QOR3DW+yX/wNGN8Hhsp2C7+gn5M4p3aV0Xtamx1k;4:AbwqdsXO/k1eBRzLm4vB5qUgfhEBnWAZjvwwcYkBMLXf/aTbalr8d6sb2pfCOC4DniYpfQVDoAqBBUWRz4PTGn65vC+d0JInHHR1WRHVpLVbDfu3hskwfvD0/X+M0KCGHlshw59V6ao4z88X2IWTzBlYfYQmLoqB/N1bFL1mPyCOV20+O2vrBgJuu0tODOm8MDKaGMdNz5SECONlmbS12ZYk+2gmcMERsRMoD468hchjAT0B+Ot2oQiQm8M2kIZfRZBlMuu7Bp3ifr/jqZaSJc4cfdjzOX3rkMJA5cPr4nAM/ESCI8d6ly/1t4TIO7km
X-Microsoft-Antispam-PRVS: <CY1PR0801MB2155B1C2A5190443A1ABF37CA22F0@CY1PR0801MB2155.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR0801MB2155;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2155;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(136003)(396003)(39840400004)(189003)(199004)(305945005)(2906002)(58126008)(230700001)(7736002)(476003)(2616005)(956004)(8676002)(50466002)(81166006)(59896002)(81156014)(8936002)(33656002)(16576012)(36756003)(68736007)(316002)(446003)(80316001)(11346002)(106356001)(5660300001)(486006)(52116002)(87266011)(76176011)(65816011)(6246003)(6862004)(64126003)(53546011)(25786009)(4326008)(86362001)(575784001)(229853002)(478600001)(47776003)(16526019)(65806001)(6116002)(65956001)(3846002)(386003)(66066001)(26005)(77096007)(97736004)(67846002)(6486002)(105586002)(53936002)(6666003)(23756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2155;H:[10.20.2.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;CY1PR0801MB2155;23:l7eaD+oKnBzmlUDUDNYweZWB3620ThsYwe79a?=
 =?iso-8859-1?Q?F+uoPvqPsbKGCg9TAycm4lMNYUbR0KgmJKoMWWD7peGY2rGMbn1HBaJtIK?=
 =?iso-8859-1?Q?GOFBHdefNd3y1wThNhM1O7V1aneaBxCn36InvlUULMsxlEdyEigKhD0VOd?=
 =?iso-8859-1?Q?8KyKdw5TbpuG4FeHRMekBJ3vFujjMjHWQiZUsLVG3b9d/pdNbL2/BJwpVN?=
 =?iso-8859-1?Q?ZFbkrHJ3Q0DddCn5E6CJ/3cex3z/e0D30fzEqmxoQuEhO2SXB3Yuy969l6?=
 =?iso-8859-1?Q?bjsTPBJci7/ckp3UyWPMJl3GZHCyeUh6jYBfwZy35delhdXbE90BTvTO/l?=
 =?iso-8859-1?Q?n10J8Are9rtVpHzHlZGay4wXcCfLUa5LIR+Y31dufv5+MEMym3WFXsXXIV?=
 =?iso-8859-1?Q?5WNskVSlWzoEvaN/pG9nC5el6ctXMB4g2ox8C6TAkjmEijFDjUQO9qTQz4?=
 =?iso-8859-1?Q?oX7O05WSHUiyb/dTuiTjvTsdEzgbWfzriqxOfzhuRfSyYg5P9qsu53wl7C?=
 =?iso-8859-1?Q?x8Gg5JVvDpSscwvBpAQm60SFLI86hMTtjhSIBqwwHxIOtP66md4H+7mUx8?=
 =?iso-8859-1?Q?G/eYAtCLBW+W30R+q14fswwEQkQwV5tqnM6gF1zdXX+IOdnIef2xOnKuuK?=
 =?iso-8859-1?Q?uYsqa4OoKyTV8k+D9nbbMlmE3bBp4NhhBtSGrUrEYdBLmuMdyidUdmD2wm?=
 =?iso-8859-1?Q?WdMXIryeHFuhS6iM7D9AIkdmSOVJsDwzw1cMBMZlPPRO4wzP7DlOKB1/TG?=
 =?iso-8859-1?Q?kztcbWmTTyvXa8bR8mmc0FH9UFPL5MewDI6LEIRMgRQ+aovI+gtwPJL2iP?=
 =?iso-8859-1?Q?BulJjVBD6+3c/qLIR3/Pb4I0pMpyOR1zOtkyd5I/+19uedlE1NSU9aQSQU?=
 =?iso-8859-1?Q?UZcPWzmiIlK6MEbZwwxu3SoIKkOI+r8axYtULXNnslWS02590YykF0iR/Q?=
 =?iso-8859-1?Q?Ii2ss/eeWZ1KB8BUVv5zhGASi07bPbBAEsI/y6YeuCZ93Nt3yt7EWZ//Hp?=
 =?iso-8859-1?Q?tIw4cOp+vNM6C7GqMMljNIwFTO0466Wrh8hZlogcg5aZoZyLf60F53ITzh?=
 =?iso-8859-1?Q?pQ63qUzI1rlzSK53Ph0mAjN69Uxs5FrUyNqd7PS+TJBhKa3DQB9Zefu9y/?=
 =?iso-8859-1?Q?8MhKIGqKZ9bopv3ONMFLADrmzpoy99ha5fjOrAwEGF4RNcI2UJMa858+02?=
 =?iso-8859-1?Q?kzMP8wAMPy5TdYeavUQxg2Td6QDGvxO+1yt/3IvGL/ehw5v2TnWnLQiFdG?=
 =?iso-8859-1?Q?oPZDwGUqZzNGQtzmPrq+3Nabs+9RGB2C6T1EnWppUNdRt0SJxcMPcVicdd?=
 =?iso-8859-1?Q?YH7WLIwo0AkyCOkccTQjdpyiC0fh3jlkK7S8HvSixMZTOlDFCzb6vF75T0?=
 =?iso-8859-1?Q?GosGVZV4gYf0QVfE5Uxnu6Tg27jtluuBktJLyhl4nYFgjDvdZcEgYPAvjd?=
 =?iso-8859-1?Q?YQvHBY7jUWqCb7e3qHvO3/35utRvBHtBwbQthzQ4b+T7gvFpZ4v95x4gyn?=
 =?iso-8859-1?Q?Qa58KxFA91X0GDXl4gBDBM=3D?=
X-Microsoft-Antispam-Message-Info: zv1yEWZz3xPpejMvy9HYwRyDBUujtN2meIxtOcoVlz00qbRw8SSeqpY9KoY5EIWEXvgJJySZTBos+OKPcnMz1xI4Oo4R2Qf++8UqImH2hGaCqvGVUQpLQMpriBreDeZyoNnMwd5Dd0XiYAazpmDv45m2R5tm3/4wrpKOASxYElYaJOGQLGl5fjJD9It+cppz3GYf5lcltf9ZIdzuN+UUixVDOGKFmB0OgjodXZu7rWRSBj+ySRLUbvfJ9L2CxxfgOafFV5OhUxUPlFDXFihqQmAzuxaW6dpfs3hrtXfjO3UPss08drjUj7FsKlMqwATN5UbSod0F/e8HHB9AIfq9Mo9lyWIudH7L/lmnJ0zxPQ8=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;6:1Fdx+4rPoSAbtQHtuJVFM405DWksOgl6Z5ILapyOiw/+tfvrLAOpdc3A9AoGYEHRs1jVFcwl39h3tF0ViZh9f6euORJIWA0VJvL0K7R8dM39EzIvzy6srFWRCZFt8BlgOVp6EFfZ15TqZj3tQsH7uYW/o32CaT0ld6WnLVn5XjhCDCSN6bGcavrR6DtdjhQu4s5u5otteZFiSd2oTsoe8XIc0yJJOTmdtgcnHkL6dMJ5fIbL/Su+igfMAqDZuzAP2D8eJg6NHXZUwLI1FVNb4aKPpcd9jYwm/+MVlMqGfOonxqD4IK+XzOzQGCKGuXqjiQG5fjAOb39v9JJvNUAVlZCdrnrHTnxibStx2OxUFU9yl9rFYUVPv9BTWvUYF86wr4oDB6Vtimnhjmk1MpcvUgv7K91t7T1Sif7RBxW6+AYeN2HpAawhGajb0mLsAA0qC5NpyNgIPuRIQrS7WFWa/g==;5:OfHmsi1lNxVx394B7RbkvuGiYnwzHW5D2XnVpskvlZTDT0dTCwXW9tBvki+qwqxfBKDTfBoNcbwafaVahrYfv97vwr4D5cZLTc9btVKvetBcRIO+2/xROC95f8Ck5tivdNR+BxVgHxOHRksEojl7tJpSGKzyZwOBtj5KF5mblaw=;7:y4aHzFIeKL036RPoqvUmDBAc1dSwQuH8TObzG4RITxiY9z+jqGjR4uw9Sdg/oGMt05j8M1FoKw/HO6Zh9Nn4nhqkTiQcMt1OfjguFc6tts0j3xyYBoSun8zQcncmMWPFjaOssJLc8EPe8RYfOLDFtRZlcwzyModCt+NpLBuwLjg34ybLX4sW684i8jvK/TbxuqjuhICrMzrNKktV1AbEmPeQk97Z1uH0t9iM+nOvUTi1Q48sJ5/TN7CR5km6vSgD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 18:50:41.5426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1b0a73-03d2-46e8-a48c-08d5f64d59a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2155
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

Hi Paul,


Thanks for reviewing. Please see my comments below.


On 07/24/2018 04:23 PM, Paul Burton wrote:
> Hi Dengcheng,
>
> On Mon, Jul 23, 2018 at 07:48:14AM -0700, Dengcheng Zhu wrote:
>> Extract play_dead() from CONFIG_HOTPLUG_CPU and share with CONFIG_KEXEC.
>> Also, add one parameter to it to avoid doing unnecessary things in the case
>> of kexec.
> I'd prefer that we use a separate function to play_dead() for this, for
> example we could provide an implementation of crash_smp_send_stop() much
> like ARM's which invokes a machine_crash_nonpanic_core() function on all
> CPUs other than the crash CPU.

ARM's crash_smp_send_stop() that calls machine_crash_nonpanic_core() is called
in machine_crash_shutdown(), not in machine_kexec(). It's similar in the MIPS
case - default_machine_crash_shutdown().

>
> This would prevent the kexec/kdump functionality from depending on the
> board/platform specific play_dead(), and wouldn't need these changes to
> all of the implementations of play_dead().

The revised play_dead() is JUST to make sure we are turning off CPUs cleanly.
This function itself already hides board/platform details. So it seems a good
candidate for turning off CPUs for the target platform.

This function is called only in the newly created kexec_smp_reboot(), before
which cpu states have been saved.

>
> We should also be calling crash_save_cpu() on each CPU, which is a
> further difference from play_dead().

crash_save_cpu() is already called in machine_crash_shutdown(), which is
prior to machine_kexec().

>
>> This is needed to correctly support SMP new kernel in kexec. Before doing
>> this, all non-crashing CPUs are waiting for the reboot signal
>> (kexec_ready_to_reboot) to jump to kexec_start_address in kexec_smp_wait(),
>> which creates some problems like incorrect CPU topology upon booting from
>> new UP kernel,
> Do you know how that happens? I'd expect detecting topology not to
> depend upon what state CPUs are in. That should certainly be the case
> for smp-cps/CONFIG_MIPS_CPS which detects topology just by reading
> CM/CPC/GIC registers.

I didn't debug the topology issue. But it's related to the attempt of *all*
CPUs using the same code from kexec_start_address, thinking they are
dominating the system.

The cleanest way IMO is simple and what this patch is trying to do - turn off
CPUs and do a fresh SMP boot from c0v0.


>
>> sluggish performance in MT environment during and after reboot,
> The function running on non-crash CPUs would just need to execute a loop
> of wait instructions to avoid this.

Same as the topology problem, I didn't look into this performance issue. But
I did try using 'wait' on non-crash CPUs - it didn't work well. In the clean
way, this problem disappears as expected.

>
>> new SMP kernel not able to bring up secondary CPU etc.
> If the SMP implementation can reset CPUs then that ought not to happen,
> since no matter what the CPU was doing Linux should be able to cause it
> to reset & run some known piece of code. I'm not sure the current Octeon
> SMP code can do that, but there are patches in patchwork that look like
> they might (& patches to remove Octeon's current kexec/kdump code which
> suggests nobody cares much about it).
>
> I'd suggest we could perhaps add a boolean to struct plat_smp_ops to
> indicate whether kexec is supported, and start by setting it to true for
> cps_smp_ops. Then we can have machine_kexec_prepare() return an error if
> it finds !mp_ops->kexec_supported, and deal with enabling kexec per
> platform. I think this would be better than Kconfig because there are
> systems where we may use one of multiple SMP implementations - for
> example Malta might use smp-cps (which would be OK for kexec) or smp-cmp
> (which wouldn't). If we get to a point where all our SMP implementations
> can deal with kexec we could remove the field later.

This problem is also related to the original kexec boot mechanism. No
matter what SMP implementation it is, it should be good if we correctly turn
off CPUs and reboot the (SMP) system from the 1st CPU in its own
implementation.


Regards,

Dengcheng

---------------------------------------------------------------------------

*From:* Paul Burton <mailto:paul.burton@mips.com>
*Sent:* Tuesday, July 24, 2018 4:23PM
*To:* Dengcheng Zhu <mailto:dzhu@wavecomp.com>
*Cc:* Pburton <mailto:pburton@wavecomp.com>, Ralf 
<mailto:ralf@linux-mips.org>, Linux-mips 
<mailto:linux-mips@linux-mips.org>, Rachel.mozes 
<mailto:rachel.mozes@intel.com>
*Subject:* Re: [PATCH v3 1/6] MIPS: Make play_dead() work for kexec

Hi Dengcheng,

On Mon, Jul 23, 2018 at 07:48:14AM -0700, Dengcheng Zhu wrote:

> Extract play_dead() from CONFIG_HOTPLUG_CPU and share with CONFIG_KEXEC.
> Also, add one parameter to it to avoid doing unnecessary things in the case
> of kexec.

I'd prefer that we use a separate function to play_dead() for this, for
example we could provide an implementation of crash_smp_send_stop() much
like ARM's which invokes a machine_crash_nonpanic_core() function on all
CPUs other than the crash CPU.

This would prevent the kexec/kdump functionality from depending on the
board/platform specific play_dead(), and wouldn't need these changes to
all of the implementations of play_dead().

We should also be calling crash_save_cpu() on each CPU, which is a
further difference from play_dead().

> This is needed to correctly support SMP new kernel in kexec. Before doing
> this, all non-crashing CPUs are waiting for the reboot signal
> (kexec_ready_to_reboot) to jump to kexec_start_address in kexec_smp_wait(),
> which creates some problems like incorrect CPU topology upon booting from
> new UP kernel,

Do you know how that happens? I'd expect detecting topology not to
depend upon what state CPUs are in. That should certainly be the case
for smp-cps/CONFIG_MIPS_CPS which detects topology just by reading
CM/CPC/GIC registers.

> sluggish performance in MT environment during and after reboot,

The function running on non-crash CPUs would just need to execute a loop
of wait instructions to avoid this.

> new SMP kernel not able to bring up secondary CPU etc.

If the SMP implementation can reset CPUs then that ought not to happen,
since no matter what the CPU was doing Linux should be able to cause it
to reset & run some known piece of code. I'm not sure the current Octeon
SMP code can do that, but there are patches in patchwork that look like
they might (& patches to remove Octeon's current kexec/kdump code which
suggests nobody cares much about it).

I'd suggest we could perhaps add a boolean to struct plat_smp_ops to
indicate whether kexec is supported, and start by setting it to true for
cps_smp_ops. Then we can have machine_kexec_prepare() return an error if
it finds !mp_ops->kexec_supported, and deal with enabling kexec per
platform. I think this would be better than Kconfig because there are
systems where we may use one of multiple SMP implementations - for
example Malta might use smp-cps (which would be OK for kexec) or smp-cmp
(which wouldn't). If we get to a point where all our SMP implementations
can deal with kexec we could remove the field later.

Thanks,
     Paul
