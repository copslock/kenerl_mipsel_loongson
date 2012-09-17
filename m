Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2012 22:20:31 +0200 (CEST)
Received: from juliette.telenet-ops.be ([195.130.137.74]:49198 "EHLO
        juliette.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903405Ab2IQUUX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Sep 2012 22:20:23 +0200
Received: from ayla.of.borg ([84.193.72.141])
        by juliette.telenet-ops.be with bizsmtp
        id 0LLM1k00z32ts5g06LLM38; Mon, 17 Sep 2012 22:20:22 +0200
Received: from geert by ayla.of.borg with local (Exim 4.71)
        (envelope-from <geert@linux-m68k.org>)
        id 1TDhnp-0002u9-Nu; Mon, 17 Sep 2012 22:20:21 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-next@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH -next] MIPS: ptrace: Add missing #include <asm/syscall.h>
Date:   Mon, 17 Sep 2012 22:20:16 +0200
Message-Id: <1347913216-11140-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 34523
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

arch/mips/kernel/ptrace.c: In function ‘syscall_trace_enter’:
arch/mips/kernel/ptrace.c:664: error: implicit declaration of function ‘__syscall_get_arch’
make[2]: *** [arch/mips/kernel/ptrace.o] Error 1

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
E.g. http://kisskb.ellerman.id.au/kisskb/buildresult/7223557/

 arch/mips/kernel/ptrace.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 94fd0f4..cc7c44f 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -40,6 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/bootinfo.h>
 #include <asm/reg.h>
+#include <asm/syscall.h>
 
 /*
  * Called by kernel/ptrace.c when detaching..
-- 
1.7.0.4
