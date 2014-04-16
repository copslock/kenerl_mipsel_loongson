Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:04:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:34916 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837165AbaDPNCWG4P82 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 15:02:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B322062B56C0B
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 14:02:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 14:02:15 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 14:02:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 27/39] MIPS: smp-cps: function to determine whether CPS SMP is in use
Date:   Wed, 16 Apr 2014 13:53:18 +0100
Message-ID: <1397652810-4336-28-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The core power down state for cpuidle will require that the CPS SMP
implementation is in use. This patch provides a mips_cps_smp_in_use
function which determines whether or not the CPS SMP implementation is
currently in use.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/smp-cps.h | 2 ++
 arch/mips/kernel/smp-cps.c      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index d49279e..324df2c 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -31,6 +31,8 @@ extern void mips_cps_core_init(void);
 
 extern struct vpe_boot_config *mips_cps_boot_vpes(void);
 
+extern bool mips_cps_smp_in_use(void);
+
 #else /* __ASSEMBLY__ */
 
 .extern mips_cps_bootcfg;
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index af90e82..c7879fb 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -260,6 +260,12 @@ static struct plat_smp_ops cps_smp_ops = {
 	.cpus_done		= cps_cpus_done,
 };
 
+bool mips_cps_smp_in_use(void)
+{
+	extern struct plat_smp_ops *mp_ops;
+	return mp_ops == &cps_smp_ops;
+}
+
 int register_cps_smp_ops(void)
 {
 	if (!mips_cm_present()) {
-- 
1.8.5.3
