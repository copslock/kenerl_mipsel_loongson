Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 11:23:29 +0200 (CEST)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:34784
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbdDTJXLDG2OP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Apr 2017 11:23:11 +0200
Received: by mail-oi0-x244.google.com with SMTP id y11so5229001oie.1
        for <linux-mips@linux-mips.org>; Thu, 20 Apr 2017 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Rm6TVyZ23o0LzMRfqEwIO/ZabH36gIAIkhoRLA1EYwk=;
        b=NFlSVBTrK+xLosm8Xy9UgUQzGChFVogc203lFKRLsNbI51gvJk1kIJdfAG9dq5bn1i
         3LvFjw0HnhULeb0tj6jhOW6O3Te34t6QqqEw0jR5J02VjUta1jfpLb+Lg75vIGwTuafQ
         4dJ9HPRhDZGpBCxCHjBTzN5T0RuyrhQQINwG5isNZ+z2HAl2w2Q+wFBGysVbak4RXPGD
         gPqxAp9s5Tys4YZnPNVemjvL5g2Vo1GBVWD8bQZnw3LFeT6gIIUyYyaRwhJ+pxlhysV3
         mIlxR4xAq95In2Jd69JmKgnNUToIi2qs5/wSFRnBYm5vwFx6SJlSSz3ePXYA60hHu/Fp
         X3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Rm6TVyZ23o0LzMRfqEwIO/ZabH36gIAIkhoRLA1EYwk=;
        b=cuilPM/mmZMHmIqPQznBYJFPz7s3MCd2zisSPlu1phgciuXPEWfYm5bagfMpOJe56/
         onGwYM9KjRxvb4Blbq+WUx7DE7TAfPrfXj5MiCmHPSYMkTI7qYg9hftWFCfC7i4YZlI/
         V+VwDd0gi7rGmVyuCX1QYY8/tMNv9byZdSuxGyi4iwiLSVcd4PxhHf7HwZjj55KA8V/L
         nhyfh2nX7NrGuTzDm5Nk12idG8pi4P+fzPHco8SMzAjwzV06SFvM6WcDYt6PHBgwvBi5
         uwZgXtv7+TbugiQAwk55n0BXt/HIDzfEv3eYONsyOr9UuIvAsTpWCFdedkqTmMDSPblq
         YMtQ==
X-Gm-Message-State: AN3rC/4wxK6xzS4N5NHTOXSAwsLaZ1mRhCrTspryIH6b61wuNOYNiqPL
        tm2uvi4vHhbOY942r+y/1Ckmrw0OIQ==
X-Received: by 10.157.0.39 with SMTP id 36mr3429967ota.179.1492680183891; Thu,
 20 Apr 2017 02:23:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.20.240 with HTTP; Thu, 20 Apr 2017 02:23:03 -0700 (PDT)
In-Reply-To: <58f869bd.84a0df0a.dc1f9.4547@mx.google.com>
References: <58f869bd.84a0df0a.dc1f9.4547@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Apr 2017 11:23:03 +0200
X-Google-Sender-Auth: pgYQJsG50r0bIspWYJhFXrq9QI0
Message-ID: <CAK8P3a2uZFGXhNq+nwDQmgzNL5WH0VejQmotUZp3=0fKwsU1=w@mail.gmail.com>
Subject: Re: next/master build: 206 builds: 2 failed, 204 passed, 9 errors, 10
 warnings (next-20170420)
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     kernel-build-reports@lists.linaro.org,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57740
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

On Thu, Apr 20, 2017 at 9:56 AM, kernelci.org bot <bot@kernelci.org> wrote:
> next/master build: 206 builds: 2 failed, 204 passed, 9 errors, 10 warnings

> cavium_octeon_defconfig (mips) — FAIL, 8 errors, 0 warnings, 0 section
> mismatches
>
> Errors:
> arch/mips/cavium-octeon/octeon-usb.c:256:12: error: 'union
> cvmx_gpio_bit_cfgx' has no member named 'cn73xx'
> arch/mips/cavium-octeon/octeon-usb.c:261:12: error: 'union
> cvmx_gpio_bit_cfgx' has no member named 'cn70xx'
> arch/mips/cavium-octeon/octeon-usb.c:264:33: error: implicit declaration of
> function 'CVMX_GPIO_XBIT_CFGX' [-Werror=implicit-function-declaration]
> arch/mips/cavium-octeon/octeon-usb.c:266:12: error: 'union
> cvmx_gpio_bit_cfgx' has no member named 'cn70xx'

Apparently caused by
23c1c9508364 ("MIPS: Octeon: Remove unused GPIO types and macros.")
which was merged last week

> drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:707:20: error:
> 'CVMX_MIO_PTP_CLOCK_COMP' undeclared (first use in this function)
> drivers/watchdog/octeon-wdt-main.c:585:18: error: 'CVMX_MIO_BOOT_LOC_ADR'
> undeclared (first use in this function)
> drivers/watchdog/octeon-wdt-main.c:586:18: error: 'CVMX_MIO_BOOT_LOC_DAT'
> undeclared (first use in this function)

Same for
8ed898353e36 ("MIPS: Octeon: Remove unused MIO types and macros.")

> davinci_all_defconfig (arm) — PASS, 0 errors, 0 warnings, 0 section
> mismatches
>
> Section mismatches:
> WARNING: modpost: Found 1 section mismatch(es).
> WARNING: modpost: Found 1 section mismatch(es).

The 'section mismatches' detection in kernelci appears to be broken, so we
don't actually see what happened. I can't reproduce it at the moment,
so it's likely that this is fixed by an older patch of mine:

