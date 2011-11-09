Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 21:05:18 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:40924 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904273Ab1KIUFN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2011 21:05:13 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 33A6D5A62C4;
        Wed,  9 Nov 2011 22:05:13 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id aQTV64qEu2Xj; Wed,  9 Nov 2011 22:05:12 +0200 (EET)
Received: from dell.pp.htv.fi (cs178075134172.pp.htv.fi [178.75.134.172])
        by smtp6.welho.com (Postfix) with ESMTP id B745E5BC005;
        Wed,  9 Nov 2011 22:05:12 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: loongson2_clock: include linux/module.h
Date:   Wed,  9 Nov 2011 22:05:09 +0200
Message-Id: <1320869109-9508-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 31482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8114

Fix the following compilation failure with v3.2-rc1 by including module.h:

  CC [M]  arch/mips/kernel/cpufreq/loongson2_clock.o
arch/mips/kernel/cpufreq/loongson2_clock.c:39:1: error: data definition has no type or storage class [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:39:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
arch/mips/kernel/cpufreq/loongson2_clock.c:39:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:51:1: error: data definition has no type or storage class [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:51:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Werror=implicit-int]
arch/mips/kernel/cpufreq/loongson2_clock.c:51:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:71:1: error: data definition has no type or storage class [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:71:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Werror=implicit-int]
arch/mips/kernel/cpufreq/loongson2_clock.c:71:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:76:1: error: data definition has no type or storage class [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:76:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Werror=implicit-int]
arch/mips/kernel/cpufreq/loongson2_clock.c:76:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:82:1: error: data definition has no type or storage class [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:82:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Werror=implicit-int]
arch/mips/kernel/cpufreq/loongson2_clock.c:82:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:87:1: error: data definition has no type or storage class [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:87:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Werror=implicit-int]
arch/mips/kernel/cpufreq/loongson2_clock.c:87:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:93:1: error: data definition has no type or storage class [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:93:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
arch/mips/kernel/cpufreq/loongson2_clock.c:93:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:131:1: error: data definition has no type or storage class [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:131:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
arch/mips/kernel/cpufreq/loongson2_clock.c:131:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:147:1: error: data definition has no type or storage class [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:147:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
arch/mips/kernel/cpufreq/loongson2_clock.c:147:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:166:1: error: data definition has no type or storage class [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:166:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
arch/mips/kernel/cpufreq/loongson2_clock.c:166:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/kernel/cpufreq/loongson2_clock.c:168:15: error: expected declaration specifiers or '...' before string constant
arch/mips/kernel/cpufreq/loongson2_clock.c:169:20: error: expected declaration specifiers or '...' before string constant
arch/mips/kernel/cpufreq/loongson2_clock.c:170:16: error: expected declaration specifiers or '...' before string constant

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/kernel/cpufreq/loongson2_clock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpufreq/loongson2_clock.c b/arch/mips/kernel/cpufreq/loongson2_clock.c
index cefc6e2..5426779 100644
--- a/arch/mips/kernel/cpufreq/loongson2_clock.c
+++ b/arch/mips/kernel/cpufreq/loongson2_clock.c
@@ -7,6 +7,7 @@
  * for more details.
  */
 
+#include <linux/module.h>
 #include <linux/cpufreq.h>
 #include <linux/platform_device.h>
 
-- 
1.7.2.5
