Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Feb 2016 18:08:46 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:51772 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012225AbcBURIoscW3z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 Feb 2016 18:08:44 +0100
Received: from hauke-desktop.fritz.box (p5DE94359.dip0.t-ipconnect.de [93.233.67.89])
        by hauke-m.de (Postfix) with ESMTPSA id BE0121001AD;
        Sun, 21 Feb 2016 18:08:43 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     alex.smith@imgtec.com, sergei.shtylyov@cogentembedded.com,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "# v4 . 4+" <stable@vger.kernel.org>
Subject: [PATCH v2] MIPS: vdso: flush the vdso data page to update it on all processes
Date:   Sun, 21 Feb 2016 18:08:38 +0100
Message-Id: <1456074518-13163-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.7.0
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Without flushing the vdso data page the vdso call is working on dated
or unsynced data. This resulted in problems where the clock_gettime
vdso call returned a time 6 seconds later after a 3 seconds sleep,
while the syscall reported a time 3 sounds later, like expected. This
happened very often and I got these ping results for example:

root@OpenWrt:/# ping 192.168.1.255
PING 192.168.1.255 (192.168.1.255): 56 data bytes
64 bytes from 192.168.1.3: seq=0 ttl=64 time=0.688 ms
64 bytes from 192.168.1.3: seq=1 ttl=64 time=4294172.045 ms
64 bytes from 192.168.1.3: seq=2 ttl=64 time=4293968.105 ms
64 bytes from 192.168.1.3: seq=3 ttl=64 time=4294055.920 ms
64 bytes from 192.168.1.3: seq=4 ttl=64 time=4294671.913 ms

This was tested on a Lantiq/Intel VRX288 (MIPS BE 34Kc V5.6 CPU with
two VPEs)

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: <stable@vger.kernel.org> # v4.4+
---
 arch/mips/kernel/vdso.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 975e997..8b0d974 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -20,6 +20,8 @@
 #include <linux/timekeeper_internal.h>
 
 #include <asm/abi.h>
+#include <asm/cacheflush.h>
+#include <asm/page.h>
 #include <asm/vdso.h>
 
 /* Kernel-provided data used by the VDSO. */
@@ -85,6 +87,8 @@ void update_vsyscall(struct timekeeper *tk)
 	}
 
 	vdso_data_write_end(&vdso_data);
+	flush_cache_vmap((unsigned long)&vdso_data,
+			 (unsigned long)&vdso_data + sizeof(vdso_data));
 }
 
 void update_vsyscall_tz(void)
@@ -93,6 +97,8 @@ void update_vsyscall_tz(void)
 		vdso_data.tz_minuteswest = sys_tz.tz_minuteswest;
 		vdso_data.tz_dsttime = sys_tz.tz_dsttime;
 	}
+	flush_cache_vmap((unsigned long)&vdso_data,
+			 (unsigned long)&vdso_data + sizeof(vdso_data));
 }
 
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
-- 
2.7.0
