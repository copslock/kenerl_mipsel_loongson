Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 22:46:42 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:3912 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903726Ab2GMUqM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 22:46:12 +0200
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 13:45:12 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 13:45:56 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id CD7B49F9F5; Fri, 13
 Jul 2012 13:45:55 -0700 (PDT)
From:   "Al Cooper" <alcooperx@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
cc:     "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH 3/5] MIPS: perf: Remove unnecessary #ifdef
Date:   Fri, 13 Jul 2012 16:44:52 -0400
Message-ID: <1342212294-23014-3-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1342212294-23014-1-git-send-email-alcooperx@gmail.com>
References: <y> <1342212294-23014-1-git-send-email-alcooperx@gmail.com>
MIME-Version: 1.0
X-WSS-ID: 7C1E57523MK9973575-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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

The #ifdef for CONFIG_HW_PERF_EVENTS is not needed because the
Makefile will only compile the module if this config option is set.
This means that the code under #else would never be compiled. This
may have been done to leave the original broken code around for
reference, but the FIXME comment above the code already shows the
broken code.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 arch/mips/kernel/perf_event_mipsxx.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 4ee1111..19253d7 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -139,13 +139,8 @@ static DEFINE_RWLOCK(pmuint_rwlock);
  * FIXME: For VSMP, vpe_id() is redefined for Perf-events, because
  * cpu_data[cpuid].vpe_id reports 0 for _both_ CPUs.
  */
-#if defined(CONFIG_HW_PERF_EVENTS)
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
 			0 : smp_processor_id())
-#else
-#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			0 : cpu_data[smp_processor_id()].vpe_id)
-#endif
 
 /* Copied from op_model_mipsxx.c */
 static unsigned int vpe_shift(void)
-- 
1.7.6
