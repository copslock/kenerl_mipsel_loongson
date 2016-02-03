Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:18:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18814 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009953AbcBCDRvPg0D0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:17:51 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 5EE977F1F1814;
        Wed,  3 Feb 2016 03:17:44 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:17:45 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:17:44 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 06/15] MIPS: CM: Fix mips_cm_max_vp_width for UP kernels
Date:   Wed, 3 Feb 2016 03:15:26 +0000
Message-ID: <1454469335-14778-7-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 51634
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

Fix mips_cm_max_vp_width for UP kernels where it previously referenced
smp_num_siblings, which is not declared for UP kernels. This led to
build errors such as the following:

  drivers/built-in.o: In function `$L446':
  irq-mips-gic.c:(.text+0x1994): undefined reference to `smp_num_siblings'
  drivers/built-in.o:irq-mips-gic.c:(.text+0x199c): more undefined references to `smp_num_siblings' follow

On UP kernels simply return 1, leaving the reference to smp_num_siblings
in place only for SMP kernels.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/mips-cm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 1395bbc..3fdb6c9 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -462,7 +462,10 @@ static inline unsigned int mips_cm_max_vp_width(void)
 	if (mips_cm_revision() >= CM_REV_CM3)
 		return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW_MSK;
 
-	return smp_num_siblings;
+	if (config_enabled(CONFIG_SMP))
+		return smp_num_siblings;
+
+	return 1;
 }
 
 /**
-- 
2.7.0
