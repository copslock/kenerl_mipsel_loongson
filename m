Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 17:18:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10775 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012367AbcBCQSbbGiJQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 17:18:31 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id A74484D551BE4;
        Wed,  3 Feb 2016 16:18:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 16:18:25 +0000
Received: from localhost (10.100.200.164) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 16:18:24 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/3] MIPS: Add M6250 cases to CPU switch statements
Date:   Wed, 3 Feb 2016 16:17:29 +0000
Message-ID: <1454516250-9395-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454516250-9395-1-git-send-email-paul.burton@imgtec.com>
References: <1454516250-9395-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.164]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51702
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

Add casses supporting the M6250 CPU to various switch statements in the
core MIPS kernel code that define behaviour dependent upon the CPU.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/cpu-type.h | 4 ++++
 arch/mips/mm/c-r4k.c             | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 2cb0979..fbe1881 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -77,6 +77,10 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	 */
 #endif
 
+#ifdef CONFIG_SYS_HAS_CPU_MIPS32_R6
+	case CPU_M6250:
+#endif
+
 #ifdef CONFIG_SYS_HAS_CPU_MIPS64_R6
 	case CPU_I6400:
 	case CPU_P6600:
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 2f47999..141161a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1279,6 +1279,7 @@ static void probe_pcache(void)
 	case CPU_QEMU_GENERIC:
 	case CPU_I6400:
 	case CPU_P6600:
+	case CPU_M6250:
 		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
 		    (c->icache.waysize > PAGE_SIZE))
 			c->icache.flags |= MIPS_CACHE_ALIASES;
-- 
2.7.0
