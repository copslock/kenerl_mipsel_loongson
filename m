Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 14:32:05 +0100 (CET)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:34867
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdB1Nb6Pjoks convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Feb 2017 14:31:58 +0100
Received: by mail-oi0-x242.google.com with SMTP id z13so846521oig.2;
        Tue, 28 Feb 2017 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YQ1c5JerU6u2SoW82qEzalNVPwyTLvZXwoJQYxTbxEc=;
        b=I08sVIj+JVpVnqwcm1fmjaUq5pwViGe9t4HN9OCWiIn1eiSg5so63VZAiJuuMQSZQr
         cWheSWh9nEPSZiBlwvktry9IMLOHCrdEQ/7/vYclhpdPEf5GiPnGhbJy/M5VZ8WyRf++
         OZzH9sCh51+vwd3zbzJDT4qYugute+poXE8YHAWZY1G5kQT4J7ED4dwla0ctHrKcomsF
         +g95Z0Fdcl+q9K5wC1JCUCOQDN3ELGXGis+93nGS+1OUCOelLrWqxZjyEwr7XUdm8KBy
         /mPj/9FCLAPMJkdZMkZStLw5ULe6+C/t64e0dGpWa26wTpLVfoFXM3gPeqZAztdcuz9W
         l4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YQ1c5JerU6u2SoW82qEzalNVPwyTLvZXwoJQYxTbxEc=;
        b=JuR2415NUPnwv5S+ZP5mlKuMAEET6Ai9gOZ7P3QxZddgNV9bobkXtIEBggYLTKWILw
         md2neP6dnVI1bJcNQnhtjAJZLZE2CN65O2VFrD2EFQJtOz60tm9d7Q7kweMMT4JlCjTC
         14nsyYmAbBmmoF/ESIlUZU6rdnaTcoEFEjBlGEjCPSFIm+erOSpnKnpJENE3RfFDT4Yj
         qxy7cKh+TvhsUovdJRj3O8pALNV58C18wd5+ezOSpV8TSf6d6S2AdkHOpJgk6Z+2kyBc
         7jS13i5EvVsY2mO9eRlOUFn/VaoNbt9F/QKa0hXoPe0XIY7w1N4B8AaBQKtwnubGdFtS
         OE0g==
X-Gm-Message-State: AMke39m630h9UhKrkEHhHfu9pzrh05UMcLUsJV1ZWi/QDol48F7s/tmJ74k+hHX9PLD3ww+tQkpFbP+6yJFQ/A==
X-Received: by 10.202.83.132 with SMTP id h126mr1014272oib.136.1488288712316;
 Tue, 28 Feb 2017 05:31:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Tue, 28 Feb 2017 05:31:51 -0800 (PST)
In-Reply-To: <58b2dc6f.cf4d2e0a.f521.74b3@mx.google.com>
References: <58b2dc6f.cf4d2e0a.f521.74b3@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Feb 2017 14:31:51 +0100
X-Google-Sender-Auth: qq-dlJMJ7rVrlPT0wmp0_3-VKrk
Message-ID: <CAK8P3a32nbd6Wv9wCjmUX+E3gpnWkAWwKurP9dkuwyf_oegCgg@mail.gmail.com>
Subject: Re: stable build: 203 builds: 4 failed, 199 passed, 5 errors, 41
 warnings (v4.10.1)
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Sun, Feb 26, 2017 at 2:47 PM, kernelci.org bot <bot@kernelci.org> wrote:
> stable build: 203 builds: 4 failed, 199 passed, 5 errors, 41 warnings

A lot of fixes for these build problems have now landed in mainline, and
we could backport them as soon as they are considered stable enough.
If all of these make it into stable, we should have a clean build on MIPS and
ARM, and only the KASAN warnings remaining x86 and arm64.

> capcella_defconfig (mips) — PASS, 0 errors, 1 warning, 0 section mismatches
>
> Warnings:
> crypto/wp512.c:987:1: warning: the frame size of 1112 bytes is larger than
> 1024 bytes [-Wframe-larger-than=]

