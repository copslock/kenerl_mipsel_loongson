Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 11:20:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:49279 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823009AbaCXKULXe3I7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 11:20:11 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 07883458888E1
        for <linux-mips@linux-mips.org>; Mon, 24 Mar 2014 10:20:04 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:20:05 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:20:04 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 02/12] MIPS: provide empty mips_mt_set_cpuoptions when CONFIG_MIPS_MT=n
Date:   Mon, 24 Mar 2014 10:19:25 +0000
Message-ID: <1395656375-9300-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
References: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39562
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

Both the CONFIG_MIPS_CPS & CONFIG_MIPS_CMP SMP implementations call
mips_mt_set_cpuoptions when preparing to start secondary CPUs. However
both may be used without MT. Provide an empty inline function to prevent
a link error in this case.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mips_mt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/mips_mt.h b/arch/mips/include/asm/mips_mt.h
index ac79352..a3df0c3 100644
--- a/arch/mips/include/asm/mips_mt.h
+++ b/arch/mips/include/asm/mips_mt.h
@@ -18,7 +18,12 @@ extern cpumask_t mt_fpu_cpumask;
 extern unsigned long mt_fpemul_threshold;
 
 extern void mips_mt_regdump(unsigned long previous_mvpcontrol_value);
+
+#ifdef CONFIG_MIPS_MT
 extern void mips_mt_set_cpuoptions(void);
+#else
+static inline void mips_mt_set_cpuoptions(void) { }
+#endif
 
 struct class;
 extern struct class *mt_class;
-- 
1.8.5.3
