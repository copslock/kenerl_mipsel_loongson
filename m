Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 11:34:09 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37994 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010707AbcA0KeHvoY2M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2016 11:34:07 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 6622528C007;
        Wed, 27 Jan 2016 11:33:20 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com [209.85.217.173])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 5B6AC28C709;
        Wed, 27 Jan 2016 11:33:12 +0100 (CET)
Received: by mail-lb0-f173.google.com with SMTP id cl12so2670388lbc.1;
        Wed, 27 Jan 2016 02:33:57 -0800 (PST)
X-Gm-Message-State: AG10YOS7r8bUFbpdm2VXiEQed2so9Fn2ceTvYID0miM93FgKFeLn1LvKEKIepC3nXOzdutuTPmkRCmwS3E4x+A==
X-Received: by 10.112.129.233 with SMTP id nz9mr1288800lbb.82.1453890837190;
 Wed, 27 Jan 2016 02:33:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.25.130 with HTTP; Wed, 27 Jan 2016 02:33:37 -0800 (PST)
In-Reply-To: <56A7FE3F.5090909@gmail.com>
References: <1453848410-24949-1-git-send-email-broonie@kernel.org>
 <1453848410-24949-2-git-send-email-broonie@kernel.org> <56A7FE3F.5090909@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 27 Jan 2016 11:33:37 +0100
X-Gmail-Original-Message-ID: <CAOiHx=kk06ythGn=a3UGs-BBUUYxdm7zLsNtBFiCiwxF5m6VxA@mail.gmail.com>
Message-ID: <CAOiHx=kk06ythGn=a3UGs-BBUUYxdm7zLsNtBFiCiwxF5m6VxA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] MIPS: dt: Explicitly specify native endian
 behaviour for syscon
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51468
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

Hi,

On 27 January 2016 at 00:16, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 26/01/16 14:46, Mark Brown wrote:
>> On many MIPS systems the endianness of IP blocks is kept the same as
>> that of the CPU by the hardware.  This includes the system controllers
>> on these systems which are controlled via syscon which uses the regmap
>> API which used readl() and writel() to interact with the hardware,
>> meaning that all writes are converted to little endian when writing to
>> the hardware.  This caused a bad interaction with the regmap core in big
>> endian mode since it was not aware of the byte swapping and so ended up
>> performing little endian writes.
>>
>> Unfortunately when this issue was noticed it was addressed by updating
>> the DT for the affected devices to specify them as little endian.  This
>> happened to work since it resulted in two endianness swaps which
>> cancelled each other out and gave little endian behaviour but meant that
>> the DT was clearly not accurately describing the hardware.
>>
>> The intention of commit 29bb45f25ff305 (regmap-mmio: Use native
>> endianness for read/write) was to fix this by making regmap default to
>> native endianness but this breaks most other MMIO users where the
>> hardware has a fixed endianness and the implementation uses the __raw
>> accessors which are not intended to be used outside of architecture
>> code.  Instead use the newly added native-endian DT property to say
>> exactly what we want for these systems.
>>
>> Fixes: 29bb45f25ff305 (regmap-mmio: Use native endianness for read/write)
>> Reported-by: Johannes Berg <johannes@sipsolutions.net>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
>>
>> Posted for review only, this will interact with some other patches
>> fixing the implementation of regmap-mmio and will probably need to be
>> merged along with them.
>>
>>  arch/mips/boot/dts/brcm/bcm6328.dtsi | 1 +
>
> v4.5-rc1 now contains an arch/mips/boot/dts/brcm/bcm6368.dtsi which
> copied the 6328.dtsi and therefore needs this hunk to be added to your
> patch series:
>
> diff --git a/arch/mips/boot/dts/brcm/bcm6368.dtsi
> b/arch/mips/boot/dts/brcm/bcm6368.dtsi
> index 9c8d3fe28b31..1f6b9b5cddb4 100644
> --- a/arch/mips/boot/dts/brcm/bcm6368.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
> @@ -54,7 +54,7 @@
>                 periph_cntl: syscon@10000000 {
>                         compatible = "syscon";
>                         reg = <0x10000000 0x14>;
> -                       little-endian;
> +                       native-endian;

But native-endian == big-endian usually for bcm63xx, so is this
actually a bugfix?


Jonas
