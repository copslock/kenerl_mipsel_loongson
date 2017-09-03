Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Sep 2017 19:25:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54322 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993423AbdICRZkTeXWk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Sep 2017 19:25:40 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2822AF67ECDA2;
        Sun,  3 Sep 2017 18:25:27 +0100 (IST)
Received: from localhost (10.20.78.182) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 3 Sep
 2017 18:25:30 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        <kbuild-all@01.org>
Subject: [PATCH] MIPS: Fix generic-board-config.sh for builds using O=
Date:   Sun, 3 Sep 2017 10:24:58 -0700
Message-ID: <20170903172458.32576-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <201709032319.ZeWJCqZ0%fengguang.wu@intel.com>
References: <201709032319.ZeWJCqZ0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.182]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

When configuring the kernel using one of the generic MIPS defconfig
targets, the generic-board-config.sh script is used to check
requirements listed in board config fragments against a reference config
in order to determine which board config fragments to merge into the
final config.

When specifying O= to configure in a directory other than the kernel
source directory, this generic-board-config.sh script is invoked in the
directory that we are configuring in (ie. the directory that O equals),
and the path to the reference config is relative to the current
directory. The script then changes the current directory to the source
tree, which unfortunately breaks later access to the reference file
since its path is relative to a directory that is no longer the current
working directory. This results in configuration failing with errors
such as:

  $ make ARCH=mips O=tmp 32r2_defconfig
  make[1]: Entering directory '/home/pburton/src/linux/tmp'
  Using ../arch/mips/configs/generic_defconfig as base
  Merging ../arch/mips/configs/generic/32r2.config
  Merging ../arch/mips/configs/generic/eb.config
  grep: ./.config.32r2_defconfig: No such file or directory
  grep: ./.config.32r2_defconfig: No such file or directory
  The base file '.config' does not exist.  Exit.
  make[1]: *** [arch/mips/Makefile:505: 32r2_defconfig] Error 1
  make[1]: Leaving directory '/home/pburton/src/linux-ingenic/tmp'
  make: *** [Makefile:145: sub-make] Error 2

Fix this by avoiding changing the working directory in
generic-board-config.sh, instead using full paths to files under
$(srctree)/ where necessary.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 27e0d4b05107 ("MIPS: generic: Allow filtering enabled boards by requirements")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org
--
Ralf, feel free to squash this into 27e0d4b05107 ("MIPS: generic: Allow
filtering enabled boards by requirements") as a fixup.
---
 arch/mips/tools/generic-board-config.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/tools/generic-board-config.sh b/arch/mips/tools/generic-board-config.sh
index 5c4f93687039..654d652d7fa1 100755
--- a/arch/mips/tools/generic-board-config.sh
+++ b/arch/mips/tools/generic-board-config.sh
@@ -30,8 +30,6 @@ cfg="$4"
 boards_origin="$5"
 shift 5
 
-cd "${srctree}"
-
 # Only print Skipping... lines if the user explicitly specified BOARDS=. In the
 # general case it only serves to obscure the useful output about what actually
 # was included.
@@ -48,7 +46,7 @@ environment*)
 esac
 
 for board in $@; do
-	board_cfg="arch/mips/configs/generic/board-${board}.config"
+	board_cfg="${srctree}/arch/mips/configs/generic/board-${board}.config"
 	if [ ! -f "${board_cfg}" ]; then
 		echo "WARNING: Board config '${board_cfg}' not found"
 		continue
@@ -84,7 +82,7 @@ for board in $@; do
 	done || continue
 
 	# Merge this board config fragment into our final config file
-	./scripts/kconfig/merge_config.sh \
+	${srctree}/scripts/kconfig/merge_config.sh \
 		-m -O ${objtree} ${cfg} ${board_cfg} \
 		| grep -Ev '^(#|Using)'
 done
-- 
2.14.1
