Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 17:04:15 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33316 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994572AbeIJPEME0TRl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2018 17:04:12 +0200
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so40782245oip.0;
        Mon, 10 Sep 2018 08:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zJYcPpjpq26XK/SMPEoVaTen2jr8d5LfXE7wtymr5Us=;
        b=XuUitTefNtLatJ5j7HHcpmJqLeuDI+y5wdPBxn29VHubLkNr7XgSfultGD/T/VdBGR
         ZGKK0lWiyi+Njgi3Rxnzky7EwXeftBLxiw7J1/MUsnDMYDYGCY6nM6WOMHadxcD6PZKt
         gG/C/UVE1nV/xKIlClFQX2TA4wyyBP5iRnughCVcZOap6LK7xl400iJoR/rQkndDyPcO
         cDDwpyHRwxwoM6axVYwlDuPnc9Jlzz9LfETI5Ar6R/MEz6XYQAVVvdrPTqf55D/jlaB+
         kus5vPZCt/lFtbzFgTBQtxJecThQ/YEWCyw7+gXSVR/M70VqyB1xd6O9PydOCQEhPbJB
         Ou6A==
X-Gm-Message-State: APzg51A0XbT0dCmgu9xljzZ7spLUooaFgoq9eiP01/GkgifufgOkY/EN
        FEJi0/L1z9BsvRb9m0qg1w==
X-Google-Smtp-Source: ANB0VdZ/sKl9bn5u6uBsPY0Q/ugAgqUqCsYTxrWc6TsJIIGwgvN/4lCv+0q8ZJsqmhqMh0CICfD7oQ==
X-Received: by 2002:aca:a93:: with SMTP id k19-v6mr23935864oiy.83.1536591845285;
        Mon, 10 Sep 2018 08:04:05 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k85-v6sm49465631oiy.2.2018.09.10.08.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:04:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Michal Simek <monstr@monstr.eu>,
        nios2-dev@lists.rocketboards.org,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v3 0/9] Devicetree build consolidation
Date:   Mon, 10 Sep 2018 10:03:54 -0500
Message-Id: <20180910150403.19476-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66183
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

v3:
 - Rework dtc dependency to avoid 2 entry paths to scripts/dtc/. Essentially,
   I copied 'scripts_basic'.
 - Add missing scripts_basic dependency for dtc and missing PHONY tag.
 - Drop the '|' order only from dependencies
 - Drop %.dtb.S and %.dtb.o as top-level targets
 - PPC: remove duplicate mpc5200 dtbs from image-y targets

v2:
 - Fix $arch/boot/dts path check for out of tree builds
 - Fix dtc dependency for building built-in dtbs
 - Fix microblaze built-in dtb building
 - Add dtbs target for microblaze

Rob Herring (9):
  powerpc: build .dtb files in dts directory
  nios2: build .dtb files in dts directory
  nios2: use common rules to build built-in dtb
  nios2: fix building all dtbs
  c6x: use common built-in dtb support
  kbuild: consolidate Devicetree dtb build rules
  powerpc: enable building all dtbs
  c6x: enable building all dtbs
  microblaze: enable building all dtbs

 Makefile                           | 35 ++++++++++++++++++-
 arch/arc/Makefile                  |  6 ----
 arch/arm/Makefile                  | 20 +----------
 arch/arm64/Makefile                | 17 +--------
 arch/c6x/Makefile                  |  2 --
 arch/c6x/boot/dts/Makefile         | 17 ++++-----
 arch/c6x/boot/dts/linked_dtb.S     |  2 --
 arch/c6x/include/asm/sections.h    |  1 -
 arch/c6x/kernel/setup.c            |  4 +--
 arch/c6x/kernel/vmlinux.lds.S      | 10 ------
 arch/h8300/Makefile                | 11 +-----
 arch/microblaze/Makefile           |  4 +--
 arch/microblaze/boot/dts/Makefile  |  4 +++
 arch/mips/Makefile                 | 15 +-------
 arch/nds32/Makefile                |  2 +-
 arch/nios2/Makefile                | 11 +-----
 arch/nios2/boot/Makefile           | 22 ------------
 arch/nios2/boot/dts/Makefile       |  6 ++++
 arch/nios2/boot/linked_dtb.S       | 19 -----------
 arch/powerpc/Makefile              |  3 --
 arch/powerpc/boot/Makefile         | 55 ++++++++++++++----------------
 arch/powerpc/boot/dts/Makefile     |  6 ++++
 arch/powerpc/boot/dts/fsl/Makefile |  4 +++
 arch/xtensa/Makefile               | 12 +------
 scripts/Makefile                   |  3 +-
 scripts/Makefile.lib               |  2 +-
 scripts/dtc/Makefile               |  2 +-
 27 files changed, 100 insertions(+), 195 deletions(-)
 delete mode 100644 arch/c6x/boot/dts/linked_dtb.S
 create mode 100644 arch/nios2/boot/dts/Makefile
 delete mode 100644 arch/nios2/boot/linked_dtb.S
 create mode 100644 arch/powerpc/boot/dts/Makefile
 create mode 100644 arch/powerpc/boot/dts/fsl/Makefile

--
2.17.1
