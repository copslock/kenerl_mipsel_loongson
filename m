Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 17:25:45 +0200 (CEST)
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36160 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994561AbeJAPZkVTcac (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2018 17:25:40 +0200
Received: by mail-ot1-f67.google.com with SMTP id c18-v6so13497516otm.3;
        Mon, 01 Oct 2018 08:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UyCzgVa0S9jSz66CwZemQEtwQKyE2g8HQUKaESq/u1s=;
        b=oisKuli1pofu6sajs/rH+rGo0o8PLb61SiizUOB1HuC/fz4li0NuV3wYpPxXVxHYZv
         5pMa3yjApch045lTQvfRe8qESyT0awY8s9OvCF2dcFoqI+8qAeZUn5aI4Dqb1phXjJb+
         Fvn+1h4vZyBaN/2NOU17J9A0HxiBa5UyYC6UNKpakkVPbUYm+nxmA43q8LFmHqB8xAzP
         3d6FnvVm/FB+T+NaPt49QjXc5N1jekAkP6mP6P7Ah6cN8eThEQGVIN+q0a0e9Rp5n3R3
         05R+CeD5yEwwSiXA3CP74AzKc51X//3fqiyJ6d3nbOBgkjRZoTpc03ZXS9fdvqu8jqTc
         4G+A==
X-Gm-Message-State: ABuFfoi67OJFZdCcwcYCpDofztIgy2PbzG8PnWDYKyc1S3T5AKxJuetN
        DHn25Fo2MLvM2zEv+VWwMA==
X-Google-Smtp-Source: ACcGV63U/9K7378gByl64xe8uZ+wZl67iUuVreJToGbhZPR74UhMNSBcYY1EZOgrsjJBChS4j/bmTQ==
X-Received: by 2002:a9d:461a:: with SMTP id y26mr3008875ote.113.1538407534222;
        Mon, 01 Oct 2018 08:25:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s203-v6sm2047035oif.33.2018.10.01.08.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:25:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-mips@linux-mips.org,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v4 0/9] Devicetree build consolidation
Date:   Mon,  1 Oct 2018 10:25:22 -0500
Message-Id: <20181001152531.3385-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66650
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

PPC maintainers, really need you review/ack on this especially patch 1.

Rob


v4:
 - Make dtbs and %.dtb rules depend on arch/$ARCH/boot/dts path rather than
   CONFIG_OF_EARLY_FLATTREE
 - Fix install path missing kernel version for dtbs_install
 - Fix "make CONFIG_OF_ALL_DTBS=y" for arches like ARM which selectively
   enable CONFIG_OF (and therefore dtc)

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

 Makefile                           | 37 +++++++++++++++++++-
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
 27 files changed, 102 insertions(+), 195 deletions(-)
 delete mode 100644 arch/c6x/boot/dts/linked_dtb.S
 create mode 100644 arch/nios2/boot/dts/Makefile
 delete mode 100644 arch/nios2/boot/linked_dtb.S
 create mode 100644 arch/powerpc/boot/dts/Makefile
 create mode 100644 arch/powerpc/boot/dts/fsl/Makefile

--
2.17.1
