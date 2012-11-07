Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2012 20:44:08 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:48615 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824768Ab2KGToHS0fj2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Nov 2012 20:44:07 +0100
Received: (qmail 1979 invoked from network); 7 Nov 2012 19:44:03 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 7 Nov 2012 19:44:03 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Wed, 07 Nov 2012 11:44:03 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: tlbex: Fix section mismatches
Date:   Wed, 07 Nov 2012 11:39:48 -0800
Message-Id: <9a08b5a0f8a4bf5d72913190a44bbea7@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 34918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The new functions introduced in commit 02a5417751 (MIPS: tlbex: Deal with
re-definition of label) should be marked __cpuinit, to eliminate a
warning that can pop up when CONFIG_EXPORT_UASM is disabled:

      LD      arch/mips/mm/built-in.o
    WARNING: arch/mips/mm/built-in.o(.text+0x2a4c): Section mismatch in reference from the function uasm_bgezl_hazard() to the function .cpuinit.text:uasm_il_bgezl()
    The function uasm_bgezl_hazard() references
    the function __cpuinit uasm_il_bgezl().
    This is often because uasm_bgezl_hazard lacks a __cpuinit
    annotation or the annotation of uasm_il_bgezl is wrong.

    WARNING: arch/mips/mm/built-in.o(.text+0x2a68): Section mismatch in reference from the function uasm_bgezl_label() to the function .cpuinit.text:uasm_build_label()
    The function uasm_bgezl_label() references
    the function __cpuinit uasm_build_label().
    This is often because uasm_bgezl_label lacks a __cpuinit
    annotation or the annotation of uasm_build_label is wrong.

(This warning might not occur if the function was inlined.)

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/tlbex.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 2d29f6a..8c7a360 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -183,7 +183,9 @@ UASM_L_LA(_tlb_huge_update)
 
 static int __cpuinitdata hazard_instance;
 
-static void uasm_bgezl_hazard(u32 **p, struct uasm_reloc **r, int instance)
+static void __cpuinit uasm_bgezl_hazard(u32 **p,
+					struct uasm_reloc **r,
+					int instance)
 {
 	switch (instance) {
 	case 0 ... 7:
@@ -194,7 +196,9 @@ static void uasm_bgezl_hazard(u32 **p, struct uasm_reloc **r, int instance)
 	}
 }
 
-static void uasm_bgezl_label(struct uasm_label **l, u32 **p, int instance)
+static void __cpuinit uasm_bgezl_label(struct uasm_label **l,
+				       u32 **p,
+				       int instance)
 {
 	switch (instance) {
 	case 0 ... 7:
-- 
1.7.11.1
