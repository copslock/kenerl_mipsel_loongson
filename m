Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2014 00:24:15 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010192AbaJCWYNOil8i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Oct 2014 00:24:13 +0200
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 08EA47AC;
        Fri,  3 Oct 2014 22:24:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.10 068/143] MIPS: ZBOOT: add missing <linux/string.h> include
Date:   Fri,  3 Oct 2014 14:34:23 -0700
Message-Id: <20141003213316.556590036@linuxfoundation.org>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <20141003213314.470709810@linuxfoundation.org>
References: <20141003213314.470709810@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.10-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/compressed/decompress.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 #include <asm/addrspace.h>
 
