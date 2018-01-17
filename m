Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 17:35:00 +0100 (CET)
Received: from mail-io0-x233.google.com ([IPv6:2607:f8b0:4001:c06::233]:36298
        "EHLO mail-io0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994684AbeAQQexY6mYO convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Jan 2018 17:34:53 +0100
Received: by mail-io0-x233.google.com with SMTP id l17so11617055ioc.3;
        Wed, 17 Jan 2018 08:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gvkUeXLGcJ2JQ/cwzZpjpwpmjUyh6RzLaLLvvKdvC2k=;
        b=alaTx9izGq3hhc/2cPkdOeCR85N9oJ9WQzerbJeaXSxsFbTrJu6LKNuuPPU5Rp8Pfo
         eNmyfqFpXf46aiTypDuh95xJ9+0GCg3CTgwtbwpjf9YT3k+gC9O2hewSmaY/+WH97+4n
         d+DLPrr546Y6qOyHUeNAT3xG7lExz9Na/Xx57RzGmAFjd3I1Dk/XRw1miQQh7NjDsJlI
         okt8l6YFLDLxMBfwKZr6goHrvg/ZBWHUgpqGtqjn8dBYzIPeOMsEuMTB3uyYgJTdInyc
         NXogr7fcwoXKEtoJDexcEPsBgWrcUA38qoJkk2XKhU2oLDcFzluD0r2krpDarlB+cW+e
         t6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gvkUeXLGcJ2JQ/cwzZpjpwpmjUyh6RzLaLLvvKdvC2k=;
        b=TVUa0pjU+XJjCGuA+REg+ydkWifAEKC1U7gxh75vMIuVzKrTuJ683VnG2Zup4eGluz
         NGyYkll8Vkmzzk0ghXuNaHKbTMUe2mgrLBvwlYxA8WX/oouW+83sCq2bviHl3eX6i90z
         EZsaV3h10xWC3AkbN68cx44siQukUYo7HuAOkKcHC0fHoAEY49VxZW0bDMq5Sbx6GwuW
         jO2O42A4umyts49dg6UlTRE9GgJ4WZxuaYkOoHKhAUW622eRge0L4KIdHPUpTISS/6ri
         2O8vBLYRP6PiWP8nes+wpPPHzCgBhEXpNE6tDixfQ3NnlmZ3kiz2QDr6gKRaW6lM80hT
         /0rw==
X-Gm-Message-State: AKwxytclg/Y4ydS4uJvpSB88kiH56w9xUDH9pESK0qUbflLCnypQX5/i
        c6dZdRFVd6oRq+UkpBx8NBWWxZCZuYjU5jI7YI0=
X-Google-Smtp-Source: ACJfBotWpgr0pYcUd94WfIDfq+A2aSd0wYUP01qlAtQvYNfuWf6uWI/rjtsK2RlgJINm+Aypyl/mT+lFNyrVRNkGmJA=
X-Received: by 10.107.39.78 with SMTP id n75mr16902695ion.165.1516206886966;
 Wed, 17 Jan 2018 08:34:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Wed, 17 Jan 2018 08:34:46 -0800 (PST)
In-Reply-To: <2307410.P6mT3GKBU8@flygoat-x230>
References: <1516182767.23672.1.camel@flygoat.com> <20180117132512.GG5027@jhogan-linux.mipstec.com>
 <2307410.P6mT3GKBU8@flygoat-x230>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 17 Jan 2018 22:04:46 +0530
Message-ID: <CANc+2y4-Y9vb26K4Re8seR8vwrp4v2v8EzqsO9i-iZqWPuf41Q@mail.gmail.com>
Subject: Re: About Loongson platforms' directories
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     James Hogan <james.hogan@mips.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Jiaxun,

On 17 January 2018 at 21:29, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> On 2018年1月17日星期三 CST 下午1:25:13 James Hogan wrote:
>>
>> Can you expand on these. To what extent is Loongson's EFI similar to the
>> EFI from the x86 world? Do these allow multiple new platforms to be
>> supported more easily without much new platform code (like devicetree
>> support would)?
> Hi James
>
> Since I'm not familiar with loongson-3 platform, It's hard for me to expand
> difference between X86's EFI and Loongson's EFI. Maybe Huacai can explain that
> exactly. Here is a SPEC for reference (in Chinese):http://ftp.loongnix.org/
> doc/05spec/%E9%BE%99%E8%8A%AFCPU%E5%BC%80%E5%8F%91%E7%B3%BB%E7%BB%9F%E5%9B%BA
> %E4%BB%B6%E4%B8%8E%E5%86%85%E6%A0%B8%E6%8E%A5%E5%8F%A3%E8%AF%A6%E7%BB
> %86%E8%A7%84%E8%8C%83V2.0.pdf . As far as I know, new platform with same
> chipsets can be supported by SMBIOS without any addition code in kernel.
> However, that feature is only avliable for Loongson-3.
>
>>
>> I believe the general approach in the ARM camp since Linus put his foot
>> down about the proliferation of platform code is to have it all
>> devicetree based rather than littering the arch directories with
>> platform devices. That way a single multiplatform kernel can boot on a
>> variety of different platforms with the DT provided by the bootloader or
>> appended to the kernel.
>
>>
>> As well as cleaning up and reducing platform code it also simplifies the
>> work for distributions since they only need a small number of kernel
>> builds.
>
> Yes I would like to do so. Loongson-2K have a limited support with DeviceTree
> (OpenFirmware) by U-Boot bootloader. Later SoC chips will also support DT as I
> know.
> But Loongson-1 series and 2E/2F only have leagcy boot support, no EFI, no DT,
> even not all bootloader support machtype (in boot cmdline). That's why we want
> to creat different entries for these platforms.

It is possible to use DT even if boot loader does not supply it. The
dtb can be append to the kernel and kernel can be configured to pick
it up.

> Loongson's bootloader is pretty in mass. Loongson-3 is using both PMON2000 v3
> and KunLunBIOS(A close-source EFI bootloader), Loongson-2E/2F is using
> PMON2000 v1 (also third-part out of tree U-boot support but not working
> perfectly). Loongson-1 is only using PMON2000. Newer SoCs will support both
> PMON2000 v3 and U-boot .  PMON2000 have no DT support but I decide to submit
> only DT support to mainline.
>
>>
>> On that front MIPS has the "generic" platform (Paul CC'd) which is
>> effectively a multi-platform configuration. It is possible to produce a
>> single ITB file which contains a kernel and multiple device tree files
>> for different platforms which the bootloader can choose from. It may be
>> possible to also boot using legacy boot protocols too, thougtoh it depends
>> on how it differs from the MIPS UHI spec (so a single kernel could boot
>> on either platform), and it may require some form of DT shim to set up a
>> DT for the kernel to use internally.
>>
>> What challenges would you foresee if Loongson headed this way? (even if
>> it was a single separate loongson platform in the kernel source). It may
>> require some driver revamping, and the boot protocol might be an issue
>> for it to share with the other "generic" platforms. Each new board
>> potentially becomes easier to upstream though since the only new arch
>> code is devicetree, and the rest is drivers in various other subsystems.
>>
>
> Loongson isn't purchasing any IP core and made all the things by themself so
> we can't reuse most drivers already in kernel. We have to write many platform
> drivers such as PCI, BridgeChip, EC, addtion arch_init for chip and etc.
> That's why we prefer entries for Loongson platforms. Or generic may be filled
> with our platform drivers. Also for now loongson64 already have plenty of
> driver. I don't want to spend time in turn them to generic for other MIPS
> chips because they are not general....

I think James is talking about having little to no platform code in
arch/mips/loongson/. It is preferred to have Loongson specific drivers
in driver/<hw-specific-framework> as it would help using common code
the framework provides. Any change to driver will go via the
respective framework maintainer (for example change to Loongson rtc
driver can be submitted to the rtc maintainer) which will reduce mips
maintainer burden and also increases responsiveness in getting the
changes merged.

>> That's the way things should be heading in my opinion (and already are).
>>
>
> Thanks
>
>
>
>
> --
> --
> Jiaxun Yang
>

Regards,
PrasannaKumar
