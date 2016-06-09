Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:26:53 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:35370 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041488AbcFIVUdjHVkE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:20:33 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7NQ-0005Z0-KF; Thu, 09 Jun 2016 21:20:32 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7NN-0006LJ-Ul; Thu, 09 Jun 2016 14:20:29 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org,
        john@phrozen.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 190/206] MIPS: BMIPS: Adjust mips-hpt-frequency for BCM7435
Date:   Thu,  9 Jun 2016 14:16:39 -0700
Message-Id: <1465507015-23052-191-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit 80fa40acaa1dad5a0a9c15ed2e5d2e72461843f5 upstream.

The CPU actually runs at 1405Mhz which gives us a 175625000 Hz MIPS timer
frequency (CPU frequency / 8).

Fixes: e4c7d009654a ("MIPS: BMIPS: Add BCM7435 dtsi")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: john@phrozen.org
Cc: cernekee@gmail.com
Cc: jaedon.shin@gmail.com
Patchwork: https://patchwork.linux-mips.org/patch/13132/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 8b9432c..27b2b8e 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -7,7 +7,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		mips-hpt-frequency = <163125000>;
+		mips-hpt-frequency = <175625000>;
 
 		cpu@0 {
 			compatible = "brcm,bmips5200";
-- 
2.7.4
