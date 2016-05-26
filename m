Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2016 18:25:46 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:60160 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27034750AbcEZQZnvmoDv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 May 2016 18:25:43 +0200
Received: from [IPv6:2003:8b:2f1e:e900:9009:e230:4ffa:6e53] (p2003008B2F1EE9009009E2304FFA6E53.dip0.t-ipconnect.de [IPv6:2003:8b:2f1e:e900:9009:e230:4ffa:6e53])
        by hauke-m.de (Postfix) with ESMTPSA id D3976100052;
        Thu, 26 May 2016 18:25:42 +0200 (CEST)
Subject: Re: [RFC PATCH] Re: Adding support for device tree and command line
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
References: <574372CD.1060201@hauke-m.de> <5743777F.9060801@hauke-m.de>
 <1464041521.5475.18.camel@chimera> <1464067930.27173.7.camel@chimera>
Cc:     linux-mips@linux-mips.org, Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <57472386.8030605@hauke-m.de>
Date:   Thu, 26 May 2016 18:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.6.0
MIME-Version: 1.0
In-Reply-To: <1464067930.27173.7.camel@chimera>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 05/24/2016 07:32 AM, Daniel Gimpelevich wrote:
> From 464df9cb918d46fcbe5552b46b2fe7f916fdd0b4 Mon Sep 17 00:00:00 2001
> From: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
> Date: Mon, 23 May 2016 22:19:42 -0700
> Subject: [RFC PATCH] Re: Adding support for device tree and command line
> 
> On Mon, 2016-05-23 at 15:12 -0700, Daniel Gimpelevich wrote:
>> On Mon, 2016-05-23 at 23:34 +0200, Hauke Mehrtens wrote:
>>> On 05/23/2016 11:14 PM, Hauke Mehrtens wrote:
>>>> Section 3 of this document defines some interfaces how a boot loader
>>>> could forward a command line *or* a device tree to the kernel:
>>>> http://wiki.prplfoundation.org/w/images/4/42/UHI_Reference_Manual.pdf
>>>> This allows only a device tree *or* a command line, not both.
>>>>
>>>> The Linux kernel also supports an appended device tree. In this case the
>>>> early code overwrites the fw_args to look like the boot loader added a
>>>> device tree. This is done when CONFIG_MIPS_RAW_APPENDED_DTB is activated.
>>>>
>>>> The problem is when we use an appended device tree and the boot loader
>>>> adds some important information in the kernel command line. In this case
>>>> the command line gets overwritten and we do not get this information.
>>>> This is the case for some lantiq devices were the boot loader provides
>>>> the mac address to the kernel via the kernel command line.
>>>>
>>>> My proposal to solve this problem is to extend the interface and add a
>>>> option to provide the kernel command line *and* a device tree from the
>>>> boot loader to the kernel.
>>>>
>>>> a) use fw_arg0 ($a0) = -2 and fill the unused registers fw_arg2 ($a2)
>>>> and fw_arg3 ($a3) with argv and envp.
>>>>
>>>> b) add a new boot protocol $a0 = -3 with $a1 = DT address, $a2 = argv
>>>> and $a3 = envp.
>>>
>>> I just looked a little bit more closely and saw that the command line
>>> uses 3 args. One for the count, one argv and one envp.
>>>
>>> I would then only support device tree + count and argv, so the new
>>> interface would not support envp.
>>>
>>>>
>>>> I would prefer solution b).
>>>>
>>>> This way we would not loose the kernel command line when appending a
>>>> device tree and this could also be used by the boot loader if someone
>>>> wants to.
>>>>
>>>> Should I send a patch for this?
>>>>
>>>> Hauke
>>
>> It was because I looked through the above-linked UHI spec that I became
>> concerned about CONFIG_MIPS_RAW_APPENDED_DTB only mimicking, rather than
>> fully implementing, real UHI. In the upstream kernel, the new $a0 == -2
>> code can be a starting point for adding UHI argv/envp parsing for when a
>> UHI-compliant bootloader is used. However, on the head.S side, what I
>> propose for the lantiq target is to remove CONFIG_MIPS_RAW_APPENDED_DTB
>> from the kernel config, and reintroduce this as a platform patch:
>> https://github.com/openwrt/openwrt/blob/b3158f781f24ac2ec1c0da86479bfc156c52c80b/target/linux/lantiq/patches-4.4/0036-owrt-generic-dtb-image-hack.patch
>> The brcm63xx target could then retain CONFIG_MIPS_RAW_APPENDED_DTB, or
>> not, depending on bootloader specifics there, which I have not
>> investigated, and likewise the various other targets to which
>> CONFIG_MIPS_RAW_APPENDED_DTB has since been extended even though it was
>> apparently initially only an expedient hack only for brcm63xx.
>>
>> Using $a0 = -3 is expressly prohibited in the above UHI document, and
>> using $a2/$a3 "would risk becoming incompatible with existing UHI
>> compliant implementations."
> 
> I have come up with a more elegant solution: Simply move the register
> substitution from head.S to just before it matters. You can still
> override the boot args using CONFIG_MIPS_CMDLINE_FROM_DTB.
> 
> Signed-off-by: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
> ---
>  arch/mips/bmips/setup.c          |  7 +++++++
>  arch/mips/boot/compressed/head.S | 16 ----------------
>  arch/mips/include/asm/prom.h     |  5 +++++
>  arch/mips/kernel/head.S          | 16 ----------------
>  arch/mips/lantiq/prom.c          |  7 +++++++
>  5 files changed, 19 insertions(+), 32 deletions(-)

I like it in the ARM arch code that the SoC specific code does not have
to take care of this stuff. The normal arch code provides the device
tree and so on.

Can we at least add a function to mips which will read the device tree
and the kernel cmd, so I do not have to open code it for each SoC, but
only call this function.

Hauke
