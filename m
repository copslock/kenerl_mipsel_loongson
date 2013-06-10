Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:43:51 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4718 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827461Ab3FJHkIprT9T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:40:08 +0200
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:36:14 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:39:53 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:39:53 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id CB947F2D73; Mon, 10
 Jun 2013 00:39:52 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 04/11] MIPS: Netlogic: Add nlm_get_boot_data() helper
Date:   Mon, 10 Jun 2013 13:11:03 +0530
Message-ID: <1370850070-5127-5-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
References: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5E6431W33902849-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

This moves the calculation and casting needed to access the CPU initialization
data to a function nlm_get_boot_data()

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/common.h |   11 ++++++++---
 arch/mips/netlogic/common/smp.c         |    6 +++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index d4ede12..1b54adb 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -59,13 +59,18 @@ int nlm_wakeup_secondary_cpus(void);
 void nlm_rmiboot_preboot(void);
 void nlm_percpu_init(int hwcpuid);
 
+static inline void *
+nlm_get_boot_data(int offset)
+{
+	return (void *)(CKSEG1ADDR(RESET_DATA_PHYS) + offset);
+}
+
 static inline void
 nlm_set_nmi_handler(void *handler)
 {
-	char *reset_data;
+	void *nmih = nlm_get_boot_data(BOOT_NMI_HANDLER);
 
-	reset_data = (char *)CKSEG1ADDR(RESET_DATA_PHYS);
-	*(int64_t *)(reset_data + BOOT_NMI_HANDLER) = (long)handler;
+	*(int64_t *)nmih = (long)handler;
 }
 
 /*
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index da3d3bc..1f66eef 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -254,15 +254,15 @@ unsupp:
 
 int __cpuinit nlm_wakeup_secondary_cpus(void)
 {
-	char *reset_data;
+	u32 *reset_data;
 	int threadmode;
 
 	/* verify the mask and setup core config variables */
 	threadmode = nlm_parse_cpumask(&nlm_cpumask);
 
 	/* Setup CPU init parameters */
-	reset_data = (char *)CKSEG1ADDR(RESET_DATA_PHYS);
-	*(int *)(reset_data + BOOT_THREAD_MODE) = threadmode;
+	reset_data = nlm_get_boot_data(BOOT_THREAD_MODE);
+	*reset_data = threadmode;
 
 #ifdef CONFIG_CPU_XLP
 	xlp_wakeup_secondary_cpus();
-- 
1.7.9.5
