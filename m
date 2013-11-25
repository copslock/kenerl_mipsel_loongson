Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2013 09:55:47 +0100 (CET)
Received: from georges.telenet-ops.be ([195.130.137.68]:33749 "EHLO
        georges.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827334Ab3KYIzos8i1I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Nov 2013 09:55:44 +0100
Received: from ayla.of.borg ([84.193.72.141])
        by georges.telenet-ops.be with bizsmtp
        id tkvj1m01N32ts5g06kvj0p; Mon, 25 Nov 2013 09:55:43 +0100
Received: from geert by ayla.of.borg with local (Exim 4.76)
        (envelope-from <geert@linux-m68k.org>)
        id 1VkrxH-0006VY-Dh; Mon, 25 Nov 2013 09:55:43 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org
Subject: [PATCH 13/24] mips: Remove #include <uapi/asm/types.h> from <asm/types.h>
Date:   Mon, 25 Nov 2013 09:55:23 +0100
Message-Id: <1385369734-24893-14-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
References: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Everything in arch/mips/include/uapi/asm/types.h is protected by
"#ifndef __KERNEL__", so it's unused for kernelspace.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/types.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/types.h b/arch/mips/include/asm/types.h
index a845aafedee4..4d5ce4c9c924 100644
--- a/arch/mips/include/asm/types.h
+++ b/arch/mips/include/asm/types.h
@@ -11,8 +11,7 @@
 #ifndef _ASM_TYPES_H
 #define _ASM_TYPES_H
 
-# include <asm-generic/int-ll64.h>
-#include <uapi/asm/types.h>
+#include <asm-generic/int-ll64.h>
 
 /*
  * These aren't exported outside the kernel to avoid name space clashes
-- 
1.7.9.5
