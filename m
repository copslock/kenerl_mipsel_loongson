Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jul 2013 19:14:45 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:3044 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835041Ab3GXROfCOEiX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jul 2013 19:14:35 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 24 Jul 2013 09:08:36 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 24 Jul 2013 09:12:23 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 24 Jul 2013 09:12:23 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsb-10.bri.broadcom.com [10.178.7.10]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id A6A85F2D73; Wed, 24
 Jul 2013 09:12:22 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        blogic@openwrt.org, "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 2/2] MIPS: BMIPS: fix slave CPU booting when physical
 CPU is not 0
Date:   Wed, 24 Jul 2013 17:12:11 +0100
Message-ID: <1374682331-14171-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1374682331-14171-1-git-send-email-f.fainelli@gmail.com>
References: <1374682331-14171-1-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
X-WSS-ID: 7DF1238E31W55346927-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Florian Fainelli <florian@openwrt.org>

The current BMIPS SMP code assumes that the slave CPU is physical and
logical CPU 1, but on some systems such as BCM3368, the slave CPU is
physical CPU0. Fix the code to read the physical CPU (thread ID) we are
running this code on, and adjust the relocation vector address based on
it. This allows bringing up the second CPU on BCM3368 for instance.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/kernel/bmips_vec.S |  6 +++++-
 arch/mips/kernel/smp-bmips.c | 10 ++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index f739aed..bd79c4f 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -54,7 +54,11 @@ LEAF(bmips_smp_movevec)
 	/* set up CPU1 CBR; move BASE to 0xa000_0000 */
 	li	k0, 0xff400000
 	mtc0	k0, $22, 6
-	li	k1, CKSEG1 | BMIPS_RELO_VECTOR_CONTROL_1
+	/* set up relocation vector address based on thread ID */
+	mfc0	k1, $22, 3
+	srl	k1, 16
+	andi	k1, 0x8000
+	or	k1, CKSEG1 | BMIPS_RELO_VECTOR_CONTROL_0
 	or	k0, k1
 	li	k1, 0xa0080000
 	sw	k1, 0(k0)
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 89417c9..159abc8 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -196,9 +196,15 @@ static void bmips_init_secondary(void)
 #if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
 	void __iomem *cbr = BMIPS_GET_CBR();
 	unsigned long old_vec;
+	unsigned long relo_vector;
+	int boot_cpu;
 
-	old_vec = __raw_readl(cbr + BMIPS_RELO_VECTOR_CONTROL_1);
-	__raw_writel(old_vec & ~0x20000000, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+	boot_cpu = !!(read_c0_brcm_cmt_local() & (1 << 31));
+	relo_vector = boot_cpu ? BMIPS_RELO_VECTOR_CONTROL_0 :
+			  BMIPS_RELO_VECTOR_CONTROL_1;
+
+	old_vec = __raw_readl(cbr + relo_vector);
+	__raw_writel(old_vec & ~0x20000000, cbr + relo_vector);
 
 	clear_c0_cause(smp_processor_id() ? C_SW1 : C_SW0);
 #elif defined(CONFIG_CPU_BMIPS5000)
-- 
1.8.1.2
