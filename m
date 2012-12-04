Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2012 00:57:02 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:33046 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831649Ab2LDXzaQuwwy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Dec 2012 00:55:30 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qB4Nt9j4014727;
        Tue, 4 Dec 2012 15:55:13 -0800
X-WSS-ID: 0MEJ6FV-01-0P3-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2D3AE364679;
        Tue,  4 Dec 2012 15:55:06 -0800 (PST)
Received: from fun-lab.mips.com (192.168.52.61) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Tue, 4 Dec 2012
 15:55:01 -0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>, <macro@linux-mips.org>, <john@phrozen.org>
CC:     <dczhu@mips.com>
Subject: [PATCH v3 4/5] MIPS: let amon_cpu_start() report results
Date:   Tue, 4 Dec 2012 15:54:31 -0800
Message-ID: <1354665272-22759-5-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1354665272-22759-1-git-send-email-dczhu@mips.com>
References: <1354665272-22759-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: 9bFc4MSoXsHwgecOv69Vwg==
X-archive-position: 35183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
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

Change the return type of amon_cpu_start() from void to int.

Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
---
 arch/mips/include/asm/amon.h     |    2 +-
 arch/mips/mti-malta/malta-amon.c |    8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/amon.h b/arch/mips/include/asm/amon.h
index c3dc1a6..c8af6b0 100644
--- a/arch/mips/include/asm/amon.h
+++ b/arch/mips/include/asm/amon.h
@@ -3,5 +3,5 @@
  */
 
 int amon_cpu_avail(int);
-void amon_cpu_start(int, unsigned long, unsigned long,
+int amon_cpu_start(int, unsigned long, unsigned long,
 		    unsigned long, unsigned long);
diff --git a/arch/mips/mti-malta/malta-amon.c b/arch/mips/mti-malta/malta-amon.c
index 469d9b0..fcd69cb 100644
--- a/arch/mips/mti-malta/malta-amon.c
+++ b/arch/mips/mti-malta/malta-amon.c
@@ -48,7 +48,7 @@ int amon_cpu_avail(int cpu)
 	return 1;
 }
 
-void amon_cpu_start(int cpu,
+int amon_cpu_start(int cpu,
 		    unsigned long pc, unsigned long sp,
 		    unsigned long gp, unsigned long a0)
 {
@@ -56,10 +56,10 @@ void amon_cpu_start(int cpu,
 		(struct cpulaunch  *)CKSEG0ADDR(CPULAUNCH);
 
 	if (!amon_cpu_avail(cpu))
-		return;
+		return -1;
 	if (cpu == smp_processor_id()) {
 		pr_debug("launch: I am cpu%d!\n", cpu);
-		return;
+		return -1;
 	}
 	launch += cpu;
 
@@ -78,4 +78,6 @@ void amon_cpu_start(int cpu,
 		;
 	smp_rmb();      /* Target will be updating flags soon */
 	pr_debug("launch: cpu%d gone!\n", cpu);
+
+	return 0;
 }
-- 
1.7.1
