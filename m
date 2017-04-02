Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2017 05:10:52 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49788 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991061AbdDBDKB2p9EH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2017 05:10:01 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtv-0003GO-QI; Sun, 02 Apr 2017 04:09:59 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtu-0004Qx-Tj; Sun, 02 Apr 2017 04:09:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>
Date:   Sun, 02 Apr 2017 04:04:24 +0100
Message-ID: <lsq.1491102264.155469014@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 20/26] MIPS: allow msa.h to be included in assembly files
In-Reply-To: <lsq.1491102264.9835075@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.43-rc2 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 558155a0a731b4f56846559a57ca7ca921230497 upstream.

Just #ifdef away the C functions when included from an assembly file,
as will be done in a following commit.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7299/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/msa.h | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index 538f6d482db8..e80e85c1334f 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -12,6 +12,8 @@
 
 #include <asm/mipsregs.h>
 
+#ifndef __ASSEMBLY__
+
 extern void _save_msa(struct task_struct *);
 extern void _restore_msa(struct task_struct *);
 
@@ -133,15 +135,6 @@ static inline void write_msa_##name(unsigned int val)		\
 
 #endif /* !TOOLCHAIN_SUPPORTS_MSA */
 
-#define MSA_IR		0
-#define MSA_CSR		1
-#define MSA_ACCESS	2
-#define MSA_SAVE	3
-#define MSA_MODIFY	4
-#define MSA_REQUEST	5
-#define MSA_MAP		6
-#define MSA_UNMAP	7
-
 __BUILD_MSA_CTL_REG(ir, 0)
 __BUILD_MSA_CTL_REG(csr, 1)
 __BUILD_MSA_CTL_REG(access, 2)
@@ -151,6 +144,17 @@ __BUILD_MSA_CTL_REG(request, 5)
 __BUILD_MSA_CTL_REG(map, 6)
 __BUILD_MSA_CTL_REG(unmap, 7)
 
+#endif /* !__ASSEMBLY__ */
+
+#define MSA_IR		0
+#define MSA_CSR		1
+#define MSA_ACCESS	2
+#define MSA_SAVE	3
+#define MSA_MODIFY	4
+#define MSA_REQUEST	5
+#define MSA_MAP		6
+#define MSA_UNMAP	7
+
 /* MSA Implementation Register (MSAIR) */
 #define MSA_IR_REVB		0
 #define MSA_IR_REVF		(_ULCAST_(0xff) << MSA_IR_REVB)
