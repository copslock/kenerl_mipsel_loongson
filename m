Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 14:47:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20070 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993043AbcKWNoKEaERG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 14:44:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id F2C56B453F72B;
        Wed, 23 Nov 2016 13:43:59 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 23 Nov 2016 13:44:02 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 09/10] MIPS: kexec: add debug info about the new kexec'ed image
Date:   Wed, 23 Nov 2016 14:43:51 +0100
Message-ID: <1479908632-30392-10-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Print details of the new kexec image loaded.

Based on the original code from
commit 221f2c770e10d ("arm64/kexec: Add pr_debug output")

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/machine_kexec.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 5972520..8b574bc 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -28,9 +28,31 @@ atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
 void (*_crash_smp_send_stop)(void) = NULL;
 #endif
 
+static void kexec_image_info(const struct kimage *kimage)
+{
+	unsigned long i;
+
+	pr_debug("kexec kimage info:\n");
+	pr_debug("  type:        %d\n", kimage->type);
+	pr_debug("  start:       %lx\n", kimage->start);
+	pr_debug("  head:        %lx\n", kimage->head);
+	pr_debug("  nr_segments: %lu\n", kimage->nr_segments);
+
+	for (i = 0; i < kimage->nr_segments; i++) {
+		pr_debug("    segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
+			i,
+			kimage->segment[i].mem,
+			kimage->segment[i].mem + kimage->segment[i].memsz,
+			(unsigned long)kimage->segment[i].memsz,
+			(unsigned long)kimage->segment[i].memsz /  PAGE_SIZE);
+	}
+}
+
 int
 machine_kexec_prepare(struct kimage *kimage)
 {
+	kexec_image_info(kimage);
+
 	if (_machine_kexec_prepare)
 		return _machine_kexec_prepare(kimage);
 	return 0;
-- 
2.7.4
