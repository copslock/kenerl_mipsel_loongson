Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 13:49:00 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:48778 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008721AbcAWMs6v3w1I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2016 13:48:58 +0100
Received: from localhost.localdomain (unknown [78.54.16.94])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id BEACBA619E;
        Sat, 23 Jan 2016 13:47:17 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/4] MIPS: zboot: Fix the build with XZ compression on older GCC versions
Date:   Sat, 23 Jan 2016 13:48:15 +0100
Message-Id: <1453553326-26445-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Some older GCC version (at least 4.6) emits calls to __bswapsi2() when
building the XZ decompressor. The link of the compressed image then
fails with the following error:

arch/mips/boot/compressed/decompress.o: In function '__fswab32':
include/uapi/linux/swab.h:60: undefined reference to '__bswapsi2'

Add bswapsi.o to the link to fix the build with these versions.

Signed-off-by: Alban Bedel <albeu@free.fr>
CC: stable@vger.kernel.org # v4.4
---
Changelog:
v2: * Added CC to stable as the patch hasn't been merged in 4.4
---
 arch/mips/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index d5bdee1..45f8abb 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -41,7 +41,7 @@ vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
 endif
 
 ifdef CONFIG_KERNEL_XZ
-vmlinuzobjs-y += $(obj)/../../lib/ashldi3.o
+vmlinuzobjs-y += $(obj)/../../lib/ashldi3.o $(obj)/../../lib/bswapsi.o
 endif
 
 targets += vmlinux.bin
-- 
2.0.0
