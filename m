Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 17:34:22 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:45921 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993877AbdDJPdvHG0-Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Apr 2017 17:33:51 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 060E7AAB1;
        Mon, 10 Apr 2017 15:33:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 008/142] MIPS: ip27: Disable qlge driver in defconfig
Date:   Mon, 10 Apr 2017 17:31:29 +0200
Message-Id: <ef3f3ada78e973745352c9e765028e41397a44f0.1491838390.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <d4b83d12d815bafc24064e91de353edb2478d8f7.1491838390.git.jslaby@suse.cz>
References: <d4b83d12d815bafc24064e91de353edb2478d8f7.1491838390.git.jslaby@suse.cz>
In-Reply-To: <cover.1491838390.git.jslaby@suse.cz>
References: <cover.1491838390.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Arnd Bergmann <arnd@arndb.de>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit b617649468390713db1515ea79fc772d2eb897a8 upstream.

One of the last remaining failures in kernelci.org is for a gcc bug:

drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not satisfy its constraints:
drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler error: in extract_constrain_insn, at recog.c:2190

This is apparently broken in gcc-6 but fixed in gcc-7, and I cannot
reproduce the problem here. However, it is clear that ip27_defconfig
does not actually need this driver as the platform has only PCI-X but
not PCIe, and the qlge adapter in turn is PCIe-only.

The driver was originally enabled in 2010 along with lots of other
drivers.

Fixes: 59d302b342e5 ("MIPS: IP27: Make defconfig useful again.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15197/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/configs/ip27_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 0e36abcd39cc..7446284dd7b3 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -206,7 +206,6 @@ CONFIG_MLX4_EN=m
 # CONFIG_MLX4_DEBUG is not set
 CONFIG_TEHUTI=m
 CONFIG_BNX2X=m
-CONFIG_QLGE=m
 CONFIG_SFC=m
 CONFIG_BE2NET=m
 CONFIG_LIBERTAS_THINFIRM=m
-- 
2.12.2
