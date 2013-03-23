Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:28:59 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1530 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834954Ab3CWS0ioNDhQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 19:26:38 +0100
Received: from [10.9.208.55] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 23 Mar 2013 11:22:04 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 23 Mar 2013 11:26:24 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 23 Mar 2013 11:26:24 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 604333928A; Sat, 23
 Mar 2013 11:26:23 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 9/9] MIPS: Netlogic: Fix oprofile compile on XLR
 uniprocessor
Date:   Sat, 23 Mar 2013 23:58:01 +0530
Message-ID: <f0a97197480a23f447bc5e135c4ffb46eb8ab0ba.1364062916.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1364062916.git.jchandra@broadcom.com>
References: <cover.1364062916.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D532D463A01621517-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35959
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

cpu_logical_map is only defined if CONFIG_SMP is set, so use it
only when compiling for SMP.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/oprofile/op_model_mipsxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 1fd3614..e4b1140 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -41,7 +41,7 @@ static int (*save_perf_irq)(void);
  * first hardware thread in the core for setup and init.
  * Skip CPUs with non-zero hardware thread id (4 hwt per core)
  */
-#ifdef CONFIG_CPU_XLR
+#if defined(CONFIG_CPU_XLR) && defined(CONFIG_SMP)
 #define oprofile_skip_cpu(c)	((cpu_logical_map(c) & 0x3) != 0)
 #else
 #define oprofile_skip_cpu(c)	0
-- 
1.7.9.5
