Return-Path: <SRS0=5ps2=ZU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF9C432C0
	for <linux-mips@archiver.kernel.org>; Thu, 28 Nov 2019 12:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BBB217BC
	for <linux-mips@archiver.kernel.org>; Thu, 28 Nov 2019 12:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="NgKN8bch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfK1Mbr (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:31:47 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:37598 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1Mbr (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 28 Nov 2019 07:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574944303; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKyS5Sg4M19m/KKZTDL1FnYVA1RmbeD5yUcOv4KLVoM=;
        b=NgKN8bchr5nequMf2XcXkOzyjw60VGBdfJDBZtfvFiuuRdd9P3OAbd0WuWCDCMBLAey6vh
        Nl3c9uxHZuAKzHrpFPbYnWVuhvyEo4+6p+0i4ibCYLlw4fGMXgefqnPZ/FPLvCUnyF0Tij
        qM99WnqgLYS691Ud4zMOFy4dldbwaSA=
Date:   Thu, 28 Nov 2019 13:31:33 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 4/6] MIPS: Ingenic: Initial YSH & ATIL CU Neo board
 support.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, paulburton@kernel.org, jhogan@kernel.org,
        mripard@kernel.org, shawnguo@kernel.org, mark.rutland@arm.com,
        syq@debian.org, ralf@linux-mips.org, heiko@sntech.de,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        krzk@kernel.org, geert+renesas@glider.be,
        prasannatsmkumar@gmail.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 772753199@qq.com
Message-Id: <1574944293.3.0@crapouillou.net>
In-Reply-To: <5DDF5711.9050008@zoho.com>
References: <1574787974-58040-1-git-send-email-zhouyanjie@zoho.com>
        <1574787974-58040-5-git-send-email-zhouyanjie@zoho.com>
        <1574873873.3.1@crapouillou.net> <5DDF5711.9050008@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Zhou,


