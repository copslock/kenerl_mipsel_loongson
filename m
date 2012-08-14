Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 15:25:44 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2056 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903523Ab2HNNZQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 15:25:16 +0200
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 14 Aug 2012 06:24:06 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 14 Aug 2012 06:24:56 -0700
Received: from jc-linux.netlogicmicro.com (unknown [10.7.2.153]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 318709F9F5; Tue, 14
 Aug 2012 06:24:54 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 1/2] MIPS: Netlogic: define cpu_has_fpu macro
Date:   Tue, 14 Aug 2012 18:56:12 +0530
Message-ID: <1344950773-29299-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344950773-29299-1-git-send-email-jchandra@broadcom.com>
References: <1344950773-29299-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C348EFC3MK19975507-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34154
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

The default implementation of 'cpu_has_fpu' macro calls
smp_processor_id() which causes this warning when preemption is enabled:

[    4.664000] Algorithmics/MIPS FPU Emulator v1.5
[    4.676000] BUG: using smp_processor_id() in preemptible [00000000] code: init/1
[    4.700000] caller is fpu_emulator_cop1Handler+0x434/0x27b8

Work around this by defining cpu_has_fpu for XLR and XLP in
mach-netlogic/cpu-feature-overrides.h

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 .../asm/mach-netlogic/cpu-feature-overrides.h      |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
index 966db4b..4f5907f 100644
--- a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
@@ -44,10 +44,12 @@
 #define cpu_has_dc_aliases	0
 #define cpu_has_mips32r2	0
 #define cpu_has_mips64r2	0
+#define cpu_has_fpu		0
 #elif defined(CONFIG_CPU_XLP)
 #define cpu_has_userlocal	1
 #define cpu_has_mips32r2	1
 #define cpu_has_mips64r2	1
+#define cpu_has_fpu		1
 #else
 #error "Unknown Netlogic CPU"
 #endif
-- 
1.7.9.5
