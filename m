Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2014 18:55:45 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:53403 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6869161AbaBNRznMnHgb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Feb 2014 18:55:43 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        "Matthew Fortune" <matthew.fortune@imgtec.com>
Subject: [PATCH] MIPS: mark O32+FP64 experimental for now
Date:   Fri, 14 Feb 2014 17:55:18 +0000
Message-ID: <1392400518-24928-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_02_14_17_55_37
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39306
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

Commit 597ce1723e0f "MIPS: Support for 64-bit FP with O32 binaries"
introduced support for setting Status.FR=1 for O32 binaries with the
EF_MIPS_FP64 ELF header flag set. Whilst this flag is currently
supported by binutils it does introduce an ABI break within userland.
Objects built with EF_MIPS_FP64 cannot be safely linked with those built
without it since code in either object may assume behaviour specific to
a value of FR.

More recently there has been discussion around avoiding further
fragmentation of the O32 ABI whilst still allowing the use of FR=1 and
features such as MSA which depend upon it. Details of the plan to allow
this are still being worked on, and whilst the kernel will need the
ability to handle FR=1 with O32 tasks it is unclear what else it may
need to provide to a userland which seeks to avoid another ABI break. In
order to prevent the proliferation of userland which may rely upon the
current EF_MIPS_FP64 behaviour this patch marks the kernel support for
it experimental & disables it by default. Under current proposals it is
likely that this support can simply be enabled again later, but possibly
after the introduction of further interfaces with userland and support
for the MIPS R5 UFR feature.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Matthew Fortune <matthew.fortune@imgtec.com>
---
Ralf: any chance this could get into v3.14 where the fp64 support is
introduced? Apologies for this, discussion around the ABI plan has
happened only very recently.
---
 arch/mips/Kconfig | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6f78eb3..a37c21f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2388,9 +2388,8 @@ config CC_STACKPROTECTOR
 	  This feature requires gcc version 4.2 or above.
 
 config MIPS_O32_FP64_SUPPORT
-	bool "Support for O32 binaries using 64-bit FP"
+	bool "Support for O32 binaries using 64-bit FP (EXPERIMENTAL)"
 	depends on 32BIT || MIPS32_O32
-	default y
 	help
 	  When this is enabled, the kernel will support use of 64-bit floating
 	  point registers with binaries using the O32 ABI along with the
@@ -2402,7 +2401,14 @@ config MIPS_O32_FP64_SUPPORT
 	  of your kernel & potentially improve FP emulation performance by
 	  saying N here.
 
-	  If unsure, say Y.
+	  Although binutils currently supports use of this flag the details
+	  concerning its effect upon the O32 ABI in userland are still being
+	  worked on. In order to avoid userland becoming dependant upon current
+	  behaviour before the details have been finalised, this option should
+	  be considered experimental and only enabled by those working upon
+	  said details.
+
+	  If unsure, say N.
 
 config USE_OF
 	bool
-- 
1.8.5.3
