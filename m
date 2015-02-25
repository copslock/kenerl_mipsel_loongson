Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 16:20:47 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:45272 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007055AbbBYPUoVdzGF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 16:20:44 +0100
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.14.3/8.14.3) with ESMTP id t1PFKZRk018689
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 25 Feb 2015 15:20:35 GMT
Received: from localhost.localdomain ([10.144.34.119])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t1PFKXkX026315;
        Wed, 25 Feb 2015 16:20:34 +0100
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] MIPS: malta: pass fw arguments on kexec
Date:   Wed, 25 Feb 2015 17:21:05 +0200
Message-Id: <1424877665-4487-1-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.1.2
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1322
X-purgate-ID: 151667::1424877635-000067C4-29C24D09/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

Pass fw arguments on kexec to the new kernel.

Tested with MIPS64 QEMU. Without the patch the new kernel will default to
(likely) incorrect default memory and console setup, making kexec pretty
much useless.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/mti-malta/malta-reset.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
index 2fd2cc2..f218ba8 100644
--- a/arch/mips/mti-malta/malta-reset.c
+++ b/arch/mips/mti-malta/malta-reset.c
@@ -8,8 +8,10 @@
  */
 #include <linux/io.h>
 #include <linux/pm.h>
+#include <linux/kexec.h>
 
 #include <asm/reboot.h>
+#include <asm/bootinfo.h>
 #include <asm/mach-malta/malta-pm.h>
 
 #define SOFTRES_REG	0x1f000500
@@ -36,8 +38,19 @@ static void mips_machine_power_off(void)
 	mips_machine_restart(NULL);
 }
 
+static int mips_kexec_prepare(struct kimage *image)
+{
+	kexec_args[0] = fw_arg0;
+	kexec_args[1] = fw_arg1;
+	kexec_args[2] = fw_arg2;
+	kexec_args[3] = fw_arg3;
+
+	return 0;
+}
+
 static int __init mips_reboot_setup(void)
 {
+	_machine_kexec_prepare = mips_kexec_prepare;
 	_machine_restart = mips_machine_restart;
 	_machine_halt = mips_machine_halt;
 	pm_power_off = mips_machine_power_off;
-- 
2.1.2
