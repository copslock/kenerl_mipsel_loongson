Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2012 20:12:32 +0100 (CET)
Received: from georges.telenet-ops.be ([195.130.137.68]:47161 "EHLO
        georges.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831900Ab2LFTMbCrOMd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Dec 2012 20:12:31 +0100
Received: from ayla.of.borg ([84.193.72.141])
        by georges.telenet-ops.be with bizsmtp
        id YKCS1k00Y32ts5g06KCSbZ; Thu, 06 Dec 2012 20:12:28 +0100
Received: from geert by ayla.of.borg with local (Exim 4.71)
        (envelope-from <geert@linux-m68k.org>)
        id 1Tggry-0001yS-HI; Thu, 06 Dec 2012 20:12:26 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] MIPS: Check BITS_PER_LONG instead of __SIZEOF_LONG__
Date:   Thu,  6 Dec 2012 20:12:17 +0100
Message-Id: <1354821137-7562-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.0.4
X-archive-position: 35198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

When building a 32-bit kernel for RBTX4927 with gcc version 4.1.2 20061115
(prerelease) (Ubuntu 4.1.1-21), I get:

arch/mips/lib/delay.c:24:5: warning: "__SIZEOF_LONG__" is not defined

As a consequence, __delay() always uses the 64-bit "dsubu" instruction.

Replace the check for "__SIZEOF_LONG__ == 4" by "BITS_PER_LONG == 32" to
fix this.

Introduced by commit 5210edcd527773c227465ad18e416a894966324f ("MIPS: Make
__{,n,u}delay declarations match definitions and generic delay.h")

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
--
Untested on real hardware.
Ralf, is this sufficient to prevent you from nuking RBTX4927 support? ;-)
---
 arch/mips/lib/delay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
index dc81ca8..288f795 100644
--- a/arch/mips/lib/delay.c
+++ b/arch/mips/lib/delay.c
@@ -21,7 +21,7 @@ void __delay(unsigned long loops)
 	"	.set	noreorder				\n"
 	"	.align	3					\n"
 	"1:	bnez	%0, 1b					\n"
-#if __SIZEOF_LONG__ == 4
+#if BITS_PER_LONG == 32
 	"	subu	%0, 1					\n"
 #else
 	"	dsubu	%0, 1					\n"
-- 
1.7.0.4
