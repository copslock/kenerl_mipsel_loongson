Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2011 13:38:24 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:42561 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491856Ab1C2LiV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Mar 2011 13:38:21 +0200
Received: by qyl38 with SMTP id 38so44265qyl.15
        for <linux-mips@linux-mips.org>; Tue, 29 Mar 2011 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FKBaE6tdDza2d+/U1iLJTaO/vI9WUvuHEe2u6dPzcOw=;
        b=HyfaWW2KD89CK0tp7YFJOFKCR5tOvmMaySf8nV+N30M/ys5g1jTiuO1HWUpFvwKNXI
         PioUq/nF6O4PT3tZhc6/Xy711me+t2dT3jJSW5pF6FOdBE9f8x+H2K/HIwcED45nHJpR
         AVYZcrNFHUhRtFlT8CnusWzPoRk1dypiknRiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t+5ICwtcFOZttWJrE53wXHOaGLUX3Jy5ZOsZk+MNBo30Gvqj1F78bRjes5ngjvm06j
         PS60/wkTiZn3ySdqhAN6f+zLDbUj7FwiX/9e2gteGQKv87NTGKkxnQcjAA3bCDAKaFu1
         bDA33BZgglfpnMKQVjUK+lrt2sznh/QD/bIv0=
MIME-Version: 1.0
Received: by 10.229.27.193 with SMTP id j1mr3152384qcc.8.1301398695162; Tue,
 29 Mar 2011 04:38:15 -0700 (PDT)
Received: by 10.229.6.200 with HTTP; Tue, 29 Mar 2011 04:38:15 -0700 (PDT)
In-Reply-To: <1301395206.583.53.camel@e102109-lin.cambridge.arm.com>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
        <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
        <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim139fpJsMJFLiyUYvFgGMz-Ljgd_yDrks-tqhE@mail.gmail.com>
        <1301395206.583.53.camel@e102109-lin.cambridge.arm.com>
Date:   Tue, 29 Mar 2011 12:38:15 +0100
Message-ID: <AANLkTim-4v5Cbp6+wHoXjgKXoS0axk1cgQ5AHF_zot80@mail.gmail.com>
Subject: Re: kmemleak for MIPS
From:   Maxin John <maxin.john@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Daniel Baluta <dbaluta@ixiacom.com>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <maxin.john@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxin.john@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

> You may want to disable the kmemleak testing to reduce the amount of
> leaks reported.

The kmemleak results in MIPS that I have included in the previous mail
were obtained during the booting of the malta kernel.
Later, I have checked the "real" usage by using the default
"kmemleak_test" module.

Following output shows the kmemleak results when I used the "kmemleak_test.ko"

debian-mips:~# cat /sys/kernel/debug/kmemleak
........

unreferenced object 0xc0064000 (size 64):
 comm "insmod", pid 4233, jiffies 430046 (age 175.970s)
 hex dump (first 32 bytes):
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 backtrace:
   [<801b1b58>] __vmalloc_node_range+0x16c/0x1e0
   [<801b1bfc>] __vmalloc_node+0x30/0x3c
   [<801b1d94>] vmalloc+0x2c/0x38
   [<c005b168>] 0xc005b168
   [<80100584>] do_one_initcall+0x174/0x1e0
   [<8016b4bc>] sys_init_module+0x1b8/0x153c
   [<8010bf30>] stack_done+0x20/0x40
unreferenced object 0xc0067000 (size 64):
 comm "insmod", pid 4233, jiffies 430046 (age 175.970s)
 hex dump (first 32 bytes):
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 backtrace:
   [<801b1b58>] __vmalloc_node_range+0x16c/0x1e0
   [<801b1bfc>] __vmalloc_node+0x30/0x3c
   [<801b1d94>] vmalloc+0x2c/0x38
   [<c005b17c>] 0xc005b17c
   [<80100584>] do_one_initcall+0x174/0x1e0
   [<8016b4bc>] sys_init_module+0x1b8/0x153c
   [<8010bf30>] stack_done+0x20/0x40
unreferenced object 0xc006a000 (size 64):
 comm "insmod", pid 4233, jiffies 430046 (age 175.970s)
 hex dump (first 32 bytes):
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 backtrace:
   [<801b1b58>] __vmalloc_node_range+0x16c/0x1e0
   [<801b1bfc>] __vmalloc_node+0x30/0x3c
   [<801b1d94>] vmalloc+0x2c/0x38
   [<c005b190>] 0xc005b190
   [<80100584>] do_one_initcall+0x174/0x1e0
   [<8016b4bc>] sys_init_module+0x1b8/0x153c
   [<8010bf30>] stack_done+0x20/0x40

