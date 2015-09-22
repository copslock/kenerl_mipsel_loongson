Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:54:48 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:53228 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008802AbbIVRxiVZ7qU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:53:38 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZeRl3-0000vq-OR; Tue, 22 Sep 2015 17:53:37 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZeRl1-0000bt-HV; Tue, 22 Sep 2015 10:53:35 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Felix Fietkau <nbd@openwrt.org>, linux-mips@linux-mips.org,
        abrestic@chromium.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 034/102] MIPS: Export get_c0_perfcount_int()
Date:   Tue, 22 Sep 2015 10:51:30 -0700
Message-Id: <1442944358-1248-35-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1442944358-1248-1-git-send-email-kamal@canonical.com>
References: <1442944358-1248-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt7 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@openwrt.org>

commit 0cb0985f57783c2f3c6c8ffe7e7665e80c56bd92 upstream.

get_c0_perfcount_int is tested from oprofile code. If oprofile is
compiled as module, get_c0_perfcount_int needs to be exported, otherwise
it cannot be resolved.

Fixes: a669efc4a3b4 ("MIPS: Add hook to get C0 performance counter interrupt")
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: abrestic@chromium.org
Patchwork: https://patchwork.linux-mips.org/patch/10763/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ kamal: backport to 3.19-stable: no pistachio/time.c ]
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/ath79/setup.c          | 1 +
 arch/mips/lantiq/irq.c           | 1 +
 arch/mips/mti-malta/malta-time.c | 1 +
 arch/mips/mti-sead3/sead3-time.c | 1 +
 arch/mips/ralink/irq.c           | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index a73c93c..c0277e9 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -186,6 +186,7 @@ int get_c0_perfcount_int(void)
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
index 644ecce..a6cc3ef 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -130,6 +130,7 @@ int get_c0_perfcount_int(void)
 
 	return mips_cpu_perf_irq;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
index ec1dd24..90e303e 100644
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -77,6 +77,7 @@ int get_c0_perfcount_int(void)
 		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 	return -1;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 7cf91b9..199ace4 100644
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
1.9.1
