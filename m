Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2015 19:54:07 +0200 (CEST)
Received: from mail-ob0-f193.google.com ([209.85.214.193]:35585 "EHLO
        mail-ob0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010178AbbJHRyGNVqTr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2015 19:54:06 +0200
Received: by obol7 with SMTP id l7so4302516obo.2;
        Thu, 08 Oct 2015 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wHPZ5tEUaPhd8bharSaBG0QpYmxZBuQuPQokk9bz0ho=;
        b=JjccPHFpMKSvS6AI26V+kjIcm45REfo9TQ8II4btcd4eY6j8vc+kWKl6w6pNVOE3ij
         mNtJpLUFTpsuN8M/tMQ9YGlDopD8V2pmWZOdQwhU3oGNohZ6AWh0jZBQTkTUlheBFNdW
         GemfMkfNKLu9DH1ilUUD+jeyLxS7DcMCoGp0JIiqHCkJ5waq9bf7sGo3gSZzZzEG0DmX
         Qq0W+oA3BZtISdMmrsOTLnWn0HGLmSXZe5/x5z9i/ZcTw+BDhiV317zdYDlaCmAKx1ls
         T0kXPhErpeg648FeaWAg0aVkIrL1Hlu/uVBl/Ay3OxyhQ9bBW3FWzGcPznip+VWKs7XR
         LdtQ==
X-Received: by 10.182.16.165 with SMTP id h5mr5485039obd.48.1444326838274;
        Thu, 08 Oct 2015 10:53:58 -0700 (PDT)
Received: from rob-hp-laptop.herring.priv (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.googlemail.com with ESMTPSA id f81sm994967oia.11.2015.10.08.10.53.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Oct 2015 10:53:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Olof Johansson <olof@lixom.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        linux-metag@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vineet Gupta <vgupta@synopsys.com>, arm@kernel.org
Subject: [PATCH v2 00/13] Enable building all dtb files
Date:   Thu,  8 Oct 2015 12:53:34 -0500
Message-Id: <1444326827-3565-1-git-send-email-robh@kernel.org>
X-Mailer: git-send-email 2.1.4
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49470
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

This series enables building all the dtb files in the kernel mostly 
independent of the kernel config. The option is only dependent on 
COMPILE_TEST, OF, and the new OF_ALL_DTBS options. This ensures that 
allyesconfig builds can build all dtb files although most arches have to 
build "dtbs" target explicitly. Some arches like ARM include dtbs in the 
default target.

Arch/arm-soc maintainers, Please ack and I will take this series via the DT 
tree.

v2:
- Add OF_ALL_DTBS option hidden behind COMPILE_TEST
- Expand to all architectures (with more than 1 dtb)

Rob


Rob Herring (13):
  of: add config option to enable building of all dtbs
  arc: use common make variables for dtb builds
  arc: enable building of all dtbs
  arm: enable building of all dtbs
  arm64: enable building of all dtbs
  h8300: enable building of all dtbs
  metag: use common make variables for dtb builds
  metag: enable building of all dtbs
  mips: enable building of all dtbs
  nios2: use common make variables for dtb builds
  nios2: enable building of all dtbs
  powerpc: enable building of all dtbs
  xtensa: enable building of all dtbs

 arch/arc/Makefile              |  2 +-
 arch/arc/boot/dts/Makefile     |  6 ++++--
 arch/arm/boot/dts/Makefile     |  3 +++
 arch/arm64/boot/dts/Makefile   |  6 ++++++
 arch/h8300/boot/dts/Makefile   |  3 +++
 arch/metag/Makefile            |  2 +-
 arch/metag/boot/dts/Makefile   |  7 +++----
 arch/mips/boot/dts/Makefile    |  3 +++
 arch/nios2/Makefile            | 10 +++++-----
 arch/nios2/boot/Makefile       | 13 +++----------
 arch/nios2/boot/dts/Makefile   |  6 ++++++
 arch/powerpc/Makefile          |  6 ++++++
 arch/powerpc/boot/Makefile     |  5 ++++-
 arch/powerpc/boot/dts/Makefile |  5 +++++
 arch/xtensa/Makefile           |  4 ++++
 arch/xtensa/boot/dts/Makefile  |  7 ++++++-
 drivers/of/Kconfig             | 10 ++++++++++
 17 files changed, 73 insertions(+), 25 deletions(-)
 create mode 100644 arch/nios2/boot/dts/Makefile
 create mode 100644 arch/powerpc/boot/dts/Makefile

-- 
2.1.4
