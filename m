Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2014 23:40:04 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49225 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012437AbaKAWjdNGD5O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Nov 2014 23:39:33 +0100
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1XkhKM-0004lr-B5; Sat, 01 Nov 2014 22:39:22 +0000
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1XkhKH-00010q-2r; Sat, 01 Nov 2014 22:39:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Aurelien Jarno" <aurelien@aurel32.net>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:   Sat, 01 Nov 2014 22:28:03 +0000
Message-ID: <lsq.1414880883.953329422@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 008/102] MIPS: ZBOOT: add missing <linux/string.h> include
In-Reply-To: <lsq.1414880882.522510247@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43821
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

3.2.64-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Aurelien Jarno <aurelien@aurel32.net>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/boot/compressed/decompress.c | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 #include <asm/addrspace.h>
 