Le jeu., nov. 28, 2019 at 13:11, Zhou Yanjie <zhouyanjie@zoho.com> a=20
=C3=A9crit :
> Hi Paul,
>=20
> On 2019=E5=B9=B411=E6=9C=8828=E6=97=A5 00:57, Paul Cercueil wrote:
>> Hi Zhou,
>>=20
>>=20
>> Le mer., nov. 27, 2019 at 01:06, Zhou Yanjie <zhouyanjie@zoho.com> a=20
>> =7F=C3=A9crit :
>>> Add a device tree for the Ingenic X1000 based YSH & ATIL CU Neo=20
>>> board.
>>> Note that this is unselectable via Kconfig until the X1000 SoC is=20
>>> made
>>> selectable in a later commit.
>>>=20
>>> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
>>> ---
>>>=20
>>> Notes:
>>>     v1->v2:
>>>     Rebase on top of mips-next, use TCU for system timer and=20
>>> =7F=7Fclocksource.
>>>=20
>>>     v2->v3:
>>>     No change.
>>>=20
>>>     v3->v4:
>>>     1.Adjust "model" in "cu1000.dts" to match the description in=20
>>> =7F=7F"devices.yaml".
>>>     2.Adjust "bool" in "Kconfig" to avoid duplicate names with=20
>>> =7F=7Fsubsequent boards.
>>>=20
>>>  arch/mips/boot/dts/ingenic/Makefile   |   1 +
>>>  arch/mips/boot/dts/ingenic/cu1000.dts |  52 ++++++++++++++++++
>>>  arch/mips/configs/cu1000_defconfig    | 100=20
>>> =7F=7F++++++++++++++++++++++++++++++++++
>>>  arch/mips/jz4740/Kconfig              |   4 ++
>>>  4 files changed, 157 insertions(+)
>>>  create mode 100644 arch/mips/boot/dts/ingenic/cu1000.dts
>>>  create mode 100644 arch/mips/configs/cu1000_defconfig
>>>=20
>>> diff --git a/arch/mips/boot/dts/ingenic/Makefile=20
>>> =7F=7Fb/arch/mips/boot/dts/ingenic/Makefile
>>> index 9cc4844..f6db7bb 100644
>>> --- a/arch/mips/boot/dts/ingenic/Makefile
>>> +++ b/arch/mips/boot/dts/ingenic/Makefile
>>> @@ -2,5 +2,6 @@
>>>  dtb-$(CONFIG_JZ4740_QI_LB60)    +=3D qi_lb60.dtb
>>>  dtb-$(CONFIG_JZ4770_GCW0)    +=3D gcw0.dtb
>>>  dtb-$(CONFIG_JZ4780_CI20)    +=3D ci20.dtb
>>> +dtb-$(CONFIG_X1000_CU1000)    +=3D cu1000.dtb
>>>=20
>>>  obj-$(CONFIG_BUILTIN_DTB)    +=3D $(addsuffix .o, $(dtb-y))
>>> diff --git a/arch/mips/boot/dts/ingenic/cu1000.dts=20
>>> =7F=7Fb/arch/mips/boot/dts/ingenic/cu1000.dts
>>> new file mode 100644
>>> index 00000000..f92f6af
>>> --- /dev/null
>>> +++ b/arch/mips/boot/dts/ingenic/cu1000.dts
>>> @@ -0,0 +1,52 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/dts-v1/;
>>> +
>>> +#include "x1000.dtsi"
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/clock/ingenic,tcu.h>
>>> +
>>> +/ {
>>> +    compatible =3D "yna,cu1000", "ingenic,x1000";
>>> +    model =3D "YSH & ATIL General Board CU Neo";
>>> +
>>> +    aliases {
>>> +        serial2 =3D &uart2;
>>> +    };
>>> +
>>> +    chosen {
>>> +        stdout-path =3D &uart2;
>>> +    };
>>> +
>>> +    memory {
>>> +        device_type =3D "memory";
>>> +        reg =3D <0x0 0x04000000>;
>>> +    };
>>> +};
>>> +
>>> +&exclk {
>>> +    clock-frequency =3D <24000000>;
>>> +};
>>> +
>>> +&tcu {
>>> +    /* 1500 kHz for the system timer and clocksource */
>>> +    assigned-clocks =3D <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER2>;
>>> +    assigned-clock-rates =3D <1500000>, <1500000>;
>>> +
>>> +    /* Use channel #1 for the system timer channel #2 for the=20
>>> =7F=7Fclocksource */
>>> +    ingenic,pwm-channels-mask =3D <0xfa>;
>>=20
>> From the mask used, I'm gessing that you're reserving channels #0=20
>> and =7F#2, not #1 and #2.
>>=20
>=20
> My fault, you are right, it use channels #0 and #2.
>=20
>>> +};
>>> +
>>> +&uart2 {
>>> +    status =3D "okay";
>>> +
>>> +    pinctrl-names =3D "default";
>>> +    pinctrl-0 =3D <&pins_uart2>;
>>> +};
>>> +
>>> +&pinctrl {
>>> +    pins_uart2: uart2 {
>>> +        function =3D "uart2";
>>> +        groups =3D "uart2-data-d";
>>> +        bias-disable;
>>> +    };
>>> +};
>>> diff --git a/arch/mips/configs/cu1000_defconfig=20
>>> =7F=7Fb/arch/mips/configs/cu1000_defconfig
>>> new file mode 100644
>>> index 00000000..88729ee
>>> --- /dev/null
>>> +++ b/arch/mips/configs/cu1000_defconfig
>>> @@ -0,0 +1,100 @@
>>> +CONFIG_LOCALVERSION_AUTO=3Dy
>>> +CONFIG_KERNEL_GZIP=3Dy
>>> +CONFIG_SYSVIPC=3Dy
>>> +CONFIG_NO_HZ_IDLE=3Dy
>>> +CONFIG_HIGH_RES_TIMERS=3Dy
>>> +CONFIG_PREEMPT=3Dy
>>> +CONFIG_IKCONFIG=3Dy
>>> +CONFIG_IKCONFIG_PROC=3Dy
>>> +CONFIG_LOG_BUF_SHIFT=3D14
>>> +CONFIG_CGROUPS=3Dy
>>> +CONFIG_MEMCG=3Dy
>>> +CONFIG_MEMCG_KMEM=3Dy
>>> +CONFIG_CGROUP_SCHED=3Dy
>>> +CONFIG_CGROUP_FREEZER=3Dy
>>> +CONFIG_CGROUP_DEVICE=3Dy
>>> +CONFIG_CGROUP_CPUACCT=3Dy
>>> +CONFIG_NAMESPACES=3Dy
>>> +CONFIG_USER_NS=3Dy
>>> +CONFIG_BLK_DEV_INITRD=3Dy
>>> +CONFIG_INITRAMFS_SOURCE=3D"arch/mips/boot/ramdisk.cpio.gz"
>>> +CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
>>> +CONFIG_SYSCTL_SYSCALL=3Dy
>>> +CONFIG_KALLSYMS_ALL=3Dy
>>> +CONFIG_EMBEDDED=3Dy
>>> +# CONFIG_VM_EVENT_COUNTERS is not set
>>> +# CONFIG_COMPAT_BRK is not set
>>> +CONFIG_SLAB=3Dy
>>> +CONFIG_MACH_INGENIC=3Dy
>>> +CONFIG_X1000_CU1000=3Dy
>>> +CONFIG_HIGHMEM=3Dy
>>> +CONFIG_HZ_100=3Dy
>>> +CONFIG_HZ=3D100
>>=20
>> This line looks malformed.
>=20
> Ok, I'll remove it in v7.
>=20
>>=20
>>> +# CONFIG_SECCOMP is not set
>>> +# CONFIG_SUSPEND is not set
>>> +# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>>> +# CONFIG_COMPACTION is not set
>>> +CONFIG_CMA=3Dy
>>> +CONFIG_CMA_AREAS=3D7
>>> +CONFIG_UEVENT_HELPER=3Dy
>>> +CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
>>> +CONFIG_DEVTMPFS=3Dy
>>> +# CONFIG_FW_LOADER is not set
>>> +# CONFIG_ALLOW_DEV_COREDUMP is not set
>>> +# CONFIG_INPUT_MOUSEDEV is not set
>>> +# CONFIG_INPUT_KEYBOARD is not set
>>> +# CONFIG_INPUT_MOUSE is not set
>>> +# CONFIG_SERIO is not set
>>> +CONFIG_VT_HW_CONSOLE_BINDING=3Dy
>>> +CONFIG_LEGACY_PTY_COUNT=3D2
>>> +CONFIG_SERIAL_EARLYCON=3Dy
>>> +CONFIG_SERIAL_8250=3Dy
>>> +CONFIG_SERIAL_8250_CONSOLE=3Dy
>>> +CONFIG_SERIAL_8250_NR_UARTS=3D3
>>> +CONFIG_SERIAL_8250_RUNTIME_UARTS=3D3
>>> +CONFIG_SERIAL_8250_INGENIC=3Dy
>>> +CONFIG_SERIAL_OF_PLATFORM=3Dy
>>> +# CONFIG_HW_RANDOM is not set
>>> +CONFIG_GPIO_SYSFS=3Dy
>>> +# CONFIG_HWMON is not set
>>> +# CONFIG_LCD_CLASS_DEVICE is not set
>>> +# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
>>> +# CONFIG_VGA_CONSOLE is not set
>>> +# CONFIG_HID is not set
>>> +# CONFIG_USB_SUPPORT is not set
>>> +# CONFIG_IOMMU_SUPPORT is not set
>>> +CONFIG_NVMEM=3Dy
>>> +CONFIG_NVMEM_SYSFS=3Dy
>>> +CONFIG_EXT4_FS=3Dy
>>> +# CONFIG_DNOTIFY is not set
>>> +CONFIG_PROC_KCORE=3Dy
>>> +# CONFIG_PROC_PAGE_MONITOR is not set
>>> +CONFIG_TMPFS=3Dy
>>> +CONFIG_CONFIGFS_FS=3Dy
>>> +CONFIG_NLS=3Dy
>>> +CONFIG_NLS_CODEPAGE_936=3Dy
>>> +CONFIG_NLS_CODEPAGE_950=3Dy
>>> +CONFIG_NLS_ASCII=3Dy
>>> +CONFIG_NLS_ISO8859_1=3Dy
>>> +CONFIG_NLS_UTF8=3Dy
>>> +CONFIG_CRYPTO_ECHAINIV=3Dy
>>> +CONFIG_CRYPTO_AES=3Dy
>>> +CONFIG_CRYPTO_DEFLATE=3Dy
>>> +CONFIG_CRYPTO_LZO=3Dy
>>> +CONFIG_PRINTK_TIME=3Dy
>>> +CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D15
>>> +CONFIG_CONSOLE_LOGLEVEL_QUIET=3D15
>>> +CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D7
>>> +CONFIG_DEBUG_INFO=3Dy
>>> +CONFIG_STRIP_ASM_SYMS=3Dy
>>> +CONFIG_DEBUG_FS=3Dy
>>> +CONFIG_MAGIC_SYSRQ=3Dy
>>> +CONFIG_PANIC_ON_OOPS=3Dy
>>> +CONFIG_PANIC_TIMEOUT=3D10
>>> +# CONFIG_SCHED_DEBUG is not set
>>> +# CONFIG_DEBUG_PREEMPT is not set
>>> +CONFIG_STACKTRACE=3Dy
>>> +# CONFIG_FTRACE is not set
>>> +CONFIG_CMDLINE_BOOL=3Dy
>>> +CONFIG_CMDLINE=3D"console=3DttyS2,115200n8 mem=3D32M@0x0 earlycon=20
>>> =7F=7Fclk_ignore_unused"
>>=20
>> You already specify the stdout-path in the devicetree, no need to=20
>> pass =7Fthe "console" parameter.
>>=20
>=20
> According the test log , if remove "console=3DttyS2,115200n8", serial=20
> will not
> initialized and will stuck after:
>=20
> [    0.016815] printk: bootconsole [x1000_uart0] disabled
>=20
> if remove both "console=3DttyS2,115200n8" and "earlycon" it will stuck=20
> after:
>=20
> Starting kernel ...
>=20
> So I think both the "earlycon" and the "console=3DttyS2,115200n8=20
> earlycon" should be retained.

