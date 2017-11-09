Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 13:24:43 +0100 (CET)
Received: from conssluserg-05.nifty.com ([210.131.2.90]:63318 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990901AbdKIMY0pCuLP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 13:24:26 +0100
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com [209.85.161.177]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id vA9CNtX6004718;
        Thu, 9 Nov 2017 21:23:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com vA9CNtX6004718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1510230236;
        bh=U9OnsjKg5TgN1BcBDa2ahnLRR9aJ1i1ENZTRCPc8/44=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=F0WoRyOD9jgYW0k8yX/B65/oHAawMqkTfI8Fn0pceWAdIL/EFmkasa9VIlwoTeKcx
         mNHMyBb4s1GQrz+vH8PvZiPtzIUGPo0umTu0xIltOSFoPwvSdKMdoFlcFO/gFiyMo4
         i6C5sNDvEx4vXzOogBruoo2A5SlMB1HRqN9QVuEFa1/4qgDSq8jr4V4Qn7rlbGVVCI
         c1f6tU2+ulhZ2E/3jbO9iCHJXLilwp6HpiQDJu0fNjWDeKRBMAGIndj/1GgHEJMnk3
         jjVX0LdSjcaI6tNr5QnRyBgGkCt2r89CdMFsLoJdmFtnH+lyFyqc1T+H1nfsGpo32V
         fn3gOe9ZhTxpA==
X-Nifty-SrcIP: [209.85.161.177]
Received: by mail-yw0-f177.google.com with SMTP id k3so5089652ywk.8;
        Thu, 09 Nov 2017 04:23:55 -0800 (PST)
X-Gm-Message-State: AJaThX4u435aU7yNYDkcYbSeVnIUHwmdPoLlJmuiMPnqjfKr/ZEbDrPN
        sZjntGUe8ehzgTg+yQreeFon5S0xGDCwQVmo4oU=
X-Google-Smtp-Source: ABhQp+SIgzPa9gCYMaaWq34E8uliuepfdKG1xSVgUqgtZlIo5Xf/rSKKZMIx4gWMWP6OvaN+QwL5hNXrLstgEGWcpng=
X-Received: by 10.129.220.12 with SMTP id h12mr158225ywj.343.1510230234621;
 Thu, 09 Nov 2017 04:23:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.110.139 with HTTP; Thu, 9 Nov 2017 04:23:14 -0800 (PST)
In-Reply-To: <CAAG0J99envT6gtM6tHdTvetrHr0itX1dexkuWSU=u1c5UTLE1A@mail.gmail.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-3-git-send-email-yamada.masahiro@socionext.com>
 <CAAG0J98rRS+Sw8k_87gmTqYdNWByk=9zWVbWnC348vd63H4N9w@mail.gmail.com> <CAAG0J99envT6gtM6tHdTvetrHr0itX1dexkuWSU=u1c5UTLE1A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 9 Nov 2017 21:23:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-3yBTFqnFECbGzSHRUiaG38b0BG3_3ouRAZRTF+iiDQ@mail.gmail.com>
Message-ID: <CAK7LNAT-3yBTFqnFECbGzSHRUiaG38b0BG3_3ouRAZRTF+iiDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: handle dtb-y and CONFIG_OF_ALL_DTBS natively
 in Makefile.lib
To:     James Hogan <james@albanarts.com>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        James Hogan <james.hogan@mips.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

Hi James,


2017-11-09 21:19 GMT+09:00 James Hogan <james@albanarts.com>:
> (resend using a working From address)
>
> <yamada.masahiro@socionext.com> wrote:
>> If CONFIG_OF_ALL_DTBS is enabled, "make ARCH=arm64 dtbs" compiles each
>> DTB twice; one from arch/arm64/boot/dts/*/Makefile and the other from
>> the dtb-$(CONFIG_OF_ALL_DTBS) line in arch/arm64/boot/dts/Makefile.
>> It could be a race problem when building DTBS in parallel.
>>
>> Another minor issue is CONFIG_OF_ALL_DTBS covers only *.dts in vendor
>> sub-directories, so this broke when Broadcom added one more hierarchy
>> in arch/arm64/boot/dts/broadcom/<soc>/.
>>
>> One idea to fix the issues in a clean way is to move DTB handling
>> to Kbuild core scripts.  Makefile.dtbinst already recognizes dtb-y
>> natively, so it should not hurt to do so.
>>
>> Add $(dtb-y) to extra-y, and $(dtb-) as well if CONFIG_OF_ALL_DTBS is
>> enabled.  All clutter things in Makefiles go away.
>>
>> As a bonus clean-up, I also removed dts-dirs.  Just use subdir-y
>> directly to traverse sub-directories.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>  ...
>
>> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
>> index 7891ffa..b2b0d88 100644
>> --- a/arch/mips/boot/dts/Makefile
>> +++ b/arch/mips/boot/dts/Makefile
>> @@ -1,20 +1,14 @@
>> -dts-dirs       += brcm
>> -dts-dirs       += cavium-octeon
>> -dts-dirs       += img
>> -dts-dirs       += ingenic
>> -dts-dirs       += lantiq
>> -dts-dirs       += mti
>> -dts-dirs       += netlogic
>> -dts-dirs       += ni
>> -dts-dirs       += pic32
>> -dts-dirs       += qca
>> -dts-dirs       += ralink
>> -dts-dirs       += xilfpga
>> +subdir-y       += brcm
>> +subdir-y       += cavium-octeon
>> +subdir-y       += img
>> +subdir-y       += ingenic
>> +subdir-y       += lantiq
>> +subdir-y       += mti
>> +subdir-y       += netlogic
>> +subdir-y       += ni
>> +subdir-y       += pic32
>> +subdir-y       += qca
>> +subdir-y       += ralink
>> +subdir-y       += xilfpga
>>
>> -obj-y          := $(addsuffix /, $(dts-dirs))
>> -
>> -dtstree                := $(srctree)/$(src)
>> -dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))
>> -
>> -always         := $(dtb-y)
>> -subdir-y       := $(dts-dirs)
>> +obj-$(BUILTIN_DTB)     := $(addsuffix /, $(subdir-y))
>
> I wonder if that should be CONFIG_BUILTIN_DTB?
>
> This is causing failures in linux-next with MIPS
> cavium_octeon_defconfig like below, and changing this line to
> CONFIG_BUILTIN_DTB seems to fix it.

Good catch!


Rob,
Can you fix it to CONFIG_BUILTIN_DTB?

Thanks!



> arch/mips/cavium-octeon/setup.o: In function `__octeon_is_model_runtime__':
> /work/mips/linux/main/./arch/mips/include/asm/octeon/octeon-model.h:368:
> undefined reference to `__dtb_octeon_3xxx_begin'
> arch/mips/cavium-octeon/setup.o: In function `device_tree_init':
> /work/mips/linux/main/arch/mips/cavium-octeon/setup.c:1188: undefined
> reference to `__dtb_octeon_3xxx_begin'
> /work/mips/linux/main/arch/mips/cavium-octeon/setup.c:1184: undefined
> reference to `__dtb_octeon_68xx_begin'
> /work/mips/linux/main/arch/mips/cavium-octeon/setup.c:1184: undefined
> reference to `__dtb_octeon_68xx_begin'
>
> Thanks
> James
>
>


-- 
Best Regards
Masahiro Yamada
