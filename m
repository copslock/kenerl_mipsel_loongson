Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 09:57:02 +0100 (CET)
Received: from mail-ot0-x243.google.com ([IPv6:2607:f8b0:4003:c0f::243]:35588
        "EHLO mail-ot0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991232AbdBOI4yuAX3G convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Feb 2017 09:56:54 +0100
Received: by mail-ot0-x243.google.com with SMTP id y13so248438oty.2;
        Wed, 15 Feb 2017 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=W+OWoco8M/qTbyFS78XTkkAMqpnFhi01sLKy3/H8TA8=;
        b=Us+0ST4BnNMshj3++k9PUJYBeTtOAiiuEiT8Wqt5D86JXDu9+DsFbdSpnc3XPCqz1g
         CihSiSbnWeJhXCsIQsUbuVOup8qq1sM2QHvYgcpnSvSOjXyHfIzF813L0wa1Qo62mckM
         mX53nslOKUM4UV5+Z+Pzea+GriEScfdpBpp5p/JHfZWq1uWtT6h6BblVxyhXsr2wQZIP
         tRkUnp3vxwkrm1g91mMBRI3Rz65gSAVOjoxTE0yKnH9KHmtYz+ex7cnChPVWpoPdR/ke
         vILN48ntau+gB+v8sz2asR+ltnBgSqYSuokI5Cwk4HuUvRJVHIeq/Lw06fQzzFA3F2Ak
         7kRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=W+OWoco8M/qTbyFS78XTkkAMqpnFhi01sLKy3/H8TA8=;
        b=Bl9ZCnUe24XbVBIWQ6e+Ht9bof1NLovKqdyjVnYziE2UaklfvKtvhEIRCW+9o8OEJK
         9e+hP0ipHM62qgT6PAbyJMQk5ysHNFYkps56vAOhh1elVC9ZDXkccC16JoNXOfiOeUwV
         7N8lrIj8Q+UoMJ6ZEIETzyFBKCjwqZFgt69/hdZ2nOhiSDlY2Uc73ARWKW/wl32kiNO4
         4ymrrgDfjuxk7FNcgdJzEHi75jH36/kTFQRlJv5Zuj+AlqCng7DtP59pPWkunBtqpudO
         NrmEonBgxy80lXPGO+tlASXWCKs8TqMz1B/Pw8EJjuUiVzzfIkk2p3C6amv5p5hLq9v5
         FaMg==
X-Gm-Message-State: AMke39l5HFxLtN3e9nQgfYQ75J0q8t+ZCzWhyYYpKxxzD5idYu4CgKqB5khhY6DyM+rsXamTUs/ViGpn6jn7GA==
X-Received: by 10.157.19.88 with SMTP id q24mr21891520otq.41.1487149008855;
 Wed, 15 Feb 2017 00:56:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Wed, 15 Feb 2017 00:56:48 -0800 (PST)
In-Reply-To: <58a41194.828bdf0a.685a.3c15@mx.google.com>
References: <58a41194.828bdf0a.685a.3c15@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Feb 2017 09:56:48 +0100
X-Google-Sender-Auth: pVgWCDsjyn_goImmfx1V6hnJObc
Message-ID: <CAK8P3a3XSBzVoM02sdehxDmrX3qM5NFqTgz2s2hyCqE203VzOw@mail.gmail.com>
Subject: Re: next build: 208 builds: 3 failed, 205 passed, 5 errors, 23
 warnings (next-20170215)
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     kernel-build-reports@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56822
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

On Wed, Feb 15, 2017 at 9:30 AM, kernelci.org bot <bot@kernelci.org> wrote:
> next build: 208 builds: 3 failed, 205 passed, 5 errors, 23 warnings

> Errors and Warnings Detected:
>
> arm64: gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05)
> defconfig+CONFIG_KASAN=y 4 warnings
> arm: gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05)
> allmodconfig 7 warnings
> imx_v6_v7_defconfig 2 warnings
> mips: gcc version 6.3.0 (GCC)
> bcm47xx_defconfig 1 error
> ip27_defconfig 2 errors
> xway_defconfig 2 errors
> x86: gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04.1)
> allmodconfig 5 warnings
> allmodconfig+CONFIG_OF=n 5 warnings

