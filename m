Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 01:53:41 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34459 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeIEXxf6LXOM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 01:53:35 +0200
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so17209918ois.1;
        Wed, 05 Sep 2018 16:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OyvN1cpM7RnrgXuUADJuSHYQfVp0emDNRAOJvT0826M=;
        b=TDsylVh+UaDNBvT5mKGHLE3mCm1WruMUSx9ltRSDRITznYTOcKUIg19zhIYqau1CM3
         EZWM1pv+XxIl6Jxe+p6VnktdoHVWdvRgFGw1MkOin9YUWM+TJOSTP44AcCIqrEUf0H7F
         kwaYQB9+aEdGVDmqMdf96/+nzjtlUoEdp2M8X+j/H8MEADpaKcJSi8CmFak3/Dq09tXo
         wfOoPBcvIUe7oebOCGVsiM6QYXQ0dqRDu4bBCk/+w9Q9UKreBA4wl7QV7QIXHJtwiNDc
         +BE/z8HfcaKxDoEGqIRvqW2ig18yUS7v9sPOv2MgxDS5/e4C4GMgEG6HvaLIlkuzoCIB
         3MOg==
X-Gm-Message-State: APzg51Aasmc03s3zwNO2i3soHenIRgIrQp+qKAbeqNYFIdSdnHfRq/2w
        inbvhgYb128nqY1iAVQv5g==
X-Google-Smtp-Source: ANB0Vdbrs88ccsQdrBIRLBtLdSR97TqWwYDgS5lwH0uZpOeHileUmLg6NL7k2yURyLmt0IsbFGmK6Q==
X-Received: by 2002:aca:6541:: with SMTP id j1-v6mr100231oiw.157.1536191609819;
        Wed, 05 Sep 2018 16:53:29 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h186-v6sm3860624oib.55.2018.09.05.16.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 16:53:29 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
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
Subject: [PATCH v2 0/9] Devicetree build consolidation
Date:   Wed,  5 Sep 2018 18:53:18 -0500
Message-Id: <20180905235327.5996-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65997
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

 Makefile                           | 32 +++++++++++++++++++
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
 arch/microblaze/boot/dts/Makefile  |  4 +++
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
 scripts/Makefile.lib               |  2 +-
 25 files changed, 93 insertions(+), 188 deletions(-)
 delete mode 100644 arch/c6x/boot/dts/linked_dtb.S
 create mode 100644 arch/nios2/boot/dts/Makefile
 delete mode 100644 arch/nios2/boot/linked_dtb.S
 create mode 100644 arch/powerpc/boot/dts/Makefile
 create mode 100644 arch/powerpc/boot/dts/fsl/Makefile

--
2.17.1
