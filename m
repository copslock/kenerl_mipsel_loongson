Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 18:39:28 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994728AbeC0QjSzKxze (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 18:39:18 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 402021057;
        Tue, 27 Mar 2018 16:39:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neil@brown.name>,
        Matt Redfearn <matt.redfearn@mips.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 002/105] MIPS: ralink: Fix booting on MT7621
Date:   Tue, 27 Mar 2018 18:26:42 +0200
Message-Id: <20180327162757.916740121@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit a63d706ea719190a79a6c769e898f70680044d3e upstream.

Since commit 3af5a67c86a3 ("MIPS: Fix early CM probing") the MT7621 has
not been able to boot.

This commit caused mips_cm_probe() to be called before
mt7621.c::proc_soc_init().

prom_soc_init() has a comment explaining that mips_cm_probe() "wipes out
the bootloader config" and means that configuration registers are no
longer available. It has some code to re-enable this config.

Before this re-enable code is run, the sysc register cannot be read, so
when SYSC_REG_CHIP_NAME0 is read, a garbage value is returned and
panic() is called.

If we move the config-repair code to the top of prom_soc_init(), the
registers can be read and boot can proceed.

Very occasionally, the first register read after the reconfiguration
returns garbage, so add a call to __sync().

Fixes: 3af5a67c86a3 ("MIPS: Fix early CM probing")
Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.5+
Patchwork: https://patchwork.linux-mips.org/patch/18859/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/mt7621.c |   42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -170,6 +170,28 @@ void prom_soc_init(struct ralink_soc_inf
 	u32 n1;
 	u32 rev;
 
+	/* Early detection of CMP support */
+	mips_cm_probe();
+	mips_cpc_probe();
+
+	if (mips_cps_numiocu(0)) {
+		/*
+		 * mips_cm_probe() wipes out bootloader
+		 * config for CM regions and we have to configure them
+		 * again. This SoC cannot talk to pamlbus devices
+		 * witout proper iocu region set up.
+		 *
+		 * FIXME: it would be better to do this with values
+		 * from DT, but we need this very early because
+		 * without this we cannot talk to pretty much anything
+		 * including serial.
+		 */
+		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
+		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
+				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
+		__sync();
+	}
+
 	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
 	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
 
@@ -194,26 +216,6 @@ void prom_soc_init(struct ralink_soc_inf
 
 	rt2880_pinmux_data = mt7621_pinmux_data;
 
-	/* Early detection of CMP support */
-	mips_cm_probe();
-	mips_cpc_probe();
-
-	if (mips_cps_numiocu(0)) {
-		/*
-		 * mips_cm_probe() wipes out bootloader
-		 * config for CM regions and we have to configure them
-		 * again. This SoC cannot talk to pamlbus devices
-		 * witout proper iocu region set up.
-		 *
-		 * FIXME: it would be better to do this with values
-		 * from DT, but we need this very early because
-		 * without this we cannot talk to pretty much anything
-		 * including serial.
-		 */
-		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
-		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
-				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
-	}
 
 	if (!register_cps_smp_ops())
 		return;
