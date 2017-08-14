Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 20:19:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8376 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993945AbdHNSTUwOgmp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 20:19:20 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id F272D81D7543A;
        Mon, 14 Aug 2017 19:19:09 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 14 Aug 2017 19:19:13
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 2/8] MIPS: generic: Allow filtering enabled boards by requirements
Date:   Mon, 14 Aug 2017 11:18:13 -0700
Message-ID: <20170814181819.7376-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170814181819.7376-1-paul.burton@imgtec.com>
References: <20170814181819.7376-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59572
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

Up until now when configuring a generic kernel all board config
fragments have been merged by default unless boards are explicitly
selected by the user specifying BOARDS=.

In many cases this is sub-optimal, since some boards don't make sense to
include in some kernels. For example the MIPS SEAD-3 development board
has only ever been used with 32 bit CPUs, so including support for the
SEAD-3 in a 64 bit kernel is wasteful.

This patch introduces support for specifying requirements in board
config fragments, using comments formatted like so:

  # require CONFIG_BLA=y

For example the SEAD-3 board could specify that it should only be merged
for 32 bit kernels using a requirement line like the following:

  # require CONFIG_32BIT=y

A new generic-board-config.sh script is introduced to handle selecting
the board config fragments to merge & calling merge_config.sh to merge
them. In order to allow requirements to check Kconfig symbols that are
implicitly selected, rather than explicitly specified by
generic_defconfig or one of the ISA config fragments, an intermediate
.config file is saved & used as a reference when checking requirements.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

Changes in v2: None

 MAINTAINERS                             |  1 +
 arch/mips/Makefile                      | 10 +++-
 arch/mips/tools/generic-board-config.sh | 90 +++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100755 arch/mips/tools/generic-board-config.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 44cb004c765d..ca7014a70dd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8793,6 +8793,7 @@ M:	Paul Burton <paul.burton@imgtec.com>
 L:	linux-mips@linux-mips.org
 S:	Supported
 F:	arch/mips/generic/
+F:	arch/mips/tools/generic-board-config.sh
 
 MIPS/LOONGSON1 ARCHITECTURE
 M:	Keguang Zhang <keguang.zhang@gmail.com>
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 38360f776b6f..0e0aa64a9c88 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -500,8 +500,14 @@ $(eval $(call gen_generic_defconfigs,micro32,r2,eb el))
 .PHONY: $(generic_defconfigs)
 $(generic_defconfigs):
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/generic_defconfig $^ \
-		$(foreach board,$(BOARDS),$(generic_config_dir)/board-$(board).config)
+		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/generic_defconfig $^ | \
+		grep -Ev '^#'
+	$(Q)cp $(KCONFIG_CONFIG) $(objtree)/.config.$@
+	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig \
+		KCONFIG_CONFIG=$(objtree)/.config.$@ >/dev/null
+	$(Q)$(CONFIG_SHELL) $(srctree)/arch/$(ARCH)/tools/generic-board-config.sh \
+		$(srctree) $(objtree) $(objtree)/.config.$@ $(KCONFIG_CONFIG) \
+		"$(origin BOARDS)" $(BOARDS)
 	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
 #
diff --git a/arch/mips/tools/generic-board-config.sh b/arch/mips/tools/generic-board-config.sh
new file mode 100755
index 000000000000..5c4f93687039
--- /dev/null
+++ b/arch/mips/tools/generic-board-config.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+#
+# Copyright (C) 2017 Imagination Technologies
+# Author: Paul Burton <paul.burton@imgtec.com>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published by the
+# Free Software Foundation;  either version 2 of the  License, or (at your
+# option) any later version.
+#
+# This script merges configuration fragments for boards supported by the
+# generic MIPS kernel. It checks each for requirements specified using
+# formatted comments, and then calls merge_config.sh to merge those
+# fragments which have no unmet requirements.
+#
+# An example of requirements in your board config fragment might be:
+#
+# # require CONFIG_CPU_MIPS32_R2=y
+# # require CONFIG_CPU_LITTLE_ENDIAN=y
+#
+# This would mean that your board is only included in kernels which are
+# configured for little endian MIPS32r2 CPUs, and not for example in kernels
+# configured for 64 bit or big endian systems.
+#
+
+srctree="$1"
+objtree="$2"
+ref_cfg="$3"
+cfg="$4"
+boards_origin="$5"
+shift 5
+
+cd "${srctree}"
+
+# Only print Skipping... lines if the user explicitly specified BOARDS=. In the
+# general case it only serves to obscure the useful output about what actually
+# was included.
+case ${boards_origin} in
+"command line")
+	print_skipped=1
+	;;
+environment*)
+	print_skipped=1
+	;;
+*)
+	print_skipped=0
+	;;
+esac
+
+for board in $@; do
+	board_cfg="arch/mips/configs/generic/board-${board}.config"
+	if [ ! -f "${board_cfg}" ]; then
+		echo "WARNING: Board config '${board_cfg}' not found"
+		continue
+	fi
+
+	# For each line beginning with # require, cut out the field following
+	# it & search for that in the reference config file. If the requirement
+	# is not found then the subshell will exit with code 1, and we'll
+	# continue on to the next board.
+	grep -E '^# require ' "${board_cfg}" | \
+	    cut -d' ' -f 3- | \
+	    while read req; do
+		case ${req} in
+		*=y)
+			# If we require something =y then we check that a line
+			# containing it is present in the reference config.
+			grep -Eq "^${req}\$" "${ref_cfg}" && continue
+			;;
+		*=n)
+			# If we require something =n then we just invert that
+			# check, considering the requirement met if there isn't
+			# a line containing the value =y in the reference
+			# config.
+			grep -Eq "^${req/%=n/=y}\$" "${ref_cfg}" || continue
+			;;
+		*)
+			echo "WARNING: Unhandled requirement '${req}'"
+			;;
+		esac
+
+		[ ${print_skipped} -eq 1 ] && echo "Skipping ${board_cfg}"
+		exit 1
+	done || continue
+
+	# Merge this board config fragment into our final config file
+	./scripts/kconfig/merge_config.sh \
+		-m -O ${objtree} ${cfg} ${board_cfg} \
+		| grep -Ev '^(#|Using)'
+done
-- 
2.14.0
