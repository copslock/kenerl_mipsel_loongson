Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 19:44:31 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012214AbbHNRnKqk821 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 19:43:10 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9C7D8DC;
        Fri, 14 Aug 2015 17:43:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@openwrt.org>,
        linux-mips@linux-mips.org, abrestic@chromium.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.1 05/84] MIPS: Export get_c0_perfcount_int()
Date:   Fri, 14 Aug 2015 10:41:33 -0700
Message-Id: <20150814174210.376974649@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150814174210.214822912@linuxfoundation.org>
References: <20150814174210.214822912@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.1-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath79/setup.c          |    1 +
 arch/mips/lantiq/irq.c           |    1 +
 arch/mips/mti-malta/malta-time.c |    1 +
 arch/mips/mti-sead3/sead3-time.c |    1 +
 arch/mips/pistachio/time.c       |    1 +
 arch/mips/ralink/irq.c           |    1 +
 6 files changed, 6 insertions(+)

--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -186,6 +186,7 @@ int get_c0_perfcount_int(void)
 {
 	return ATH79_MISC_IRQ(5);
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -466,6 +466,7 @@ int get_c0_perfcount_int(void)
 {
 	return ltq_perfcount_irq;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -148,6 +148,7 @@ int get_c0_perfcount_int(void)
 
 	return mips_cpu_perf_irq;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -77,6 +77,7 @@ int get_c0_perfcount_int(void)
 		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 	return -1;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
--- a/arch/mips/pistachio/time.c
+++ b/arch/mips/pistachio/time.c
@@ -26,6 +26,7 @@ int get_c0_perfcount_int(void)
 {
 	return gic_get_c0_perfcount_int();
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 void __init plat_time_init(void)
 {
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -89,6 +89,7 @@ int get_c0_perfcount_int(void)
 {
 	return rt_perfcount_irq;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