7d6e91050267 ("crypto: improve gcc optimization flags for serpent and wp512")

> defconfig+CONFIG_KASAN=y (x86) — PASS, 0 errors, 5 warnings, 0 section
> mismatches
>
> Warnings:
> drivers/tty/vt/keyboard.c:1470:1: warning: the frame size of 2344 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:1410:1: warning: the frame size of 2232 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:4389:1: warning: the frame size of 2232 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:5689:1: warning: the frame size of 2064 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:1895:1: warning: the frame size of 3720 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]

I'm still working on the fix, the same thing happens in mainline.

> Warnings:
> arch/mips/configs/ip22_defconfig:70:warning: symbol value 'm' invalid for
> NF_CT_PROTO_DCCP
> arch/mips/configs/ip22_defconfig:71:warning: symbol value 'm' invalid for
> NF_CT_PROTO_UDPLITE

9ddc16ad8e0b ("MIPS: Update defconfigs for NF_CT_PROTO_DCCP/UDPLITE change")

> ip27_defconfig (mips) — FAIL, 4 errors, 1 warning, 0 section mismatches
>
> Errors:
> arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE"
> redefined [-Werror]
> arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE"
> redefined [-Werror]

1742ac265046 ("MIPS: VDSO: avoid duplicate CAC_BASE definition")

> drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not
> satisfy its constraints:
> drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler
> error: in extract_constrain_insn, at recog.c:2190
> Warnings:

b61764946839 ("MIPS: ip27: Disable qlge driver in defconfig")

> arch/mips/configs/ip27_defconfig:136:warning: symbol value 'm' invalid for
> SCSI_DH

ea58fca1842a ("MIPS: Update ip27_defconfig for SCSI_DH change")

> ip28_defconfig (mips) — FAIL, 1 error, 0 warnings, 0 section mismatches
>
> Errors:
> arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed option
> -mr10k-cache-barrier=store. Stop.

23ca9b522383 ("MIPS: ip22: Fix ip28 build for modern gcc")

> lemote2f_defconfig (mips) — PASS, 0 errors, 2 warnings, 0 section mismatches
>
> Warnings:
> arch/mips/configs/lemote2f_defconfig:42:warning: symbol value 'm' invalid
> for CPU_FREQ_STAT

b3f6046186ef ("MIPS: Update lemote2f_defconfig for CPU_FREQ_STAT change")

> msp71xx_defconfig (mips) — PASS, 0 errors, 1 warning, 0 section mismatches
>
> Warnings:
> drivers/mtd/maps/pmcmsp-flash.c:149:30: warning: passing argument 1 of
> 'strncpy' discards 'const' qualifier from pointer target type
> [-Wdiscarded-qualifiers]

906b268477bc ("mtd: pmcmsp: use kstrndup instead of kmalloc+strncpy")

> rt305x_defconfig (mips) — PASS, 0 errors, 5 warnings, 0 section mismatches
>
> Warnings:
> arch/mips/ralink/prom.c:70:2: warning: 'argc' is used uninitialized in this
> function [-Wuninitialized]
> arch/mips/ralink/prom.c:70:2: warning: 'argv' is used uninitialized in this
> function [-Wuninitialized]

9c48568b3692 ("MIPS: ralink: Cosmetic change to prom_init().")

> arch/mips/ralink/timer.c:104:13: warning: 'rt_timer_disable' defined but not
> used [-Wunused-function]
> arch/mips/ralink/timer.c:74:13: warning: 'rt_timer_free' defined but not
> used [-Wunused-function]

d92240d12a9c ("MIPS: ralink: Remove unused timer functions")

> arch/mips/ralink/rt305x.c:92:13: warning: 'rt305x_wdt_reset' defined but not
> used [-Wunused-function]

886f9c69fc68 ("MIPS: ralink: Remove unused rt*_wdt_reset functions")

     Arnd
