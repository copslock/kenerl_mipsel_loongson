Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Mar 2013 17:25:24 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4092 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820116Ab3CVQXnI1Ekg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Mar 2013 17:23:43 +0100
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 22 Mar 2013 09:16:32 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Fri, 22 Mar 2013 09:23:26 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Fri, 22 Mar 2013 09:23:26 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0EB5239289; Fri, 22
 Mar 2013 09:23:24 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 4/5] MIPS: Netlogic: rename nlm_cop2_save/restore
Date:   Fri, 22 Mar 2013 21:55:01 +0530
Message-ID: <dce8b9e8a4b590bcf5a2d57c3e53a58ada49f4f3.1363966534.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1363966534.git.jchandra@broadcom.com>
References: <cover.1363966534.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D525C6A3YC7240018-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35944
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Rename macro nlm_cop2_enable() to nlm_cop2_enable_irqsave() and the macro
nlm_cop2_restore to nlm_cop2_disable_irqrestore(). The new names will
reflect the functionality better, and will make nlm_cop2_restore()
available to be used later in COP2 save/restore patch.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlr/fmn.h |    4 ++--
 arch/mips/netlogic/xlr/fmn.c             |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlr/fmn.h b/arch/mips/include/asm/netlogic/xlr/fmn.h
index 90e1126..c4d6014 100644
--- a/arch/mips/include/asm/netlogic/xlr/fmn.h
+++ b/arch/mips/include/asm/netlogic/xlr/fmn.h
@@ -240,7 +240,7 @@ static inline void nlm_msgwait(unsigned int mask)
 /*
  * Disable interrupts and enable COP2 access
  */
-static inline uint32_t nlm_cop2_enable(void)
+static inline uint32_t nlm_cop2_enable_irqsave(void)
 {
 	uint32_t sr = read_c0_status();
 
@@ -248,7 +248,7 @@ static inline uint32_t nlm_cop2_enable(void)
 	return sr;
 }
 
-static inline void nlm_cop2_restore(uint32_t sr)
+static inline void nlm_cop2_disable_irq_restore(uint32_t sr)
 {
 	write_c0_status(sr);
 }
diff --git a/arch/mips/netlogic/xlr/fmn.c b/arch/mips/netlogic/xlr/fmn.c
index 0fdce61..ba3d6b8 100644
--- a/arch/mips/netlogic/xlr/fmn.c
+++ b/arch/mips/netlogic/xlr/fmn.c
@@ -74,7 +74,7 @@ static irqreturn_t fmn_message_handler(int irq, void *data)
 	struct nlm_fmn_msg msg;
 	uint32_t mflags, bkt_status;
 
-	mflags = nlm_cop2_enable();
+	mflags = nlm_cop2_enable_irqsave();
 	/* Disable message ring interrupt */
 	nlm_fmn_setup_intr(irq, 0);
 	while (1) {
@@ -97,16 +97,16 @@ static irqreturn_t fmn_message_handler(int irq, void *data)
 				pr_warn("No msgring handler for stnid %d\n",
 						src_stnid);
 			else {
-				nlm_cop2_restore(mflags);
+				nlm_cop2_disable_irq_restore(mflags);
 				hndlr->action(bucket, src_stnid, size, code,
 					&msg, hndlr->arg);
-				mflags = nlm_cop2_enable();
+				mflags = nlm_cop2_enable_irqsave();
 			}
 		}
 	};
 	/* Enable message ring intr, to any thread in core */
 	nlm_fmn_setup_intr(irq, (1 << nlm_threads_per_core) - 1);
-	nlm_cop2_restore(mflags);
+	nlm_cop2_disable_irq_restore(mflags);
 	return IRQ_HANDLED;
 }
 
@@ -128,7 +128,7 @@ void xlr_percpu_fmn_init(void)
 
 	bucket_sizes = xlr_board_fmn_config.bucket_size;
 	cpu_fmn_info = &xlr_board_fmn_config.cpu[id];
-	flags = nlm_cop2_enable();
+	flags = nlm_cop2_enable_irqsave();
 
 	/* Setup bucket sizes for the core. */
 	nlm_write_c2_bucksize(0, bucket_sizes[id * 8 + 0]);
@@ -166,7 +166,7 @@ void xlr_percpu_fmn_init(void)
 
 	/* enable FMN interrupts on this CPU */
 	nlm_fmn_setup_intr(IRQ_FMN, (1 << nlm_threads_per_core) - 1);
-	nlm_cop2_restore(flags);
+	nlm_cop2_disable_irq_restore(flags);
 }
 
 
@@ -198,7 +198,7 @@ void nlm_setup_fmn_irq(void)
 	/* setup irq only once */
 	setup_irq(IRQ_FMN, &fmn_irqaction);
 
-	flags = nlm_cop2_enable();
+	flags = nlm_cop2_enable_irqsave();
 	nlm_fmn_setup_intr(IRQ_FMN, (1 << nlm_threads_per_core) - 1);
-	nlm_cop2_restore(flags);
+	nlm_cop2_disable_irq_restore(flags);
 }
-- 
1.7.9.5
