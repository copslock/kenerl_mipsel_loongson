Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2016 11:27:57 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:59772 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27043106AbcFTJ14Gp9VT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Jun 2016 11:27:56 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A0ABFB91CB2;
        Mon, 20 Jun 2016 11:27:55 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-007-040.088.073.pools.vodafone-ip.de [88.73.7.40])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 711BCB91CB1;
        Mon, 20 Jun 2016 11:27:39 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH v2 0/2] MIPS: keep firmwmare arguments with appended dtb
Date:   Mon, 20 Jun 2016 11:27:35 +0200
Message-Id: <1466414857-30456-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54121
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

The following two patches modify the appended dtb and UHI detection in a
way to allow keeping all four firmware arguments.

Patch one changes the handling of ZBOOT appended dtbs by copying the
appended dtb to the place where the extracted kernel will expect it.
This takes advantage of the fact that the compression Makefile recipe
will always append the uncompressed kernel size to the compressed
kernel if not done by the compression format itself.
This has the nice side effect that we don't need to special case ZBOOT
appended dtb anymore.

Patch two then introduces a new global variable for a UHI passed dtb
address, and stores the appended dtb's address in there if support is
enabled, or the UHI passed address if the arguments match the UHI
interface. It will only do a FDT MAGIC sanity check for appended dtbs,
and not for UHI passed ones, since just because a0 is -2, doesn't mean
a1 will contain a valid address.

Both have been run tested on BMIPS on BCM9EJTAGPRB.

v1 -> v2:
 * drop #ifdefs and use IS_ENABLED
 * drop accidentially added empty line


Jonas Gorski (2):
  MIPS: ZBOOT: copy appended dtb to the end of the kernel
  MIPS: store the appended dtb address in a variable

 arch/mips/Kconfig                      | 22 ++--------------------
 arch/mips/ath79/setup.c                |  4 ++--
 arch/mips/bmips/setup.c                |  4 ++--
 arch/mips/boot/compressed/decompress.c | 17 +++++++++++++++++
 arch/mips/boot/compressed/head.S       | 16 ----------------
 arch/mips/include/asm/bootinfo.h       |  4 ++++
 arch/mips/kernel/head.S                | 21 ++++++++++++++-------
 arch/mips/kernel/setup.c               |  4 ++++
 arch/mips/lantiq/prom.c                |  4 ++--
 arch/mips/pic32/pic32mzda/init.c       |  4 ++--
 10 files changed, 49 insertions(+), 51 deletions(-)

-- 
2.1.4