There must be something wrong with your kernel config. It works here.

Use this as your stdout-path: "serial2:115200n8", unset=20
CONFIG_CMDLINE_OVERRIDE, enable MIPS_CMDLINE_DTB_EXTEND, and just use=20
"earlycon clk_ignore_unused" in the devicetree's bootargs. That should=20
do it.

>=20
>> For the "mem" parameter, it's already set in the devicetree, so no=20
>> =7Fneed to set it again here.
>> Besides, in the devicetree it is set to 64 MiB.
>=20
> Ok, I'll remove them in v7.
>=20
>>=20
>> Why is clk_ignore_unused needed?
>=20
> In fact, I also don't know why "clk_ignore_unused" needed.
> This part of the parameter is copied from ci20_defconfig,
> but according to the test, if remove "clk_ignore_unused",
> it will stuck after :
>=20
> [    0.374361] printk: bootconsole [x1000_uart0] disabled
>=20
> Differeent from the case where "console=3DttyS2,115200n8" is removed,
> the serial is successfully initialized this time.
>=20
> So I think "clk_ignore_unused" should be retained.

It locks up because Linux disables a clock that is required for the=20
system. This clock should be requested and enabled by a client driver.=20
Could you investigate which clock is the problem?

@Paul Burton: do you remember why it was needed on CI20?

In the meantime I suppose "clk_ignore_unused" is fine.

Cheers,
-Paul

>>=20
>>> +CONFIG_CMDLINE_OVERRIDE=3Dy
>>> diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
>>> index 6b96844..ccaf507 100644
>>> --- a/arch/mips/jz4740/Kconfig
>>> +++ b/arch/mips/jz4740/Kconfig
>>> @@ -16,6 +16,10 @@ config JZ4780_CI20
>>>      bool "MIPS Creator CI20"
>>>      select MACH_JZ4780
>>>=20
>>> +config X1000_CU1000
>>> +    bool "YSH & ATIL General Module CU1000"
>>> +    select MACH_X1000
>>> +
>>>  endchoice
>>>=20
>>>  config MACH_JZ4740
>>> --
>>> 2.7.4
>>>=20
>>>=20
>>=20
>>=20
>=20
>=20
>=20

=

