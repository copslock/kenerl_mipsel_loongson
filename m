Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 19:45:46 +0100 (CET)
Received: from mail-oi0-x22d.google.com ([IPv6:2607:f8b0:4003:c06::22d]:34699
        "EHLO mail-oi0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990508AbdAFSpih3PGN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Jan 2017 19:45:38 +0100
Received: by mail-oi0-x22d.google.com with SMTP id 3so442042956oih.1
        for <linux-mips@linux-mips.org>; Fri, 06 Jan 2017 10:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ngWvRMtRlZznwmRmIlvYhn6EO3EBwMtCKy3Z/rS0+Bs=;
        b=xPrYhfk9loqThjT7fYxXjGPBQNMttgDn58FvDkVsd9Dw5pFAiPdbd0BTneZKesmxFe
         4njwHHc/JmZU45H15Yn+YQQK1dbiW5y1ZqpZGUkWj4eYn4usP6t7JJslIeVKNHx+SI30
         zdSMP4pC9go4i5Iqv0pCpqw9YUXEbDi5J/Df0XL+Hkhcan6ZqvQANKCfJW8DGP5xVk9T
         et87E8whB6SgV+CJL3TPVfqiLcMgP8nylmu22RGec1E659FNpxjdQnFiOE28G5OuOdp6
         OUYbW/2KD8vqKYWITI8KY767M+SEUZalShsjcw7PmS1L7iQEkC+2v5L976vT2R7oB0Uj
         tFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ngWvRMtRlZznwmRmIlvYhn6EO3EBwMtCKy3Z/rS0+Bs=;
        b=i6Vj0ty8angWf+TNcUz28xcFkRrumwECjzsrKjcwCx+gekUEE+oYLATkQMgsqkzpBf
         Vhu1Za1WX45SJ+s6eJM7FjVIFDcDOfMzNceY2rV+kTKdEnBlHPbimlCnfNsAlagDHd+N
         7k/hwYsdXK681tIqJdUFj7UYa3yZlxh/fmQrocvYJSf3nwiQpKjTN3nigLppDnzELtOg
         Ocb3P5jmuqFEtblBn5Y4hYCZjNve3OTeCwIg2WVl3ioqa1ShO+DLjv9uqjzAzJoiT+Ii
         Zl4wtYnW1V6pvC02whLmzO3CVU33tX2nVm1PwdRX9DcWxHl3lHn0IR6/EyDkblmLqNn0
         DLlw==
X-Gm-Message-State: AIkVDXJ+XXP5Id0HiilCdQwbH6/bgKz+QnDcETwJor1eKhOaYUhrAOrTvSE4nbaoi2KaApYOA5oaa7SeooJPZvkO
X-Received: by 10.202.52.139 with SMTP id b133mr34714988oia.75.1483728332753;
 Fri, 06 Jan 2017 10:45:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.73.233 with HTTP; Fri, 6 Jan 2017 10:45:32 -0800 (PST)
In-Reply-To: <m2d1g0avn8.fsf@baylibre.com>
References: <586f741b.e8c8c20a.bd7e9.6a97@mx.google.com> <m2d1g0avn8.fsf@baylibre.com>
From:   Kevin Hilman <khilman@baylibre.com>
Date:   Fri, 6 Jan 2017 10:45:32 -0800
Message-ID: <CAOi56cW4YxDePcOW3jo2SWFp4k_u1M4VdvceL8VFc3crMgNccw@mail.gmail.com>
Subject: Re: mainline build: 207 builds: 2 failed, 205 passed, 4 errors, 58
 warnings (v4.10-rc2-207-g88ba6cae15e3)
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <khilman@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56221
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

On Fri, Jan 6, 2017 at 10:30 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> + Ralf, linux-mips
>
> kernelci.org bot <bot@kernelci.org> writes:
>
>> mainline build: 207 builds: 2 failed, 205 passed, 4 errors, 58 warnings (v4.10-rc2-207-g88ba6cae15e3)
>>
>> Full Build Summary: https://kernelci.org/build/mainline/kernel/v4.10-rc2-207-g88ba6cae15e3/
>>
>> Tree: mainline
>> Branch: local/master
>> Git Describe: v4.10-rc2-207-g88ba6cae15e3
>> Git Commit: 88ba6cae15e38f609aba4f3881e1c404c432596c
>> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> Built: 4 unique architectures
>>
>> Build Failures Detected:
>>
>> mips:    gcc version 6.3.0 (GCC)
>>
>>     ip27_defconfig: FAIL
>>     ip28_defconfig: FAIL
>>
>
> [...]
>
>> Errors summary:
>>
>>       2  arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" redefined [-Werror]
>>       1  drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler error: in extract_constrain_insn, at recog.c:2190
>>       1  drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not satisfy its constraints:
>
> [...]
>
>> ================================================================================
>>
>> Detailed per-defconfig build reports:
>
> [...]
>
>> --------------------------------------------------------------------------------
>> ip27_defconfig (mips) — FAIL, 4 errors, 1 warning, 0 section mismatches
>>
>> Errors:
>>     arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" redefined [-Werror]
>>     arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" redefined [-Werror]
>>     drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not satisfy its constraints:
>>     drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler error: in extract_constrain_insn, at recog.c:2190
>>
>> Warnings:
>>     arch/mips/configs/ip27_defconfig:136:warning: symbol value 'm' invalid for SCSI_DH
>>
>> --------------------------------------------------------------------------------
>> ip28_defconfig (mips) — FAIL, 0 errors, 0 warnings, 0 section mismatches

The "0 errors" count is confusing here, I know.  Our error count
detection is not catching "gcc does not support" errors, so we need to
fix that.  The actual error message here is:

../arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
option -mr10k-cache-barrier=store.  Stop.

Kevin
