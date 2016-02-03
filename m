Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:20:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64126 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011289AbcBCDTsiocj0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:19:48 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 863C625062F5E;
        Wed,  3 Feb 2016 03:19:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:19:42 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:19:42 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 14/15] MIPS: smp-cps: Add nothreads kernel parameter
Date:   Wed, 3 Feb 2016 03:15:34 +0000
Message-ID: <1454469335-14778-15-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51642
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

When debugging a new system or core it can be useful to disable the use
of multithreading. Introduce a "nothreads" kernel command line parameter
that can be set in order to do so.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/smp-cps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 27f1c04..23c29fc 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -27,14 +27,25 @@
 #include <asm/time.h>
 #include <asm/uasm.h>
 
+static bool threads_disabled;
 static DECLARE_BITMAP(core_power, NR_CPUS);
 
 struct core_boot_config *mips_cps_core_bootcfg;
 
+static int __init setup_nothreads(char *s)
+{
+	threads_disabled = true;
+	return 0;
+}
+early_param("nothreads", setup_nothreads);
+
 static unsigned core_vpe_count(unsigned core)
 {
 	unsigned cfg;
 
+	if (threads_disabled)
+		return 1;
+
 	if ((!config_enabled(CONFIG_MIPS_MT_SMP) || !cpu_has_mipsmt)
 		&& (!config_enabled(CONFIG_CPU_MIPSR6) || !cpu_has_vp))
 		return 1;
-- 
2.7.0
