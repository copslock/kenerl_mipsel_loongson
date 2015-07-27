Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 14:26:56 +0200 (CEST)
Received: from mail.sevenbyte.org ([5.9.90.188]:39882 "EHLO mail.sevenbyte.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011101AbbG0M0kYRLF0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jul 2015 14:26:40 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.sevenbyte.org (Postfix) with ESMTP id 8D8B21260631;
        Mon, 27 Jul 2015 14:26:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at sevenbyte.org
Received: from mail.sevenbyte.org ([127.0.0.1])
        by localhost (mail.sevenbyte.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4ZM2XTMP89s4; Mon, 27 Jul 2015 14:26:37 +0200 (CEST)
From:   Stefan Tatschner <stefan@sevenbyte.org>
To:     ludwig.kuerzinger@aisec.fraunhofer.de
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 6/9] MIPS: fpu.h: Allow 64-bit FPU on a 64-bit MIPS R6 CPU
Date:   Mon, 27 Jul 2015 14:26:24 +0200
Message-Id: <1437999987-24879-6-git-send-email-stefan@sevenbyte.org>
In-Reply-To: <1437999987-24879-1-git-send-email-stefan@sevenbyte.org>
References: <1437999987-24879-1-git-send-email-stefan@sevenbyte.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.4.6"
Return-Path: <stefan@sevenbyte.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan@sevenbyte.org
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

From: Markos Chandras <markos.chandras@imgtec.com>

This is a multi-part message in MIME format.
--------------2.4.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Commit 6134d94923d0 ("MIPS: asm: fpu: Allow 64-bit FPU on MIPS32 R6")
added support for 64-bit FPU on a 32-bit MIPS R6 processor but it missed
the 64-bit CPU case leading to FPU failures when requesting FR=1 mode
(which is always the case for MIPS R6 userland) when running a 32-bit
kernel on a 64-bit CPU. We also fix the MIPS R2 case.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: 6134d94923d0 ("MIPS: asm: fpu: Allow 64-bit FPU on MIPS32 R6")
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: <stable@vger.kernel.org> # 4.0+
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10734/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/include/asm/fpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


--------------2.4.6
Content-Type: text/x-patch; name="0006-MIPS-fpu.h-Allow-64-bit-FPU-on-a-64-bit-MIPS-R6-CPU.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0006-MIPS-fpu.h-Allow-64-bit-FPU-on-a-64-bit-MIPS-R6-CPU.patch"

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 084780b..1b06251 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -74,7 +74,7 @@ static inline int __enable_fpu(enum fpu_mode mode)
 		goto fr_common;
 
 	case FPU_64BIT:
-#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS32_R6) \
+#if !(defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) \
       || defined(CONFIG_64BIT))
 		/* we only have a 32-bit FPU */
 		return SIGFPE;

--------------2.4.6--