debian-mips:~# lsmod
Module                  Size  Used by
kmemleak_test            867  0
debian-mips:~# rmmod kmemleak_test
debian-mips:~#


> These are probably false positives.
The previous results could be false positives. However, the current
results are not false positives as we have intentionally created the
memory leaks using the test module.

> Since the pointer referring this
> block (udp_table) is __read_mostly, is it possible that the
> corresponding section gets placed outside the _sdata.._edata range?

I am not sure about this. Please  let know how can I check this.

Warm Regards,
Maxin B. John


On Tue, Mar 29, 2011 at 11:40 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, 2011-03-28 at 22:15 +0100, Maxin John wrote:
>> > Just add "depends on MIPS" and give it a try.
>> As per your suggestion, I have tried it in my qemu environment (MIPS malta).
>>
>> With a minor modification in arch/mips/kernel/vmlinux.lds.S (added the
>> symbol  _sdata ), I was able to add kmemleak support for MIPS.
>>
>> Output in MIPS (Malta):
>
> You may want to disable the kmemleak testing to reduce the amount of
> leaks reported.
>
>> debian-mips:~# uname -a
>> Linux debian-mips 2.6.38-08826-g1788c20-dirty #4 SMP Mon Mar 28
>> 23:22:04 EEST 2011 mips GNU/Linux
>> debian-mips:~# mount -t debugfs nodev /sys/kernel/debug/
>> debian-mips:~# cat /sys/kernel/debug/kmemleak
>> unreferenced object 0x8f95d000 (size 4096):
>>   comm "swapper", pid 1, jiffies 4294937330 (age 467.240s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<80529644>] alloc_large_system_hash+0x2f8/0x410
>>     [<8053864c>] udp_table_init+0x4c/0x158
>>     [<80538774>] udp_init+0x1c/0x94
>>     [<80538b34>] inet_init+0x184/0x2a0
>>     [<80100584>] do_one_initcall+0x174/0x1e0
>>     [<8051f348>] kernel_init+0xe4/0x174
>>     [<80103d4c>] kernel_thread_helper+0x10/0x18
>> unreferenced object 0x8f95e000 (size 4096):
>>   comm "swapper", pid 1, jiffies 4294937330 (age 467.240s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<80529644>] alloc_large_system_hash+0x2f8/0x410
>>     [<8053864c>] udp_table_init+0x4c/0x158
>>     [<8053881c>] udplite4_register+0x24/0xa8
>>     [<80538b3c>] inet_init+0x18c/0x2a0
>>     [<80100584>] do_one_initcall+0x174/0x1e0
>>     [<8051f348>] kernel_init+0xe4/0x174
>>     [<80103d4c>] kernel_thread_helper+0x10/0x18
>
> These are probably false positives. Since the pointer referring this
> block (udp_table) is __read_mostly, is it possible that the
> corresponding section gets placed outside the _sdata.._edata range?
>
> diff --git a/arch/mips/include/asm/cache.h b/arch/mips/include/asm/cache.h
> index 650ac9b..b4db69f 100644
> --- a/arch/mips/include/asm/cache.h
> +++ b/arch/mips/include/asm/cache.h
> @@ -17,6 +17,6 @@
>  #define SMP_CACHE_SHIFT                L1_CACHE_SHIFT
>  #define SMP_CACHE_BYTES                L1_CACHE_BYTES
>
> -#define __read_mostly __attribute__((__section__(".data.read_mostly")))
> +#define __read_mostly __attribute__((__section__(".data..read_mostly")))
>
>  #endif /* _ASM_CACHE_H */
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> index 570607b..6f6d5d0 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -74,6 +74,7 @@ SECTIONS
>                INIT_TASK_DATA(PAGE_SIZE)
>                NOSAVE_DATA
>                CACHELINE_ALIGNED_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
> +               READ_MOSTLY_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
>                DATA_DATA
>                CONSTRUCTORS
>        }
>
>> unreferenced object 0x8f072000 (size 4096):
>>   comm "swapper", pid 1, jiffies 4294937680 (age 463.840s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<801ba3d8>] __kmalloc+0x130/0x180
>>     [<805461bc>] flow_cache_cpu_prepare+0x50/0xa8
>>     [<8053746c>] flow_cache_init_global+0x90/0x138
>>     [<80100584>] do_one_initcall+0x174/0x1e0
>>     [<8051f348>] kernel_init+0xe4/0x174
>>     [<80103d4c>] kernel_thread_helper+0x10/0x18
>
> Same here, flow_cachep pointer is __read_mostly.
>
> --
> Catalin
>
>
>