A couple of extra problems here that Olof's build bot didn't find (I
replied on those
already, won't duplicate those). In total, we seem to be nine patches short of
a clean build now, which is the best we've had since kernelci added MIPS
builds (we had a clean build for one day before that).

> allmodconfig (arm) — PASS, 0 errors, 7 warnings, 0 section mismatches
>
> Warnings:
> drivers/iio/adc/rcar-gyroadc.c:429:27: warning: 'num_channels' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> drivers/iio/adc/rcar-gyroadc.c:426:22: warning: 'sample_width' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> drivers/iio/adc/rcar-gyroadc.c:428:23: warning: 'channels' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> drivers/iio/adc/rcar-gyroadc.c:398:26: warning: 'adcmode' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> drivers/media/platform/coda/imx-vdoa.c:333:181: warning: passing argument 1
> of '__platform_driver_register' discards 'const' qualifier from pointer
> target type [-Wdiscarded-qualifiers]
> drivers/media/platform/coda/imx-vdoa.c:333:625: warning: passing argument 1
> of 'platform_driver_unregister' discards 'const' qualifier from pointer
> target type [-Wdiscarded-qualifiers]

Covered in my reply to Olof's build bot.

> drivers/usb/gadget/udc/atmel_usba_udc.c:632:550: warning: 'ept_cfg' may be
> used uninitialized in this function [-Wmaybe-uninitialized]

My patch was acked, but not picked up by Felipe or Greg so far:

https://www.spinics.net/lists/linux-usb/msg153162.html

> allmodconfig (x86) — PASS, 0 errors, 5 warnings, 0 section mismatches
>
> Warnings:
> lib/raid6/recov_avx512.c:387:2: warning: #warning "your version of binutils
> lacks AVX512 support" [-Wcpp]

long-standing problem on the kernelci.org x86 toolchain, the only
solution is to update the build bot.

> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:7263:2: warning: missing braces around
> initializer [-Wmissing-braces]
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:7263:2: warning: (near initialization
> for 'ce_payload.regular') [-Wmissing-braces]
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:7290:2: warning: missing braces around
> initializer [-Wmissing-braces]
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:7290:2: warning: (near initialization
> for 'de_payload.regular') [-Wmissing-braces]

This only happens on old compilers. I sent a patch, no reply so far:

https://patchwork.kernel.org/patch/9554695/

> bcm47xx_defconfig (mips) — FAIL, 1 error, 0 warnings, 0 section mismatches
>
> Errors:
> /home/buildslave/workspace/khilman-kbuilder/next/build-mips/../net/sched/sch_fq_codel.c:468:
> undefined reference to `tcf_destroy_chain'

I have not looked at this one yet, appears to be caused by commit
cf1facda2f61 ("sched: move tcf_proto_destroy and tcf_destroy_chain
helpers into cls_api")

> defconfig+CONFIG_KASAN=y (arm64) — PASS, 0 errors, 4 warnings, 0 section
> mismatches
>
> Warnings:
> net/bridge/br_netlink.c:1339:1: warning: the frame size of 2544 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:1415:1: warning: the frame size of 2208 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:1904:1: warning: the frame size of 3840 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:4443:1: warning: the frame size of 2240 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]

I have an experimental patch, still working on a better solution. This might
take some more time, but it's been like this from the start with KASAN.

> ip27_defconfig (mips) — FAIL, 2 errors, 0 warnings, 0 section mismatches
>
> Errors:
> drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not
> satisfy its constraints:
> drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler
> error: in extract_constrain_insn, at recog.c:2190

broken gcc release, apparently fixed in gcc-7 (can't reproduce here at least).
I suggested a workaround, but got no reply so far:

http://www.spinics.net/lists/mips/msg66465.html

> xway_defconfig (mips) — FAIL, 2 errors, 0 warnings, 0 section mismatches
>
> Errors:
> (.text+0x14e10): undefined reference to `physical_memsize'
> (.text+0x14e14): undefined reference to `physical_memsize'

Hauke already did a patch in December, but it has't made it into linux-mips
so far:

https://marc.info/?l=linux-mips&m=148612428414708&w=3

     Arnd
