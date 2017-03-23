Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Mar 2017 17:19:29 +0100 (CET)
Received: from mail-ot0-x22e.google.com ([IPv6:2607:f8b0:4003:c0f::22e]:34747
        "EHLO mail-ot0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991087AbdCWQTUzzkC9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Mar 2017 17:19:20 +0100
Received: by mail-ot0-x22e.google.com with SMTP id o24so190502012otb.1;
        Thu, 23 Mar 2017 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=NY+jU0vifYycCF5oR5g0hiqGFuScM40YF7Yv2vIUCt0=;
        b=bYkBOc8AkfLA7QqIPg3ubicHQL5DOMo17TKUVT1ZW9Mn8Cm4vCjALYAnUAdWDXLiQ+
         tYINCwjsE6zCq90p90fT1vW3PLo+1w+NiGO6uW4Jpy4Jo8T1zhz53ymdCq6+iEqP5hLM
         lpaUerU9wSWftLZYm3aoFgwkyryoLP9vywSbArFSH1SppcinfC74i0S4AgGLdYprt3qa
         +EHMjpGizBVYhYFNMhKRMhz86XLud6rgsJcdJO2LyZeoU3pdlVX38YctQdQsesGO9tRJ
         L4w/CtSYVuqjUjoCjIas2WzTdAy60EFNUeS/Q4mCjo8tkuD1mIx214u/SFrMl3tKsNzc
         MwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=NY+jU0vifYycCF5oR5g0hiqGFuScM40YF7Yv2vIUCt0=;
        b=g6zA0ml4vohFx7O1yn3ChUvK6xDbv0fQwGWaHm0P82E/wsrdW4PUfOuTe7Ky8vuQuw
         DQROm9CJCdubWk3WPb9e46txc+eRydzyn1ylINJK3Ss1L2DKBKCWNJSDlCUuK800Iekn
         dv8y+5dlhthijxi1dml6AUnmguoXy/oNOqaGysMplQryAP/sf+UGpm/Y7L6RVDR4Tjmk
         2RQ1EpXfGoxRIWfNp11+s7N3hNWmusrPVxKeke7s0hlS9PwFfe7F9t9OEi+0NZ1mqrv1
         6GY9jkYySl2c/qLQnCFhmzo3oQ13dRkVfNK8FU/4eEannlC9CpoABkIvSrAAg28I4Qaw
         ZhmA==
X-Gm-Message-State: AFeK/H1zKwifLhQUZScQ6OisGrQjzsw40ru5aUinlDAF3qRRP35+GaJ321O28mi7kVcSEaeSZnkGKrIMzXfmYg==
X-Received: by 10.157.83.40 with SMTP id g40mr2005836oth.253.1490285955012;
 Thu, 23 Mar 2017 09:19:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.5.145 with HTTP; Thu, 23 Mar 2017 09:19:14 -0700 (PDT)
In-Reply-To: <58d36150.82ce190a.a6597.51eb@mx.google.com>
References: <58d36150.82ce190a.a6597.51eb@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Mar 2017 17:19:14 +0100
X-Google-Sender-Auth: vDDLQcLTLOonNIOcHOI41_esnII
Message-ID: <CAK8P3a0OHuqV-iK0T3BaYnsNgT2RDpAgpa5vQEFneEZZ65Dn9g@mail.gmail.com>
Subject: Re: next build: 208 builds: 9 failed, 199 passed, 857 errors, 444
 warnings (next-20170323)
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     kernel-build-reports@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57424
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

On Thu, Mar 23, 2017 at 6:46 AM, kernelci.org bot <bot@kernelci.org> wrote:

> acs5k_defconfig (arm) — PASS, 0 errors, 2 warnings, 0 section mismatches
>
> Warnings:
> :1328:2: warning: #warning syscall arch_prctl not implemented [-Wcpp]
> :1328:2: warning: #warning syscall arch_prctl not implemented [-Wcpp]

patch sent today, we don't really want this syscall except on x86

> allmodconfig (arm64) — FAIL, 6 errors, 5 warnings, 0 section mismatches
>
> Errors:
> ERROR (phandle_references): Reference to non-existent node or label "pwm_f_clk_pins"
> ERROR (phandle_references): Reference to non-existent node or label "pwm_ao_a_3_pins"
> ERROR: Input tree has errors, aborting (use -f to force output)
> ERROR (phandle_references): Reference to non-existent node or label "pwm_f_clk_pins"
> ERROR (phandle_references): Reference to non-existent node or label "pwm_ao_a_3_pins"
> ERROR: Input tree has errors, aborting (use -f to force output)

Kevin has already backed out the commit that caused this.

> Warnings:
> :1325:2: warning: #warning syscall statx not implemented [-Wcpp]

Should get fixed in the next few days when the patch gets picked up for arm64.

> drivers/misc/aspeed-lpc-ctrl.c:232:17: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]

patch sent today

> include/uapi/linux/byteorder/big_endian.h:32:26: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> include/uapi/linux/byteorder/big_endian.h:32:26: warning: large integer implicitly truncated to unsigned type [-Woverflow]

I sent this one a few days ago

> allmodconfig (x86) — PASS, 0 errors, 11 warnings, 0 section mismatches
>
> Warnings:
> drivers/crypto/cavium/zip/zip_main.c:489:18: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'long long int' [-Wformat=]
> drivers/crypto/cavium/zip/zip_main.c:489:18: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'long long int' [-Wformat=]

This one too.

> cavium_octeon_defconfig (mips) — FAIL, 830 errors, 3 warnings, 0 section mismatches
>
> Errors:
> arch/mips/include/asm/octeon/cvmx-mio-defs.h:78:3: error: expected specifier-qualifier-list before '__BITFIELD_FIELD'
> arch/mips/include/asm/octeon/cvmx-mio-defs.h:95:3: error: expected specifier-qualifier-list before '__BITFIELD_FIELD'

Maybe caused by 4cd156de2ca8 ("MIPS: Octeon: Remove unused MIO types
and macros.")
I have not looked in detail

> net/bridge/br_netlink.c:1339:1: warning: the frame size of 2544 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:1399:1: warning: the frame size of 2208 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:1888:1: warning: the frame size of 3840 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:4429:1: warning: the frame size of 2240 bytes is larger than 2048 bytes [-Wframe-larger-than=]

Still need to rework my patches.

    Arnd
