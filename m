Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 19:30:53 +0100 (CET)
Received: from mail-pf0-x22b.google.com ([IPv6:2607:f8b0:400e:c00::22b]:35080
        "EHLO mail-pf0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992437AbdAFSap23NzN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Jan 2017 19:30:45 +0100
Received: by mail-pf0-x22b.google.com with SMTP id f144so5781812pfa.2
        for <linux-mips@linux-mips.org>; Fri, 06 Jan 2017 10:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=nimJDjgCzRZm+1RNY8EyupGdm6DBFArzYSkTNsp3OBI=;
        b=pfwaTg64YNvm3L7QtxNVXItBYdVqPKVknggGfXDQldLLJ6Vpa3MT8AMFoDP9/Xo/Bt
         GKfMYixXMhCyiBMwNSVB4jDxVVfTbmR5SdJBVp+DT2svpR/eq3u1mwk9lCpogVkJKtcs
         YS+JkaitSbzL+XOASSkv6CUa/Q9EPv2feUYkBhOTbnI+DN6J/HgYI+AgGfBAJWW4xV9e
         yZh1ohYrlUc8nBQqR1rLHvNH4pzn6rnnwDOif+Z79RVFaMjr2WGbC+RknkYiWkwJOvd3
         7Vy1ji8+kwmOjTOStPsAc+bOMMFA+ACFchBmCNnSX3idly46P71WMGhs5jB0Q1qZypz7
         02Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nimJDjgCzRZm+1RNY8EyupGdm6DBFArzYSkTNsp3OBI=;
        b=Wz6/qo/TjCkOEJWkc2091APTmac5L1XOdxlmkT7y1m9dBx8/jCJmCyNxKZgoVSWTwL
         z0tH9OUQkUoXGUBeiGmh9AdnVvASYlVIPOD5H2l4MSROggcPdXB4c5ieEKZAeMH/zN9c
         SIc2s+l21iBf5nkn7w9KhRMWHe94mD62KLGE4UcgWSu2uDBWgSxzFasaoWHLIf93GxEP
         GDMKe+mgblAz2xJPfunildDdi/jBzzP64G1CsrqmGd2O/dGJfRFfu9cuf+/mQWNfe0M1
         Y/nfT+HqLat0sD22b+aNFKpAvIWqOwLi/nx0dCZVSOXYcpQ/PkKyUz0xN7DepONUstQx
         zDGw==
X-Gm-Message-State: AIkVDXJECpRTBV2BVZOeC8P44qwA1Tp/jbDkmEge9cwG3jfc5StE/Cce0tsNO7dbm6vqZi7x
X-Received: by 10.84.217.216 with SMTP id d24mr169358844plj.101.1483727436448;
        Fri, 06 Jan 2017 10:30:36 -0800 (PST)
Received: from localhost (c-98-203-232-209.hsd1.wa.comcast.net. [98.203.232.209])
        by smtp.gmail.com with ESMTPSA id h67sm16525756pfj.34.2017.01.06.10.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2017 10:30:35 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     kernel-build-reports@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: mainline build: 207 builds: 2 failed, 205 passed, 4 errors, 58 warnings (v4.10-rc2-207-g88ba6cae15e3)
Organization: BayLibre
References: <586f741b.e8c8c20a.bd7e9.6a97@mx.google.com>
Date:   Fri, 06 Jan 2017 10:30:35 -0800
In-Reply-To: <586f741b.e8c8c20a.bd7e9.6a97@mx.google.com> (kernelci org bot's
        message of "Fri, 06 Jan 2017 02:40:27 -0800 (PST)")
Message-ID: <m2d1g0avn8.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <khilman@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khilman@baylibre.com
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

+ Ralf, linux-mips

kernelci.org bot <bot@kernelci.org> writes:

> mainline build: 207 builds: 2 failed, 205 passed, 4 errors, 58 warnings (v4.10-rc2-207-g88ba6cae15e3)
>
> Full Build Summary: https://kernelci.org/build/mainline/kernel/v4.10-rc2-207-g88ba6cae15e3/
>
> Tree: mainline
> Branch: local/master
> Git Describe: v4.10-rc2-207-g88ba6cae15e3
> Git Commit: 88ba6cae15e38f609aba4f3881e1c404c432596c
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> Built: 4 unique architectures
>
> Build Failures Detected:
>
> mips:    gcc version 6.3.0 (GCC)
>
>     ip27_defconfig: FAIL
>     ip28_defconfig: FAIL
>

[...]

> Errors summary:
>
>       2  arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" redefined [-Werror]
>       1  drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler error: in extract_constrain_insn, at recog.c:2190
>       1  drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not satisfy its constraints:

[...]

> ================================================================================
>
> Detailed per-defconfig build reports:

[...]

> --------------------------------------------------------------------------------
> ip27_defconfig (mips) — FAIL, 4 errors, 1 warning, 0 section mismatches
>
> Errors:
>     arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" redefined [-Werror]
>     arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" redefined [-Werror]
>     drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not satisfy its constraints:
>     drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler error: in extract_constrain_insn, at recog.c:2190
>
> Warnings:
>     arch/mips/configs/ip27_defconfig:136:warning: symbol value 'm' invalid for SCSI_DH
>
> --------------------------------------------------------------------------------
> ip28_defconfig (mips) — FAIL, 0 errors, 0 warnings, 0 section mismatches
>

We finally updated the MIPS toolchain to gcc-6.3, which got rid of the
other errors, but is now finding a few new ones, including an internal
compiler error.  :)   Arnd also mentioned that it's unlikely that the
qlge driver should be enabled for these defconfigs, so that's probably
an easy one.

Since it sounds so fun, I'll leave it with you MIPS folks to take care
of. ;)

Note that the same failures are happening in stable/linux-4.8.y and
stable/linux-4.9.y, so fixes should likely be CC'd to stable.

Thanks,

Kevin

[1] https://kernelci.org/build/stable-rc/kernel/v4.8.16/
[2] https://kernelci.org/build/stable-rc/kernel/v4.9.1/
