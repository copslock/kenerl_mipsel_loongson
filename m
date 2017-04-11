Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2017 14:52:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59135 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991346AbdDKMwKXYZ0W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2017 14:52:10 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A52832E0CDCBB;
        Tue, 11 Apr 2017 13:52:01 +0100 (IST)
Received: from LDT-J-COWGILL.le.imgtec.org (10.150.130.85) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 11 Apr 2017 13:52:04 +0100
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <James.Cowgill@imgtec.com>
Subject: [PATCH] MIPS: fix modversioning of _mcount symbol
Date:   Tue, 11 Apr 2017 13:51:08 +0100
Message-ID: <20170411125108.30107-2-James.Cowgill@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.85]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

In commit 827456e71036 ("MIPS: Export _mcount alongside its definition")
the EXPORT_SYMBOL macro exporting _mcount was moved from C code into
assembly. Unlike C, exported assembly symbols need to have a function
prototype in asm/asm-prototypes.h for modversions to work properly.
Without this, modpost prints out this warning:

     WARNING: EXPORT symbol "_mcount" [vmlinux] version generation failed,
     symbol will not be versioned.

Fix by including asm/ftrace.h (where _mcount is declared) in
asm/asm-prototypes.h.

Fixes: 827456e71036 ("MIPS: Export _mcount alongside its definition")
Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
---
 arch/mips/include/asm/asm-prototypes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/asm-prototypes.h b/arch/mips/include/asm/asm-prototypes.h
index a160cf69bb92..6e28971fe73a 100644
--- a/arch/mips/include/asm/asm-prototypes.h
+++ b/arch/mips/include/asm/asm-prototypes.h
@@ -3,3 +3,4 @@
 #include <asm/fpu.h>
 #include <asm-generic/asm-prototypes.h>
 #include <asm/uaccess.h>
+#include <asm/ftrace.h>
-- 
2.11.0
