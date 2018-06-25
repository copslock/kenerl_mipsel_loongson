Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 19:17:47 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:57970 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992943AbeFYRQBy3Vsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jun 2018 19:16:01 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 05/25] MIPS: ath79: Avoid using unitialized 'reg' variable
Date:   Mon, 25 Jun 2018 19:15:29 +0200
Message-Id: <20180625171549.4618-6-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625171549.4618-1-john@phrozen.org>
References: <20180625171549.4618-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

From: Markos Chandras <markos.chandras@imgtec.com>

Fixes the following build error:
arch/mips/include/asm/mach-ath79/ath79.h:139:20: error: 'reg' may be used
uninitialized in this function [-Werror=maybe-uninitialized]
arch/mips/ath79/common.c:62:6: note: 'reg' was declared here
In file included from arch/mips/ath79/common.c:20:0:
arch/mips/ath79/common.c: In function 'ath79_device_reset_clear':
arch/mips/include/asm/mach-ath79/ath79.h:139:20:
error: 'reg' may be used uninitialized in this function
[-Werror=maybe-uninitialized]
arch/mips/ath79/common.c:90:6: note: 'reg' was declared here

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index cd6055f9e7a0..fc3438150b3e 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -110,7 +110,7 @@ void ath79_device_reset_set(u32 mask)
 	else if (soc_is_qca956x() || soc_is_tp9343())
 		reg = QCA956X_RESET_REG_RESET_MODULE;
 	else
-		BUG();
+		panic("Reset register not defined for this SOC");
 
 	spin_lock_irqsave(&ath79_device_reset_lock, flags);
 	t = ath79_reset_rr(reg);
@@ -142,7 +142,7 @@ void ath79_device_reset_clear(u32 mask)
 	else if (soc_is_qca956x() || soc_is_tp9343())
 		reg = QCA956X_RESET_REG_RESET_MODULE;
 	else
-		BUG();
+		panic("Reset register not defined for this SOC");
 
 	spin_lock_irqsave(&ath79_device_reset_lock, flags);
 	t = ath79_reset_rr(reg);
-- 
2.11.0
