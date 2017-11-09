Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 21:35:12 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:51894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992186AbdKIUfCzH2cN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 21:35:02 +0100
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com [209.85.220.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BBA2197A;
        Thu,  9 Nov 2017 20:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BBA2197A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
Received: by mail-qk0-f177.google.com with SMTP id p7so9364649qkd.7;
        Thu, 09 Nov 2017 12:34:59 -0800 (PST)
X-Gm-Message-State: AJaThX4W0CEZW7A714dGSjAw532fo6k4e3+uXTg2DxjO/GJdFZ7IIONN
        0GJY2NLqU3sm7zF+F774HG5GNJiFe4Y6FC33bA==
X-Google-Smtp-Source: AGs4zMbWnNgViTtxuDSim+Swa52BZ0Y+IptsMet7B609myZnwzxgZA8EQ4SnpbuPNfXVUqWyL3BIB3eBEKEHVhlcERg=
X-Received: by 10.55.197.202 with SMTP id k71mr2882582qkl.270.1510259699122;
 Thu, 09 Nov 2017 12:34:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.130.134 with HTTP; Thu, 9 Nov 2017 12:34:38 -0800 (PST)
In-Reply-To: <CAK7LNAT-3yBTFqnFECbGzSHRUiaG38b0BG3_3ouRAZRTF+iiDQ@mail.gmail.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-3-git-send-email-yamada.masahiro@socionext.com>
 <CAAG0J98rRS+Sw8k_87gmTqYdNWByk=9zWVbWnC348vd63H4N9w@mail.gmail.com>
 <CAAG0J99envT6gtM6tHdTvetrHr0itX1dexkuWSU=u1c5UTLE1A@mail.gmail.com> <CAK7LNAT-3yBTFqnFECbGzSHRUiaG38b0BG3_3ouRAZRTF+iiDQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Nov 2017 14:34:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLJZ3D8MXooiS+RFC1jJTCf7L6epwXUgovMAtH5Logwqg@mail.gmail.com>
Message-ID: <CAL_JsqLJZ3D8MXooiS+RFC1jJTCf7L6epwXUgovMAtH5Logwqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: handle dtb-y and CONFIG_OF_ALL_DTBS natively
 in Makefile.lib
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     James Hogan <james@albanarts.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Thu, Nov 9, 2017 at 6:23 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi James,
>
>
> 2017-11-09 21:19 GMT+09:00 James Hogan <james@albanarts.com>:
>> (resend using a working From address)
>>
>> <yamada.masahiro@socionext.com> wrote:
>>> If CONFIG_OF_ALL_DTBS is enabled, "make ARCH=arm64 dtbs" compiles each
>>> DTB twice; one from arch/arm64/boot/dts/*/Makefile and the other from
>>> the dtb-$(CONFIG_OF_ALL_DTBS) line in arch/arm64/boot/dts/Makefile.
>>> It could be a race problem when building DTBS in parallel.
>>>
>>> Another minor issue is CONFIG_OF_ALL_DTBS covers only *.dts in vendor
>>> sub-directories, so this broke when Broadcom added one more hierarchy
>>> in arch/arm64/boot/dts/broadcom/<soc>/.
>>>
>>> One idea to fix the issues in a clean way is to move DTB handling
>>> to Kbuild core scripts.  Makefile.dtbinst already recognizes dtb-y
>>> natively, so it should not hurt to do so.
>>>
>>> Add $(dtb-y) to extra-y, and $(dtb-) as well if CONFIG_OF_ALL_DTBS is
>>> enabled.  All clutter things in Makefiles go away.
>>>
>>> As a bonus clean-up, I also removed dts-dirs.  Just use subdir-y
>>> directly to traverse sub-directories.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>>  ...
>>
>>> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
>>> index 7891ffa..b2b0d88 100644
>>> --- a/arch/mips/boot/dts/Makefile
>>> +++ b/arch/mips/boot/dts/Makefile
>>> @@ -1,20 +1,14 @@
>>> -dts-dirs       += brcm
>>> -dts-dirs       += cavium-octeon
>>> -dts-dirs       += img
>>> -dts-dirs       += ingenic
>>> -dts-dirs       += lantiq
>>> -dts-dirs       += mti
>>> -dts-dirs       += netlogic
>>> -dts-dirs       += ni
>>> -dts-dirs       += pic32
>>> -dts-dirs       += qca
>>> -dts-dirs       += ralink
>>> -dts-dirs       += xilfpga
>>> +subdir-y       += brcm
>>> +subdir-y       += cavium-octeon
>>> +subdir-y       += img
>>> +subdir-y       += ingenic
>>> +subdir-y       += lantiq
>>> +subdir-y       += mti
>>> +subdir-y       += netlogic
>>> +subdir-y       += ni
>>> +subdir-y       += pic32
>>> +subdir-y       += qca
>>> +subdir-y       += ralink
>>> +subdir-y       += xilfpga
>>>
>>> -obj-y          := $(addsuffix /, $(dts-dirs))
>>> -
>>> -dtstree                := $(srctree)/$(src)
>>> -dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))
>>> -
>>> -always         := $(dtb-y)
>>> -subdir-y       := $(dts-dirs)
>>> +obj-$(BUILTIN_DTB)     := $(addsuffix /, $(subdir-y))
>>
>> I wonder if that should be CONFIG_BUILTIN_DTB?
>>
>> This is causing failures in linux-next with MIPS
>> cavium_octeon_defconfig like below, and changing this line to
>> CONFIG_BUILTIN_DTB seems to fix it.
>
> Good catch!
>
>
> Rob,
> Can you fix it to CONFIG_BUILTIN_DTB?

Fixed.

Rob
