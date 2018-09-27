Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2018 18:55:45 +0200 (CEST)
Received: from mail-lf1-x144.google.com ([IPv6:2a00:1450:4864:20::144]:38201
        "EHLO mail-lf1-x144.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993945AbeI0QzYiz9p8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Sep 2018 18:55:24 +0200
Received: by mail-lf1-x144.google.com with SMTP id g89-v6so2737099lfl.5
        for <linux-mips@linux-mips.org>; Thu, 27 Sep 2018 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iM8c0ufFnsdAl7ba5T+Z3WN7gLhoLrTNvpjR0bH4AwM=;
        b=FXt/sOk2SbP1AvGPLTOWaXNJ9cR+513RIm7Dt6AcPZDnSx93A93v2fVw4FcXXPxVfX
         9HG6FnPSdxRX5sQTijVTqJwwQasX91r8h+UrrC0CPVoN2fSqnGO66AbKofmeTdJVlq4z
         3cdCTwbDa45Ywz6Ggkp5862BNoSfRP4rVaozQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iM8c0ufFnsdAl7ba5T+Z3WN7gLhoLrTNvpjR0bH4AwM=;
        b=R5O4uVxxsD8iBnYynl3eNTuUXO+3/jgCff09Vb062bd+RivDii908N7M8dOlbj6rTA
         X7ebxK94I+qrDdpjnheS+23mcB8K5LI9jnAzZaOvYU9DjDKNaeEhOmZY0DJZ+icP3jqz
         MwmGst/p8IHj/sqiQNJOcoNVq/DWWkvso2Y2JH2iwom+ITDlq+AUCgboplV75WFKBy63
         YJLWokgkrMI1rtN0mJAUB6DaRUUkChOQv+w4A/kw+XazF6HuinMyJaSG6//anxTStJot
         KcUxZJVWC3k7gYmMeO05NT7gJBQEgpj6WoCGiuenl6KjgO2o54fzMRiFNt5oOiSEGDOv
         l6jA==
X-Gm-Message-State: ABuFfojq5CIZ2jovhj7k1HcXOWRg34g66tkf7kroXQ8fEsDQcwc8uSD8
        1n1JRiNS90+pdlpf+930rOmWog==
X-Google-Smtp-Source: ACcGV60IVvJ1LmrupkgPSKGUTSqjIw+n1U2CyKX7tDFZzcRbrqnbFz86YNwU9RqIoJEQ9c/o4zxHOg==
X-Received: by 2002:a19:635b:: with SMTP id x88-v6mr789639lfb.85.1538067316929;
        Thu, 27 Sep 2018 09:55:16 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id n3-v6sm533529lfi.96.2018.09.27.09.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 09:55:16 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8] add generic builtin command line
Date:   Thu, 27 Sep 2018 19:55:08 +0300
Message-Id: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <maksym.kokhan@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksym.kokhan@globallogic.com
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

There were series of patches [1] for 4.3.0-rc3, that allowed
architectures to use a generic builtin command line. I have rebased
these patches on kernel 4.19.0-rc4.

Things, modified in comparison with original patches:                            
* There was some bug for mips, in the case when CONFIG_CMDLINE_PREPEND
and CONFIG_CMDLINE_APPEND are empty and CMDLINE_OVERRIDE is not set,
command line from bootloader was ignored, so I fixed it, modifying
patch "add generic builtin command line".

* Implemented new patch to resolve conflict with new kernel, which
modify EFI stub code. Unfortunately, I don't have capability to test
this modification on real arm board with EFI.

* Removed new realisation of mips builtin command line, which was
created after 4.3.0-rc3.

* Kernel 4.3.0-rc3 with original patches could not be compiled for
powerpc due to prom_init.c checking by prom_init_check.sh. So I added
strlcat (which is used by cmdline_add_builtin macro) to
prom_init_check.sh whitelist.

Patches have been tested in QEMU for x86, arm (little-endian), arm64
(little-endian), mips (little-endian, 32-bit) and powerpc
(big-endian, 64-bit), everything works perfectly. Also it was tested
on linux-next (next-20180924 tag) for all listed above architectures.

[1] : https://lore.kernel.org/patchwork/patch/604992/

Daniel Walker (7):
  add generic builtin command line
  drivers: of: ifdef out cmdline section
  x86: convert to generic builtin command line
  arm: convert to generic builtin command line
  arm64: convert to generic builtin command line
  mips: convert to generic builtin command line
  powerpc: convert to generic builtin command line

Maksym Kokhan (1):
  efi: modify EFI stub code for arm/arm64

 arch/arm/Kconfig                        | 38 +-----------------
 arch/arm/kernel/atags_parse.c           | 14 ++-----
 arch/arm/kernel/devtree.c               |  2 +
 arch/arm64/Kconfig                      | 17 +-------
 arch/arm64/kernel/setup.c               |  3 ++
 arch/mips/Kconfig                       | 24 +----------
 arch/mips/Kconfig.debug                 | 47 ----------------------
 arch/mips/kernel/setup.c                | 41 ++-----------------
 arch/powerpc/Kconfig                    | 23 +----------
 arch/powerpc/kernel/prom.c              |  4 ++
 arch/powerpc/kernel/prom_init.c         |  8 ++--
 arch/powerpc/kernel/prom_init_check.sh  |  2 +-
 arch/x86/Kconfig                        | 44 +--------------------
 arch/x86/kernel/setup.c                 | 19 ++-------
 drivers/firmware/efi/libstub/arm-stub.c | 10 ++---
 drivers/of/fdt.c                        |  2 +-
 include/linux/cmdline.h                 | 70 +++++++++++++++++++++++++++++++++
 init/Kconfig                            | 68 ++++++++++++++++++++++++++++++++
 18 files changed, 173 insertions(+), 263 deletions(-)
 create mode 100644 include/linux/cmdline.h

-- 
2.7.4
