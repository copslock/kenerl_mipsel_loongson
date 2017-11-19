Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2017 15:42:45 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:55886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993035AbdKSOld41Pxi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2017 15:41:33 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60B0E40A;
        Sun, 19 Nov 2017 14:41:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.9 54/72] MIPS: traps: Ensure L1 & L2 ECC checking match for CM3 systems
Date:   Sun, 19 Nov 2017 15:38:58 +0100
Message-Id: <20171119143534.588743686@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171119143532.376035495@linuxfoundation.org>
References: <20171119143532.376035495@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61016
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>


[ Upstream commit 35e6de38858f59b6b65dcfeaf700b5d06fc2b93d ]

On systems with CM3, we must ensure that the L1 & L2 ECC enables are set
to the same value. This is presumed by the hardware & cache corruption
can occur when it is not the case. Support enabling & disabling the L2
ECC checking on CM3 systems where this is controlled via a GCR, and
ensure that it matches the state of L1 ECC checking. Remove I6400 from
the switch statement it will no longer hit, and which was incorrect
since the L2 ECC enable bit isn't in the CP0 ErrCtl register.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14413/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/mips-cm.h |    7 ++++
 arch/mips/kernel/traps.c        |   63 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 3 deletions(-)

--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -187,6 +187,7 @@ BUILD_CM_R_(config,		MIPS_CM_GCB_OFS + 0
 BUILD_CM_RW(base,		MIPS_CM_GCB_OFS + 0x08)
 BUILD_CM_RW(access,		MIPS_CM_GCB_OFS + 0x20)
 BUILD_CM_R_(rev,		MIPS_CM_GCB_OFS + 0x30)
+BUILD_CM_RW(err_control,	MIPS_CM_GCB_OFS + 0x38)
 BUILD_CM_RW(error_mask,		MIPS_CM_GCB_OFS + 0x40)
 BUILD_CM_RW(error_cause,	MIPS_CM_GCB_OFS + 0x48)
 BUILD_CM_RW(error_addr,		MIPS_CM_GCB_OFS + 0x50)
@@ -266,6 +267,12 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 #define CM_REV_CM2_5				CM_ENCODE_REV(7, 0)
 #define CM_REV_CM3				CM_ENCODE_REV(8, 0)
 
+/* GCR_ERR_CONTROL register fields */
+#define CM_GCR_ERR_CONTROL_L2_ECC_EN_SHF	1
+#define CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK	(_ULCAST_(0x1) << 1)
+#define CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT_SHF	0
+#define CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT_MSK	(_ULCAST_(0x1) << 0)
+
 /* GCR_ERROR_CAUSE register fields */
 #define CM_GCR_ERROR_CAUSE_ERRTYPE_SHF		27
 #define CM_GCR_ERROR_CAUSE_ERRTYPE_MSK		(_ULCAST_(0x1f) << 27)
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -51,6 +51,7 @@
 #include <asm/idle.h>
 #include <asm/mips-cm.h>
 #include <asm/mips-r2-to-r6-emul.h>
+#include <asm/mips-cm.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/module.h>
@@ -1646,6 +1647,65 @@ __setup("nol2par", nol2parity);
  */
 static inline void parity_protection_init(void)
 {
+#define ERRCTL_PE	0x80000000
+#define ERRCTL_L2P	0x00800000
+
+	if (mips_cm_revision() >= CM_REV_CM3) {
+		ulong gcr_ectl, cp0_ectl;
+
+		/*
+		 * With CM3 systems we need to ensure that the L1 & L2
+		 * parity enables are set to the same value, since this
+		 * is presumed by the hardware engineers.
+		 *
+		 * If the user disabled either of L1 or L2 ECC checking,
+		 * disable both.
+		 */
+		l1parity &= l2parity;
+		l2parity &= l1parity;
+
+		/* Probe L1 ECC support */
+		cp0_ectl = read_c0_ecc();
+		write_c0_ecc(cp0_ectl | ERRCTL_PE);
+		back_to_back_c0_hazard();
+		cp0_ectl = read_c0_ecc();
+
+		/* Probe L2 ECC support */
+		gcr_ectl = read_gcr_err_control();
+
+		if (!(gcr_ectl & CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT_MSK) ||
+		    !(cp0_ectl & ERRCTL_PE)) {
+			/*
+			 * One of L1 or L2 ECC checking isn't supported,
+			 * so we cannot enable either.
+			 */
+			l1parity = l2parity = 0;
+		}
+
+		/* Configure L1 ECC checking */
+		if (l1parity)
+			cp0_ectl |= ERRCTL_PE;
+		else
+			cp0_ectl &= ~ERRCTL_PE;
+		write_c0_ecc(cp0_ectl);
+		back_to_back_c0_hazard();
+		WARN_ON(!!(read_c0_ecc() & ERRCTL_PE) != l1parity);
+
+		/* Configure L2 ECC checking */
+		if (l2parity)
+			gcr_ectl |= CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK;
+		else
+			gcr_ectl &= ~CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK;
+		write_gcr_err_control(gcr_ectl);
+		gcr_ectl = read_gcr_err_control();
+		gcr_ectl &= CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK;
+		WARN_ON(!!gcr_ectl != l2parity);
+
+		pr_info("Cache parity protection %sabled\n",
+			l1parity ? "en" : "dis");
+		return;
+	}
+
 	switch (current_cpu_type()) {
 	case CPU_24K:
 	case CPU_34K:
@@ -1656,11 +1716,8 @@ static inline void parity_protection_ini
 	case CPU_PROAPTIV:
 	case CPU_P5600:
 	case CPU_QEMU_GENERIC:
-	case CPU_I6400:
 	case CPU_P6600:
 		{
-#define ERRCTL_PE	0x80000000
-#define ERRCTL_L2P	0x00800000
 			unsigned long errctl;
 			unsigned int l1parity_present, l2parity_present;
 
