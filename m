Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 08:28:29 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:50577 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903609Ab2FTG2W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2012 08:28:22 +0200
Received: by dadm1 with SMTP id m1so9934951dad.36
        for <multiple recipients>; Tue, 19 Jun 2012 23:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=OvNN7KCfVMIalhUEuaElXy3dTGWSZJxRnM8DvUXTM0c=;
        b=n6FUg4jS014FjYX64jcuynQwikQG80naqnoZagOaYrlu8lSo456ji7bT8tiP4CQyWu
         pZ9i/cQMYeUcE6i8av7LZhDiCAVqzrbOf32k3e9ZIY7uwJ7EvGz1aBfdbPsMFa5cihIT
         xwPFOt3aiWld5+aQVlbyEM/O/6WhuLahl5scDrBBpFe3b4VIfhRueOIp3jxCdKeGA0eJ
         k6psqIJd+hRUajJpxxPkz6fH0ytSEi35KUmzXWt3KLy3KRxgzrLxTtJkZdzTwFQot041
         Qfpg/EG36en9SVA5yg8Sazxi3wczoTUydeUzIEXSKnnefnF6//p3Ygg39vRHzas7REY4
         m+1A==
Received: by 10.68.242.71 with SMTP id wo7mr14089507pbc.16.1340173695562;
        Tue, 19 Jun 2012 23:28:15 -0700 (PDT)
Received: from sdk (UQ1-221-170-18-58.tky.mesh.ad.jp. [221.170.18.58])
        by mx.google.com with ESMTPS id ve4sm30740049pbc.55.2012.06.19.23.28.11
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 23:28:14 -0700 (PDT)
Date:   Wed, 20 Jun 2012 15:27:59 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mundt <lethal@linux-sh.org>
Cc:     yuasa@linux-mips.org, linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: fix bug.h MIPS build regression
Message-Id: <20120620152759.2caceb8c.yuasa@linux-mips.org>
In-Reply-To: <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 33732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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

Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.

  CC      arch/mips/kernel/machine_kexec.o
In file included from include/linux/kernel.h:20:0,
                 from include/asm-generic/bug.h:35,
                 from /home/yuasa/src/linux/kernel/git/linux-2.6/arch/mips/include/asm/bug.h:41,
                 from /home/yuasa/src/linux/kernel/git/linux-2.6/arch/mips/include/asm/bitops.h:20,
                 from include/linux/bitops.h:22,
                 from include/linux/signal.h:38,
                 from include/linux/elfcore.h:5,
                 from include/linux/kexec.h:60,
                 from arch/mips/kernel/machine_kexec.c:9:
include/linux/log2.h: In function '__ilog2_u32':
include/linux/log2.h:34:2: error: implicit declaration of function 'fls' [-Werror=implicit-function-declaration]
include/linux/log2.h: In function '__ilog2_u64':
include/linux/log2.h:42:2: error: implicit declaration of function 'fls64' [-Werror=implicit-function-declaration]
include/linux/log2.h: In function '__roundup_pow_of_two':
include/linux/log2.h:63:2: error: implicit declaration of function 'fls_long' [-Werror=implicit-function-declaration]
In file included from include/linux/bitops.h:22:0,
                 from include/linux/signal.h:38,
                 from include/linux/elfcore.h:5,
                 from include/linux/kexec.h:60,
                 from arch/mips/kernel/machine_kexec.c:9:
/home/yuasa/src/linux/kernel/git/linux-2.6/arch/mips/include/asm/bitops.h: At top level:
/home/yuasa/src/linux/kernel/git/linux-2.6/arch/mips/include/asm/bitops.h:615:19: error: static declaration of 'fls' follows non-static declaration
include/linux/log2.h:34:9: note: previous implicit declaration of 'fls' was here
In file included from /home/yuasa/src/linux/kernel/git/linux-2.6/arch/mips/include/asm/bitops.h:651:0,
                 from include/linux/bitops.h:22,
                 from include/linux/signal.h:38,
                 from include/linux/elfcore.h:5,
                 from include/linux/kexec.h:60,
                 from arch/mips/kernel/machine_kexec.c:9:
include/asm-generic/bitops/fls64.h:18:28: error: static declaration of 'fls64' follows non-static declaration
include/linux/log2.h:42:9: note: previous implicit declaration of 'fls64' was here
In file included from include/linux/signal.h:38:0,
                 from include/linux/elfcore.h:5,
                 from include/linux/kexec.h:60,
                 from arch/mips/kernel/machine_kexec.c:9:
include/linux/bitops.h:160:24: error: conflicting types for 'fls_long'
include/linux/log2.h:63:16: note: previous implicit declaration of 'fls_long' was here
cc1: all warnings being treated as errors

make[2]: *** [arch/mips/kernel/machine_kexec.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/bitops.h |    1 -
 arch/mips/include/asm/io.h     |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 2e1ad4c..82ad35c 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -17,7 +17,6 @@
 #include <linux/irqflags.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
-#include <asm/bug.h>
 #include <asm/byteorder.h>		/* sigh ... */
 #include <asm/cpu-features.h>
 #include <asm/sgidefs.h>
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 37a8379..100f9a3 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 
 #include <asm/addrspace.h>
+#include <asm/bug.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
-- 
1.7.0.4
