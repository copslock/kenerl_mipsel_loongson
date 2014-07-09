Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 14:25:53 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:40540 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861103AbaGIMZuE9hZh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Jul 2014 14:25:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id BAF8F280893;
        Wed,  9 Jul 2014 14:23:43 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com [209.85.216.43])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 8CBB128162E;
        Wed,  9 Jul 2014 14:23:32 +0200 (CEST)
Received: by mail-qa0-f43.google.com with SMTP id k15so5958304qaq.16
        for <multiple recipients>; Wed, 09 Jul 2014 05:25:35 -0700 (PDT)
X-Received: by 10.224.98.145 with SMTP id q17mr68938982qan.97.1404908735244;
 Wed, 09 Jul 2014 05:25:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.209 with HTTP; Wed, 9 Jul 2014 05:25:15 -0700 (PDT)
In-Reply-To: <53BC15DA.7050602@imgtec.com>
References: <1404832446-31028-1-git-send-email-jogo@openwrt.org> <53BC15DA.7050602@imgtec.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 9 Jul 2014 14:25:15 +0200
Message-ID: <CAOiHx=mmLwD=eC5B8hhAowqZgV_rKw4cmHSGLRLjRKAwiyZ9KA@mail.gmail.com>
Subject: Re: [PATCH RFC] MIPS: add support for vmlinux appended DTB
To:     James Hogan <james.hogan@imgtec.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Tue, Jul 8, 2014 at 6:01 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Jonas,
>
> On 08/07/14 16:14, Jonas Gorski wrote:
>> Add support for populating initial_device_params through a dtb
>
> initial_boot_params here and above?

Yes, that's what I meant. I must have been distracted by the
thunderstorm outside.

>
>> blob appended to vmlinux.
>
> should that be vmlinux.bin? Presumably it isn't appended to the ELF file?

Hmmm, you are right, indeed it should. I was always taking the OpenWrt
names for granted, so I never looked at how the kernel itself named
them. OpenWrt uses "vmlinux" for binary only, and "vmlinux.elf" for
the unstripped elf one.

As far as I can tell, there is no simple vmlinux.bin target without
the decompressor wrapper included, but for the description I will
change the name and clarify that I am talking about a binary kernel
without the decompressing wrapper.

>
>>
>> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
>> ---
>> Mostly adapted from how ARM is doing it.
>>
>> Sent as an RFC PATCH because I am not sure if this is the right way to
>> it, and whether storing the pointer in initial_device_params is a good
>> idea, or a new variable should be introduced.
>>
>> The reasoning for initial_device_params is that there is no common
>> MIPS interface yet, so the next best thing was using that. This also
>> has the advantage of keeping the original fw_args intact.
>
> Does it matter that this will be ignored if the bootloader does provide
> a DT (initial_boot_params overwritten by early_init_dt_scan() call), and
> that if no DT is provided by the bootloader the of_scan_flat_dt() calls
> at the bottom of early_init_dt_scan will never happen?

Since (AFAIK) there is no common interface on mips for a bootloader to
pass a dtb to the kernel, it is currently up to the individual targets
to do something with an appended dtb, and decide which one has a
higher priority. They already need to manually "extract" the passed
dtb from the bootloader and pass it to the kernel, so all this patch
does is provide another source for one.


>>
>> This patch works for me on bcm63xx, where the bootloade expects
>
> s/bootloade/bootloader/
>
>> an lzma compressed kernel, so I wanted to not double compress using
>> the in-kernel compressed kernel support.
>>
>> Completely untested on anything except MIPS32 / big endian.
>>
>>  arch/mips/Kconfig              | 18 ++++++++++++++++++
>>  arch/mips/kernel/head.S        | 19 +++++++++++++++++++
>>  arch/mips/kernel/vmlinux.lds.S |  6 ++++++
>>  3 files changed, 43 insertions(+)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 3f05b56..58527cd 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -2476,6 +2476,24 @@ config USE_OF
>>       select OF_EARLY_FLATTREE
>>       select IRQ_DOMAIN
>>
>> +config MIPS_APPENDED_DTB
>> +     bool "Use appended device tree blob to vmlinux (EXPERIMENTAL)"
>> +     depends on OF
>> +     help
>> +       With this option, the boot code will look for a device tree binary
>> +       DTB) appended to vmlinux
>
> s/DTB)/(DTB)/
>
> vmlinux.bin again?

Right.

>> +       (e.g. cat vmlinux <filename>.dtb > vmlinux_w_dtb).
>
> here too I think.

Right again.

>> +
>> +       This is meant as a backward compatibility convenience for those
>> +       systems with a bootloader that can't be upgraded to accommodate
>> +       the documented boot protocol using a device tree.
>> +
>> +       Beware that there is very little in terms of protection against
>> +       this option being confused by leftover garbage in memory that might
>> +       look like a DTB header after a reboot if no actual DTB is appended
>> +       to vmlinux.  Do not leave this option active in a production kernel
>
> maybe same here too.

Will fix that, too.

>
> Can't fault the rest though.
>
> Cheers
> James

Thanks for the review!


Jonas
