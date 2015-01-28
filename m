Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2015 05:17:26 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37279 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008709AbbA1ERWtSCgY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jan 2015 05:17:22 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 69EE2200E8;
        Wed, 28 Jan 2015 04:17:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [183.247.163.231])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9150420142;
        Wed, 28 Jan 2015 04:17:17 +0000 (UTC)
From:   lizf@kernel.org
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH 3.4 42/91] MIPS: ZBOOT: add missing <linux/string.h> include
Date:   Wed, 28 Jan 2015 12:07:30 +0800
Message-Id: <1422418236-12852-83-git-send-email-lizf@kernel.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1422418050-12581-1-git-send-email-lizf@kernel.org>
References: <1422418050-12581-1-git-send-email-lizf@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lizf@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizf@kernel.org
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

3.4.105-rc1 review patch.  If anyone has any objections, please let me know.

------------------


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
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 arch/mips/boot/compressed/decompress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 5cad0fa..ca51d69 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 #include <asm/addrspace.h>
 
-- 
1.9.1
