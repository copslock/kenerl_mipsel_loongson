Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 21:33:38 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:39211
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994573AbeJXTdYnribL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 21:33:24 +0200
Received: by mail-pf1-x443.google.com with SMTP id c25-v6so2925833pfe.6
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2Vz407YGxG3JrIcbuMcGjknc9A1ux1lohN4oRm/Cqf4=;
        b=McA1lhaOKIJL65beGoawo5XA+sF/abwjDeA2yKaiNr8dyq/Od5ufT99E0GONMfFrB5
         mxj/QZue6Tf1t+cRflB1mZi2fxv3IYj6NJnHFMWNkG2f8lp7SnQiYeL4NyVTjHBEdZ05
         1dnyS5bAy3ME1/TpbS7kNt2F+Ark1Fufn3BBBGkrhPKZooIYoq2aAMK7wGQ/hNB2raHa
         uRrvKYdU/4TXZHxUoWQfYalvnc/5tO7e0D+DFqq7jz/D1isEZXlEIx9USTvPb91olUnq
         csiJX/2lmmct5T1tGTx9ZAQ22vlQr9LB07PUSw7pRK5YoMqLg5+eX9X1PLv+twsgdIN4
         lSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Vz407YGxG3JrIcbuMcGjknc9A1ux1lohN4oRm/Cqf4=;
        b=Dx1gAZxud9vWjxJDkQll7hfMi+M6a5XIgBaoU5a7ccD+m7ilSxEgGnuLyaNs241uAI
         5BH/bzUFOWxAuUcZX1GzGLoSPKCWpDFHCaJYdgFKBYCcbPAICllmo7MNMMk1xzU1PYf7
         rK90kkmBNgaPuiYgn5EMIVgR9VYufQM0WniBMPW1VGxoLbM7Ia6F/YEM/Lwx1oLc/kF5
         MxHAmeJtmK0r3/oInHOMyPRym6/+GqT1vXQAKoSL7jCRotssAHrXt7pdU0iOWI3wu/NE
         m8ecguC6IeLxfDtwigkuR1ea1GqL4UEVs3GxelYRaRs4nGHG7EOMEomXvmiSNOSJVNAc
         HYBA==
X-Gm-Message-State: AGRZ1gKzuFd9COqQfnEJFSZQETovRU6OqMB9mSuzxq2si2oRw92x4VWd
        DNCgOrsNDCy4HeNIBrTVCC8=
X-Google-Smtp-Source: AJdET5f4TB1KsZED30rc1ToGjGeQ0Fw4IrT5lX4Ij0zKC68JI72ZgugEVwyyG9P2X2V4HKF41Rc2IQ==
X-Received: by 2002:a63:c54a:: with SMTP id g10-v6mr3624573pgd.201.1540409596871;
        Wed, 24 Oct 2018 12:33:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j187-v6sm9818878pfc.39.2018.10.24.12.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 12:33:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>,
        linux-alpha@vger.kernel.org (open list:ALPHA PORT),
        linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-c6x-dev@linux-c6x.org (open list:C6X ARCHITECTURE),
        uclinux-h8-devel@lists.sourceforge.jp (moderated list:H8/300
        ARCHITECTURE),
        linux-hexagon@vger.kernel.org (open list:QUALCOMM HEXAGON ARCHITECTURE),
        linux-ia64@vger.kernel.org (open list:IA64 (Itanium) PLATFORM),
        linux-m68k@lists.linux-m68k.org (open list:M68K ARCHITECTURE),
        linux-mips@linux-mips.org (open list:MIPS),
        nios2-dev@lists.rocketboards.org (moderated list:NIOS2 ARCHITECTURE),
        openrisc@lists.librecores.org (open list:OPENRISC ARCHITECTURE),
        linux-parisc@vger.kernel.org (open list:PARISC ARCHITECTURE),
        linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
        64-BIT)),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-s390@vger.kernel.org (open list:S390),
        linux-sh@vger.kernel.org (open list:SUPERH),
        sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC
        (sparc/sparc64)),
        linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
        linux-xtensa@linux-xtensa.org (open list:TENSILICA XTENSA PORT (xtensa)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v2 0/2] arm64: Cut rebuild time when changing CONFIG_BLK_DEV_INITRD
Date:   Wed, 24 Oct 2018 12:32:54 -0700
Message-Id: <20181024193256.23734-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi all,

While investigating why ARM64 required a ton of objects to be rebuilt
when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
because we define __early_init_dt_declare_initrd() differently and we do
that in arch/arm64/include/asm/memory.h which gets included by a fair
amount of other header files, and translation units as well.

Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
systems that generate two kernels: one with the initramfs and one
without. buildroot is one of these build systems, OpenWrt is also
another one that does this.

This patch series proposes adding an empty initrd.h to satisfy the need
for drivers/of/fdt.c to unconditionally include that file, and moves the
custom __early_init_dt_declare_initrd() definition away from
asm/memory.h

This cuts the number of objects rebuilds from 1920 down to 26, so a
factor 73 approximately.

Apologies for the long CC list, please let me know how you would go
about merging that and if another approach would be preferable, e.g:
introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
something like that.

Changes in v2:

- put an /* empty */ comment in the asm-generic/initrd.h file
- trim down the CC list to maximize the chances of people receiving this

Florian Fainelli (2):
  arch: Add asm-generic/initrd.h and make use of it for most
    architectures
  arm64: Create asm/initrd.h

 arch/alpha/include/asm/Kbuild      |  1 +
 arch/arc/include/asm/Kbuild        |  1 +
 arch/arm/include/asm/Kbuild        |  1 +
 arch/arm64/include/asm/initrd.h    | 13 +++++++++++++
 arch/arm64/include/asm/memory.h    |  8 --------
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/h8300/include/asm/Kbuild      |  1 +
 arch/hexagon/include/asm/Kbuild    |  1 +
 arch/ia64/include/asm/Kbuild       |  1 +
 arch/m68k/include/asm/Kbuild       |  1 +
 arch/microblaze/include/asm/Kbuild |  1 +
 arch/mips/include/asm/Kbuild       |  1 +
 arch/nds32/include/asm/Kbuild      |  1 +
 arch/nios2/include/asm/Kbuild      |  1 +
 arch/openrisc/include/asm/Kbuild   |  1 +
 arch/parisc/include/asm/Kbuild     |  1 +
 arch/powerpc/include/asm/Kbuild    |  1 +
 arch/riscv/include/asm/Kbuild      |  1 +
 arch/s390/include/asm/Kbuild       |  1 +
 arch/sh/include/asm/Kbuild         |  1 +
 arch/sparc/include/asm/Kbuild      |  1 +
 arch/um/include/asm/Kbuild         |  1 +
 arch/unicore32/include/asm/Kbuild  |  1 +
 arch/x86/include/asm/Kbuild        |  1 +
 arch/xtensa/include/asm/Kbuild     |  1 +
 drivers/of/fdt.c                   |  1 +
 include/asm-generic/initrd.h       |  1 +
 27 files changed, 38 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h
 create mode 100644 include/asm-generic/initrd.h

-- 
2.17.1