commit aae89d7dddb831aece31997cdc1c5014fb5a51c1
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Sat Oct 10 21:19:48 2015 +0200

    [WRONG] davinci_mmc: remove incorrect __exit annotation

    WARNING: drivers/built-in.o(.exit.text+0x28ec): Section mismatch
in reference from the function davinci_mmcsd_remove() to the function
.init.text:davinci_release_dma_channels()
    The function __exit davinci_mmcsd_remove() references
    a function __init davinci_release_dma_channels().
    This is often seen when error handling in the exit function
    uses functionality in the init path.
    The fix is often to remove the __init annotation of
    davinci_release_dma_channels() so it may be used outside an init section.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 621ce47e0e4a..9758d42f19a1 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -496,7 +496,7 @@ static int mmc_davinci_start_dma_transfer(struct
mmc_davinci_host *host,
        return ret;
 }

-static void __init_or_module
+static void
 davinci_release_dma_channels(struct mmc_davinci_host *host)
 {
        if (!host->use_dma)
@@ -1361,7 +1361,7 @@ static int __init davinci_mmcsd_probe(struct
platform_device *pdev)
        return ret;
 }

-static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
+static int davinci_mmcsd_remove(struct platform_device *pdev)
 {
        struct mmc_davinci_host *host = platform_get_drvdata(pdev);

@@ -1414,7 +1414,7 @@ static struct platform_driver davinci_mmcsd_driver = {
                .pm     = davinci_mmcsd_pm_ops,
                .of_match_table = davinci_mmc_dt_ids,
        },
-       .remove         = __exit_p(davinci_mmcsd_remove),
+       .remove         = davinci_mmcsd_remove,
        .id_table       = davinci_mmc_devtype,
 };

This is a very old patch and I don't remember why I never submitted
it or marked it as [WRONG], and I don't see why it only now showed
up in kernelci.

> defconfig+CONFIG_KASAN=y (x86) — PASS, 0 errors, 5 warnings, 0 section
> mismatches
>
> Warnings:
> drivers/tty/vt/keyboard.c:1471:1: warning: the frame size of 2344 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:1409:1: warning: the frame size of 2232 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:4469:1: warning: the frame size of 2224 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:5772:1: warning: the frame size of 2064 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:1898:1: warning: the frame size of 3784 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]

I still have this on my radar, didn't get it done for 4.11 though.

> ip27_defconfig (mips) — PASS, 0 errors, 1 warning, 0 section mismatches
>
> Warnings:
> arch/mips/include/asm/uaccess.h:138:21: warning: passing argument 1 of
> '__access_ok' makes pointer from integer without a cast [-Wint-conversion]

I'd argue that the driver is at fault here, but the code has been unchanged
since it was merged in 2009.

The warning was introduced by Al Viro's
f0a955f4eeec ("mips: sanitize __access_ok()")

which enforces that callers of access_ok() must pass a pointer rather
than an "unsigned long". I could not find any other code that passes
anything other than a __user pointer into access_ok(), so it's probably
best to just fix the driver, but there may be others that I missed.

If we want to be sure that all callers of access_ok() use proper
pointers, this patch could help:

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 68766b276d9e..82ffd44b2908 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -38,8 +38,9 @@
  * Test whether a block of memory is a valid user space address.
  * Returns 0 if the range is valid, nonzero otherwise.
  */
-static inline bool __chk_range_not_ok(unsigned long addr, unsigned
long size, unsigned long limit)
+static inline bool __chk_range_not_ok(void __user *uptr, unsigned
long size, unsigned long limit)
 {
+ unsigned long addr = (unsigned long __force)uptr;
  /*
  * If we have used "sizeof()" for the size,
  * we know it won't overflow the limit (but
@@ -60,7 +61,7 @@ static inline bool __chk_range_not_ok(unsigned long
addr, unsigned long size, un
 #define __range_not_ok(addr, size, limit) \
 ({ \
  __chk_user_ptr(addr); \
- __chk_range_not_ok((unsigned long __force)(addr), size, limit); \
+ __chk_range_not_ok(addr, size, limit); \
 })

 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP

I'll add this to my randconfig test tree.

> multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y+CONFIG_ARM_MODULE_PLTS=y (arm) —
> FAIL, 1 error, 0 warnings, 0 section mismatches
>
> Errors:
> arch/arm/kernel/hyp-stub.S:128: Error: invalid immediate for address
> calculation (value = 0x00000004)

I have not seen this one so far, need to investigate more. A quick look points
to this line

        adr     r7, __hyp_stub_vectors

and the symbol it refers to was recently changed in

commit bc845e4fbbbbe97bab3f1bcf688be0b5da420717
Author: Marc Zyngier <marc.zyngier@arm.com>
Date:   Mon Apr 3 19:37:53 2017 +0100

    ARM: KVM: Implement HVC_RESET_VECTORS stub hypercall in the init code

    In order to restore HYP mode to its original condition, KVM currently
    implements __kvm_hyp_reset(). As we're moving towards a hyp-stub
    defined API, it becomes necessary to implement HVC_RESET_VECTORS.

    This patch adds the HVC_RESET_VECTORS hypercall to the KVM init
    code, which so far lacked any form of hypercall support.

    Tested-by: Keerthy <j-keerthy@ti.com>
    Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
    Acked-by: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
    Signed-off-by: Christoffer Dall <cdall@linaro.org>

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index e637854335aa..675c50f5cb5c 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -280,7 +280,7 @@ ENDPROC(__hyp_reset_vectors)
 #endif

 .align 5
-__hyp_stub_vectors:
+ENTRY(__hyp_stub_vectors)
 __hyp_stub_reset:      W(b)    .
 __hyp_stub_und:                W(b)    .
 __hyp_stub_svc:                W(b)    .

but I don't see why that would cause the build error.

         Arnd
