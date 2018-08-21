Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 23:55:35 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45822 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994604AbeHUVzc1qXkB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 23:55:32 +0200
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so34755573oic.12;
        Tue, 21 Aug 2018 14:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nYByRictVraWe44R39mkAFN6mZthpxcDanXdqeRYm3c=;
        b=RPrUrG3Ob3OLm3Efe4FbwE5MU2xoq5PsZcPtT1lFgkwJZJeba/6nomPlNtCScegXdE
         T5Cph7vMtT7Z2u5iU7Ui+9Nw/4LI7cblLo2jwFA1dLz/IcuvQPF0xwa9BqXaemjqyXok
         xYYLb+/pI7mynb+MS7RC0jD0Ezu1aEKBWrQuAHf28J5O01HGHDFGHDDFWYomFJS7ZN2A
         ypyDmn1IhefWY6Rkr2c1yjo+TOm02n96Ldi3QgtF2e56oeIZV0egV7cxadVLzjPgx0qo
         9WBqw12E0Zlo/irwbRH9XR/CTtm/3Z+Law3l8rWeWN/K1tMkDPZlm4pjjNqZGMyf7dye
         Zm7Q==
X-Gm-Message-State: APzg51BKVJhx6J/PP+FxcCh1KRsGTI/EXnOPpT4bFkhDJpGc5QdZ/fFl
        i3NW+7eeF2+ANH1rYp+pPg==
X-Google-Smtp-Source: ANB0VdZqd31HUpB1RifhBZAbXMlWzV0LMHIKHueWms/Du//Xt+PVhcc59OvQspBXWl5fj9EpJ3k4QA==
X-Received: by 2002:aca:401:: with SMTP id 1-v6mr1151864oie.28.1534888526316;
        Tue, 21 Aug 2018 14:55:26 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x126-v6sm18785332oig.15.2018.08.21.14.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 14:55:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-mips@linux-mips.org,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 0/8] Devicetree build consolidation
Date:   Tue, 21 Aug 2018 16:55:16 -0500
Message-Id: <20180821215524.23040-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

This series addresses a couple of issues I have with building dts files.

First, the ability to build all the dts files in the tree. This has been
supported on most arches for some time with powerpc being the main
exception. The reason powerpc wasn't supported was it needed a change
in the location built dtb files are put.

Secondly, it's a pain to acquire all the cross-compilers needed to build
dtbs for each arch. There's no reason to build with the cross compiler and
the host compiler is perfectly fine as we only need the pre-processor.

I started addressing just those 2 problems, but kept finding small
differences such as target dependencies and dtbs_install support across
architectures. Instead of trying to align all these, I've consolidated the
build targets moving them out of the arch makefiles.

I'd like to take the series via the DT tree.

Rob

Rob Herring (8):
  powerpc: build .dtb files in dts directory
  nios2: build .dtb files in dts directory
  nios2: use common rules to build built-in dtb
  nios2: fix building all dtbs
  c6x: use common built-in dtb support
  kbuild: consolidate Devicetree dtb build rules
  powerpc: enable building all dtbs
  c6x: enable building all dtbs

 Makefile                           | 30 ++++++++++++++++++
 arch/arc/Makefile                  |  6 ----
 arch/arm/Makefile                  | 20 +-----------
 arch/arm64/Makefile                | 17 +----------
 arch/c6x/Makefile                  |  2 --
 arch/c6x/boot/dts/Makefile         | 17 +++++------
 arch/c6x/boot/dts/linked_dtb.S     |  2 --
 arch/c6x/include/asm/sections.h    |  1 -
 arch/c6x/kernel/setup.c            |  4 +--
 arch/c6x/kernel/vmlinux.lds.S      | 10 ------
 arch/h8300/Makefile                | 11 +------
 arch/microblaze/Makefile           |  4 +--
 arch/mips/Makefile                 | 15 +--------
 arch/nds32/Makefile                |  2 +-
 arch/nios2/Makefile                | 11 +------
 arch/nios2/boot/Makefile           | 22 --------------
 arch/nios2/boot/dts/Makefile       |  6 ++++
 arch/nios2/boot/linked_dtb.S       | 19 ------------
 arch/powerpc/Makefile              |  3 --
 arch/powerpc/boot/Makefile         | 49 ++++++++++++++----------------
 arch/powerpc/boot/dts/Makefile     |  6 ++++
 arch/powerpc/boot/dts/fsl/Makefile |  4 +++
 arch/xtensa/Makefile               | 12 +-------
 scripts/Makefile                   |  1 -
 scripts/Makefile.lib               |  2 +-
 25 files changed, 87 insertions(+), 189 deletions(-)
 delete mode 100644 arch/c6x/boot/dts/linked_dtb.S
 create mode 100644 arch/nios2/boot/dts/Makefile
 delete mode 100644 arch/nios2/boot/linked_dtb.S
 create mode 100644 arch/powerpc/boot/dts/Makefile
 create mode 100644 arch/powerpc/boot/dts/fsl/Makefile

--
2.17.1
