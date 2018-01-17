Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 17:00:23 +0100 (CET)
Received: from forward106o.mail.yandex.net ([IPv6:2a02:6b8:0:1a2d::609]:54545
        "EHLO forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994684AbeAQQAPa20BW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Jan 2018 17:00:15 +0100
Received: from mxback7g.mail.yandex.net (mxback7g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:168])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id 0E15D782F47;
        Wed, 17 Jan 2018 19:00:08 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback7g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id VIfFogNqYE-0508SN0B;
        Wed, 17 Jan 2018 19:00:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1516204808;
        bh=E/iCWYwyI89L0rNWM28v7K7QAlYK+/T4e3b6sUzfdQo=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
        b=ryEaZGtoFunHpIKkaCZM2fzF6mpRH3PDkZEf0H5BpFjLaLLCZqGgJeJ2T91MABQsa
         FD62QTqKPwmFZBstwhGgFtJUJ0Ei7bmsBDZtTBq/30iCus2yZUxiX0udAo24/t1acF
         J3Hi5g3K106qHd+LzxpZHwk8YTc3lDqnwhbjV05E=
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id gC3J2XXXJr-04X0GlAi;
        Wed, 17 Jan 2018 19:00:04 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1516204805;
        bh=E/iCWYwyI89L0rNWM28v7K7QAlYK+/T4e3b6sUzfdQo=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
        b=ZgmWex+SG/yhC16i5hFJOLvggBNm//DnvUuVJjAmmfB5r9WXz9DFk3jRrBJEigY8y
         i7WrjnWHTj/EgrQpLJfwSqTGtNt1h7Qe5ZZojPnke1pqwQFDX3OF0/GGZ7CqeSXG4p
         PjXy5EPQllDg+9UwLfqqePC8h8hWb3GhVCTBtmbY=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: About Loongson platforms' directories
Date:   Wed, 17 Jan 2018 23:59:53 +0800
Message-ID: <2307410.P6mT3GKBU8@flygoat-x230>
User-Agent: KMail/5.2.3 (Linux/4.14.0-2-rt-amd64; KDE/5.37.0; x86_64; ; )
In-Reply-To: <20180117132512.GG5027@jhogan-linux.mipstec.com>
References: <1516182767.23672.1.camel@flygoat.com> <20180117132512.GG5027@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

On 2018年1月17日星期三 CST 下午1:25:13 James Hogan wrote:
>
> Can you expand on these. To what extent is Loongson's EFI similar to the
> EFI from the x86 world? Do these allow multiple new platforms to be
> supported more easily without much new platform code (like devicetree
> support would)?
Hi James

Since I'm not familiar with loongson-3 platform, It's hard for me to expand 
difference between X86's EFI and Loongson's EFI. Maybe Huacai can explain that 
exactly. Here is a SPEC for reference (in Chinese):http://ftp.loongnix.org/
doc/05spec/%E9%BE%99%E8%8A%AFCPU%E5%BC%80%E5%8F%91%E7%B3%BB%E7%BB%9F%E5%9B%BA
%E4%BB%B6%E4%B8%8E%E5%86%85%E6%A0%B8%E6%8E%A5%E5%8F%A3%E8%AF%A6%E7%BB
%86%E8%A7%84%E8%8C%83V2.0.pdf . As far as I know, new platform with same 
chipsets can be supported by SMBIOS without any addition code in kernel. 
However, that feature is only avliable for Loongson-3.

> 
> I believe the general approach in the ARM camp since Linus put his foot
> down about the proliferation of platform code is to have it all
> devicetree based rather than littering the arch directories with
> platform devices. That way a single multiplatform kernel can boot on a
> variety of different platforms with the DT provided by the bootloader or
> appended to the kernel.

> 
> As well as cleaning up and reducing platform code it also simplifies the
> work for distributions since they only need a small number of kernel
> builds.

Yes I would like to do so. Loongson-2K have a limited support with DeviceTree 
(OpenFirmware) by U-Boot bootloader. Later SoC chips will also support DT as I 
know.
But Loongson-1 series and 2E/2F only have leagcy boot support, no EFI, no DT, 
even not all bootloader support machtype (in boot cmdline). That's why we want 
to creat different entries for these platforms.

Loongson's bootloader is pretty in mass. Loongson-3 is using both PMON2000 v3 
and KunLunBIOS(A close-source EFI bootloader), Loongson-2E/2F is using 
PMON2000 v1 (also third-part out of tree U-boot support but not working 
perfectly). Loongson-1 is only using PMON2000. Newer SoCs will support both 
PMON2000 v3 and U-boot .  PMON2000 have no DT support but I decide to submit 
only DT support to mainline.

> 
> On that front MIPS has the "generic" platform (Paul CC'd) which is
> effectively a multi-platform configuration. It is possible to produce a
> single ITB file which contains a kernel and multiple device tree files
> for different platforms which the bootloader can choose from. It may be
> possible to also boot using legacy boot protocols too, though it depends
> on how it differs from the MIPS UHI spec (so a single kernel could boot
> on either platform), and it may require some form of DT shim to set up a
> DT for the kernel to use internally.
> 
> What challenges would you foresee if Loongson headed this way? (even if
> it was a single separate loongson platform in the kernel source). It may
> require some driver revamping, and the boot protocol might be an issue
> for it to share with the other "generic" platforms. Each new board
> potentially becomes easier to upstream though since the only new arch
> code is devicetree, and the rest is drivers in various other subsystems.
> 

Loongson isn't purchasing any IP core and made all the things by themself so 
we can't reuse most drivers already in kernel. We have to write many platform 
drivers such as PCI, BridgeChip, EC, addtion arch_init for chip and etc. 
That's why we prefer entries for Loongson platforms. Or generic may be filled 
with our platform drivers. Also for now loongson64 already have plenty of 
driver. I don't want to spend time in turn them to generic for other MIPS 
chips because they are not general....

> That's the way things should be heading in my opinion (and already are).
> 

Thanks




-- 
--
Jiaxun Yang
