Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2014 17:11:53 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42087 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822265AbaDKPLrUGmDG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Apr 2014 17:11:47 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1WYd7E-0007xS-Rt; Fri, 11 Apr 2014 10:11:40 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2] MIPS: Fix 'write_msa_##' inline macro.
Date:   Fri, 11 Apr 2014 10:11:31 -0500
Message-Id: <1397229091-7898-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

The 'write_msa_##' macro incorrectly uses the 'cfcmsa'
instruction, which should be the 'ctcmsa' instruction.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: Paul Burton <Paul.Burton@imgtec.com>
---
v2: Fix typo.

 arch/mips/include/asm/msa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index a2aba6c..baddc5f 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -84,7 +84,7 @@ static inline void write_msa_##name(unsigned int val)		\
 	__asm__ __volatile__(					\
 	"	.set	push\n"					\
 	"	.set	msa\n"					\
-	"	cfcmsa	$" #cs ", %0\n"				\
+	"	ctcmsa	$" #cs ", %0\n"				\
 	"	.set	pop\n"					\
 	: : "r"(val));						\
 }
-- 
1.8.3.2
