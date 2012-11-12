Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2012 12:48:37 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33572 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823016Ab2KLLsgGRn6W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Nov 2012 12:48:36 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 9B375B14CAF;
        Mon, 12 Nov 2012 12:48:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pultDrnjJUzN; Mon, 12 Nov 2012 12:48:35 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 2FE98B14CAC;
        Mon, 12 Nov 2012 12:48:35 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, blogic@openwrt.org,
        wuzhangjin@gmail.com, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: decompressor: fix build failure on memcpy() in decompress.c
Date:   Mon, 12 Nov 2012 12:46:58 +0100
Message-Id: <1352720818-9192-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 34969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The decompress.c file includes linux/kernel.h which causes the following
inclusion chain to be pulled:
linux/kernel.h ->
	linux/dynamic_debug.h ->
		linux/string.h ->
			asm/string.h

We end up having a the GCC builtin + architecture specific memcpy() expanding
into this:

void *({ size_t __len = (size_t n); void *__ret; if
(__builtin_constant_p(size_t n) && __len >= 64) __ret = memcpy((void *dest),
(const void *src), __len); else __ret = __builtin_memcpy((void *dest), (const
void *src), __len); __ret; })
{
 [memcpy implementation in decompress.c starts here]
 int i;
 const char *s = src;
 char *d = dest;

 for (i = 0; i < n; i++)
  d[i] = s[i];
 return dest;
}

raising the following compilation error:
arch/mips/boot/compressed/decompress.c:46:8: error: expected identifier or '('
before '{' token

There are at least three possibilities to fix this issue:

1) define _LINUX_STRING_H_ at the beginning of decompress.c to prevent
   further linux/string.h definitions and declarations from being used, and add
   an explicit strstr() declaration for linux/dynamic_debug.h

2) remove the inclusion of linux/kernel.h because we actually use no definition
   or declaration from this header file

3) undefine memcpy or re-define memcpy to memcpy thus resulting in picking up
   the local memcpy() implementation to this compilation unit

This patch uses the second option which is the less intrusive one.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/boot/compressed/decompress.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 5cad0fa..d6c5586 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -10,9 +10,7 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-
 #include <linux/types.h>
-#include <linux/kernel.h>
 
 #include <asm/addrspace.h>
 
-- 
1.7.10.4
