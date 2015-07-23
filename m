Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 18:59:56 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:60184
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010659AbbGWQ7xxswMj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jul 2015 18:59:53 +0200
Received: by nf.local (Postfix, from userid 501)
        id 90A7CF2D156E; Thu, 23 Jul 2015 18:59:52 +0200 (CEST)
From:   Felix Fietkau <nbd@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     abrestic@chromium.org, ralf@linux-mips.org
Subject: [PATCH] MIPS: export get_c0_perfcount_int()
Date:   Thu, 23 Jul 2015 18:59:52 +0200
Message-Id: <1437670792-6755-1-git-send-email-nbd@openwrt.org>
X-Mailer: git-send-email 2.2.2
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
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

get_c0_perfcount_int is tested from oprofile code. If oprofile is
compiled as module, get_c0_perfcount_int needs to be exported, otherwise
it cannot be resolved.

Fixes: a669efc4a3b4 ("MIPS: Add hook to get C0 performance counter interrupt")
Cc: stable@vger.kernel.org # v3.19+
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 arch/mips/ath79/setup.c          | 1 +
 arch/mips/lantiq/irq.c           | 1 +
 arch/mips/mti-malta/malta-time.c | 1 +
 arch/mips/mti-sead3/sead3-time.c | 1 +
 arch/mips/pistachio/time.c       | 1 +
 arch/mips/ralink/irq.c           | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 01a644f..1ba2120 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -190,6 +190,7 @@ int get_c0_perfcount_int(void)
 {
 	return ATH79_MISC_IRQ(5);
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 6ab1057..d01ade6 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -466,6 +466,7 @@ int get_c0_perfcount_int(void)
 {
 	return ltq_perfcount_irq;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 5625b19..e1bd9ed 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -154,6 +154,7 @@ int get_c0_perfcount_int(void)
 
 	return mips_cpu_perf_irq;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
index e1d6989..a120b7a 100644
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -77,6 +77,7 @@ int get_c0_perfcount_int(void)
 		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 	return -1;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
diff --git a/arch/mips/pistachio/time.c b/arch/mips/pistachio/time.c
index 7c73fcb..8a37734 100644
--- a/arch/mips/pistachio/time.c
+++ b/arch/mips/pistachio/time.c
@@ -26,6 +26,7 @@ int get_c0_perfcount_int(void)
 {
 	return gic_get_c0_perfcount_int();
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 int get_c0_fdc_int(void)
 {
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 53707aa..8c624a8 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -89,6 +89,7 @@ int get_c0_perfcount_int(void)
 {
 	return rt_perfcount_irq;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
-- 
2.2.2
