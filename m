Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2014 19:03:19 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:33465 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815800AbaDXRDRc9EHn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Apr 2014 19:03:17 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1WdN3G-0007bP-4d; Thu, 24 Apr 2014 12:03:10 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Fix MSA toolchain support detection.
Date:   Thu, 24 Apr 2014 12:03:00 -0500
Message-Id: <1398358980-17930-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39921
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

The '-mmsa' option is not supported by all current compilers. Change
the detection to instead pass the option directly to the assembler.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: Paul Burton <Paul.Burton@imgtec.com>
---
 arch/mips/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1a5b403..3f6cfeb 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -120,7 +120,7 @@ cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
 				   -fno-omit-frame-pointer
 
 ifeq ($(CONFIG_CPU_HAS_MSA),y)
-toolchain-msa			:= $(call cc-option-yn,-mhard-float -mfp64 -mmsa)
+toolchain-msa	:= $(call cc-option-yn,-mhard-float -mfp64 -Wa$(comma)-mmsa)
 cflags-$(toolchain-msa)		+= -DTOOLCHAIN_SUPPORTS_MSA
 endif
 
-- 
1.7.10.4
