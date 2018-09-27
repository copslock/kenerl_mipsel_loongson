Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2018 19:05:58 +0200 (CEST)
Received: from mail-it1-x142.google.com ([IPv6:2607:f8b0:4864:20::142]:52228
        "EHLO mail-it1-x142.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992501AbeI0RFvsD1X8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Sep 2018 19:05:51 +0200
Received: by mail-it1-x142.google.com with SMTP id 134-v6so3097201itz.2
        for <linux-mips@linux-mips.org>; Thu, 27 Sep 2018 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AwEGUL1NA4kHX5XC94upxrAIeVzdtNSKcRKmm7WoCPU=;
        b=Kit/tBWWHysocmGe8gDCq/AFJeRpuAAq704hIJ0wB7OkluMUZ2AVjyCiavSn7CBup2
         ZBazTKYSgdUIl3SWVnJBWrLi8aBgFOoFLkAcL5Vfff2XsoLIt5f5yeUIy2mVekCTQRDt
         eObLZUJrKucNQyTXIYSiDA4NEelDcTq7PzspI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AwEGUL1NA4kHX5XC94upxrAIeVzdtNSKcRKmm7WoCPU=;
        b=CfaQ+6dYQqzgpfU5xgqLfIZVg2d8KzV/J0H1qR/wGLoqaDAEtpxoF4Qj6Nat84RO+n
         j4cdb0kIXMuQZ0/5QHAPRGUKiB4dWpvGA2ryf7e/LCL1jX95KMVXNq3xVbNdsnRK/kXT
         f6ybwj2pvbCDimJGMfWe/MNvYPAMgSf6JFfIFDI161TPoDelsvDPvpC8mTm24NrtitdD
         SQ/mk7hTkE6256OcQ2kH2N4lr1EvE+Q6eY0+TOAartmlpdOKuFck32aJbwCtw9loxH9E
         sPdVb4FXXohHjUqB86ZBdWvm/mOK8vNlVDvE1DWbVhRwdY6EVOS6rKKNLKfyN98E2cyk
         cIwQ==
X-Gm-Message-State: ABuFfogmjyTxAbHMW1+5BuGYtcV5Sg4vpXzfUUG3xi4hvmnr2+mGT1Bd
        9fr949dKaU80fu420sY/e6LZBZw7KPN//oXbdXYSDQ==
X-Google-Smtp-Source: ACcGV62bw71shd+XScqvQU2Q0AOYxuHUynvVNR3VqvYDE6vlS00l2hR2z/l51FvC+ZrqXwAUcb1POXvQzGUxZflDr9E=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr9738918ite.123.1538067945425;
 Thu, 27 Sep 2018 10:05:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 10:05:44
 -0700 (PDT)
In-Reply-To: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 27 Sep 2018 19:05:44 +0200
Message-ID: <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
To:     Maksym Kokhan <maksym.kokhan@globallogic.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

On 27 September 2018 at 18:55, Maksym Kokhan
<maksym.kokhan@globallogic.com> wrote:
> There were series of patches [1] for 4.3.0-rc3, that allowed
> architectures to use a generic builtin command line. I have rebased
> these patches on kernel 4.19.0-rc4.
>

Could you please elaborate on the purpose of this series? Is it simply
to align between architectures? Does it solve an actual problem?

> Things, modified in comparison with original patches:
> * There was some bug for mips, in the case when CONFIG_CMDLINE_PREPEND
> and CONFIG_CMDLINE_APPEND are empty and CMDLINE_OVERRIDE is not set,
> command line from bootloader was ignored, so I fixed it, modifying
> patch "add generic builtin command line".
>
> * Implemented new patch to resolve conflict with new kernel, which
> modify EFI stub code. Unfortunately, I don't have capability to test
> this modification on real arm board with EFI.
>
> * Removed new realisation of mips builtin command line, which was
> created after 4.3.0-rc3.
>
> * Kernel 4.3.0-rc3 with original patches could not be compiled for
> powerpc due to prom_init.c checking by prom_init_check.sh. So I added
> strlcat (which is used by cmdline_add_builtin macro) to
> prom_init_check.sh whitelist.
>
> Patches have been tested in QEMU for x86, arm (little-endian), arm64
> (little-endian), mips (little-endian, 32-bit) and powerpc
> (big-endian, 64-bit), everything works perfectly. Also it was tested
> on linux-next (next-20180924 tag) for all listed above architectures.
>
> [1] : https://lore.kernel.org/patchwork/patch/604992/
>
> Daniel Walker (7):
>   add generic builtin command line
>   drivers: of: ifdef out cmdline section
>   x86: convert to generic builtin command line
>   arm: convert to generic builtin command line
>   arm64: convert to generic builtin command line
>   mips: convert to generic builtin command line
>   powerpc: convert to generic builtin command line
>
> Maksym Kokhan (1):
>   efi: modify EFI stub code for arm/arm64
>
>  arch/arm/Kconfig                        | 38 +-----------------
>  arch/arm/kernel/atags_parse.c           | 14 ++-----
>  arch/arm/kernel/devtree.c               |  2 +
>  arch/arm64/Kconfig                      | 17 +-------
>  arch/arm64/kernel/setup.c               |  3 ++
>  arch/mips/Kconfig                       | 24 +----------
>  arch/mips/Kconfig.debug                 | 47 ----------------------
>  arch/mips/kernel/setup.c                | 41 ++-----------------
>  arch/powerpc/Kconfig                    | 23 +----------
>  arch/powerpc/kernel/prom.c              |  4 ++
>  arch/powerpc/kernel/prom_init.c         |  8 ++--
>  arch/powerpc/kernel/prom_init_check.sh  |  2 +-
>  arch/x86/Kconfig                        | 44 +--------------------
>  arch/x86/kernel/setup.c                 | 19 ++-------
>  drivers/firmware/efi/libstub/arm-stub.c | 10 ++---
>  drivers/of/fdt.c                        |  2 +-
>  include/linux/cmdline.h                 | 70 +++++++++++++++++++++++++++++++++
>  init/Kconfig                            | 68 ++++++++++++++++++++++++++++++++
>  18 files changed, 173 insertions(+), 263 deletions(-)
>  create mode 100644 include/linux/cmdline.h
>
> --
> 2.7.4
>
