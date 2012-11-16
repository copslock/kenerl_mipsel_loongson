Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2012 13:32:14 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:53191 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825941Ab2KPMcJ6LbTS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Nov 2012 13:32:09 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 630A5A582F7;
        Fri, 16 Nov 2012 13:32:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cy6lmHs2n8mF; Fri, 16 Nov 2012 13:32:08 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D90BBA3D9B0;
        Fri, 16 Nov 2012 13:32:08 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, blogic@openwrt.org,
        wuzhangjin@gmail.com, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v2] MIPS: decompressor: remove unused linux/kernel.h header
Date:   Fri, 16 Nov 2012 13:30:00 +0100
Message-Id: <1353069000-20500-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1352720818-9192-1-git-send-email-florian@openwrt.org>
References: <1352720818-9192-1-git-send-email-florian@openwrt.org>
X-archive-position: 35025
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

We might end up having a conflicting memcpy() and memset() pulled from
asm/string.h, since we use no declaration from linux/kernel.h, just remove
this include.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- removed the long story about the problem we are fixing
- only remove the linux/kernel.h line

 arch/mips/boot/compressed/decompress.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 5cad0fa..b461efa 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/kernel.h>
 
 #include <asm/addrspace.h>
 
-- 
1.7.10.4
