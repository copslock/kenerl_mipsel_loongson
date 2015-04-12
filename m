Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Apr 2015 12:25:22 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41241 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011322AbbDLKZUokRcY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Apr 2015 12:25:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 11E4628BCA3;
        Sun, 12 Apr 2015 12:24:28 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-015-232.088.073.pools.vodafone-ip.de [88.73.15.232])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 69B9C28BC81;
        Sun, 12 Apr 2015 12:24:25 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>
Subject: [PATCH RFC v3 0/4] MIPS: add vmlinu{x,z}.bin appended dtb support
Date:   Sun, 12 Apr 2015 12:24:57 +0200
Message-Id: <1428834301-12721-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

This patch series implements vmlinux.bin and vmlinuz.bin appended dtb
support, and adds a user for the vmlinux one.

The first two patches add the appropriate support for vmlinux.bin and
vmlinuz.bin. Since enabling it for both does not make sense (and is
potentially dangerous) I made it a choice for which variant it should be
enabled.

Patches three and four then add BMIPS as a test user for this
implementation. vmlinuz.bin was tested by selecting SYS_SUPPORTS_ZBOOT
and setting zload-y to 0x81000000 (ramstart + 16 MiB, so the kernel
is loaded behind CFE), then wrapping vmlinuz_w_dtb.bin in the CFE
expected lzma with appropriate header to unpack there.

For easier testing/using I changed boot/dts/brcm to build all dts files
as dtb blobs in case no built in dtb is selected.

Completely untested on anything except MIPS32 / big endian.

Obviously it won't work with an ELF kernel. I did not have a reasonable
idea how to do that except by parsing the elf header from head.S, and
that seemed a bit insane.

Regards
Jonas

Changes RFC v2 -> v3
* Switched to UHI specs interface instead of manipulating initial_boot_params
* fixed boot on !SMP
* Changed PTR_LW to lw and PTR_LI to li to ensure 32bit loads/
  comparisons are done also on 64 bit
* Added vmlinuz.bin support
* Added bmips as a user

Changes RFC v1 -> v2

* changed all occurences of vmlinux to vmlinux.bin
* clarified this applies to the raw vmlinux.bin without decompressor
* s/initial_device_params/initial_boot_params/



Jonas Gorski (4):
  MIPS: add support for vmlinux.bin appended dtb
  MIPS: add support for vmlinuz.bin appended dtb
  MIPS: BMIPS: build all dtbs if no builtin dtb
  MIPS: BMIPS: accept UHI interface for passing a dtb

 arch/mips/Kconfig                   |   45 +++++++++++++++++++++++++++++++++++
 arch/mips/bmips/setup.c             |    2 ++
 arch/mips/boot/compressed/head.S    |   16 +++++++++++++
 arch/mips/boot/compressed/ld.script |    6 ++++-
 arch/mips/boot/dts/brcm/Makefile    |   13 ++++++++++
 arch/mips/kernel/head.S             |   16 +++++++++++++
 arch/mips/kernel/vmlinux.lds.S      |    8 ++++++-
 7 files changed, 104 insertions(+), 2 deletions(-)

-- 
1.7.10.4
