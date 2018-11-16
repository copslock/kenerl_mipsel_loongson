Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2018 17:10:10 +0100 (CET)
Received: from gofer.mess.org ([88.97.38.141]:46973 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990946AbeKPQJkvnQ5K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Nov 2018 17:09:40 +0100
Received: by gofer.mess.org (Postfix, from userid 1000)
        id D48B6605DA; Fri, 16 Nov 2018 16:09:39 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Remove superfluous check for __linux__
Date:   Fri, 16 Nov 2018 16:09:39 +0000
Message-Id: <20181116160939.22085-1-sean@mess.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <sean@mess.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sean@mess.org
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

When building BPF code using "clang -target bpf -c", clang does not
define __linux__.

To build BPF IR decoders the include linux/lirc.h is needed which
includes linux/types.h. Currently this workaround is needed:

https://git.linuxtv.org/v4l-utils.git/commit/?id=dd3ff81f58c4e1e6f33765dc61ad33c48ae6bb07

This check might otherwise be useful to stop users from using a non-linux
compiler, but if you're doing that you are going to have a lot more
trouble anyway.

Signed-off-by: Sean Young <sean@mess.org>
---
 arch/mips/include/uapi/asm/sgidefs.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/include/uapi/asm/sgidefs.h b/arch/mips/include/uapi/asm/sgidefs.h
index 26143e3b7c26..69c3de90c536 100644
--- a/arch/mips/include/uapi/asm/sgidefs.h
+++ b/arch/mips/include/uapi/asm/sgidefs.h
@@ -11,14 +11,6 @@
 #ifndef __ASM_SGIDEFS_H
 #define __ASM_SGIDEFS_H
 
-/*
- * Using a Linux compiler for building Linux seems logic but not to
- * everybody.
- */
-#ifndef __linux__
-#error Use a Linux compiler or give up.
-#endif
-
 /*
  * Definitions for the ISA levels
  *
-- 
2.19.1
