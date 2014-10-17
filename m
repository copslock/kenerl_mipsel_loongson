Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2014 10:11:58 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:57522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010868AbaJQIL4mND56 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Oct 2014 10:11:56 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C28DADC0;
        Fri, 17 Oct 2014 08:11:56 +0000 (UTC)
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.83)
        (envelope-from <jslaby@suse.cz>)
        id 1Xf2df-0000DL-BL; Fri, 17 Oct 2014 10:11:55 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 076/197] MIPS: ZBOOT: add missing <linux/string.h> include
Date:   Fri, 17 Oct 2014 10:09:52 +0200
Message-Id: <8cc50e190b4cd308975d3f6886c8a49f4f5c5ce3.1413533329.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <7d97f39bc813aa9f11fe03d602885f81de07007c.1413533329.git.jslaby@suse.cz>
References: <7d97f39bc813aa9f11fe03d602885f81de07007c.1413533329.git.jslaby@suse.cz>
In-Reply-To: <cover.1413533329.git.jslaby@suse.cz>
References: <cover.1413533329.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Aurelien Jarno <aurelien@aurel32.net>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 29593fd5a8149462ed6fad0d522234facdaee6c8 upstream.

Commit dc4d7b37 (MIPS: ZBOOT: gather string functions into string.c)
moved the string related functions into a separate file, which might
cause the following build error, depending on the configuration:

| CC      arch/mips/boot/compressed/decompress.o
| In file included from linux/arch/mips/boot/compressed/../../../../lib/decompress_unxz.c:234:0,
|                  from linux/arch/mips/boot/compressed/decompress.c:67:
| linux/arch/mips/boot/compressed/../../../../lib/xz/xz_dec_stream.c: In function 'fill_temp':
| linux/arch/mips/boot/compressed/../../../../lib/xz/xz_dec_stream.c:162:2: error: implicit declaration of function 'memcpy' [-Werror=implicit-function-declaration]
| cc1: some warnings being treated as errors
| linux/scripts/Makefile.build:308: recipe for target 'arch/mips/boot/compressed/decompress.o' failed
| make[6]: *** [arch/mips/boot/compressed/decompress.o] Error 1
| linux/arch/mips/Makefile:308: recipe for target 'vmlinuz' failed

It does not fail with the standard configuration, as when
CONFIG_DYNAMIC_DEBUG is not enabled <linux/string.h> gets included in
include/linux/dynamic_debug.h. There might be other ways for it to
get indirectly included.

We can't add the include directly in xz_dec_stream.c as some
architectures might want to use a different version for the boot/
directory (see for example arch/x86/boot/string.h).

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7420/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/boot/compressed/decompress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 2c9573098c0d..d498a1f9bccf 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 #include <asm/addrspace.h>
 
-- 
2.1.1
