Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 May 2014 04:02:43 +0200 (CEST)
Received: from mail-pb0-f42.google.com ([209.85.160.42]:43215 "EHLO
        mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855834AbaEYCCJ6ZAij (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 May 2014 04:02:09 +0200
Received: by mail-pb0-f42.google.com with SMTP id md12so5950820pbc.15
        for <multiple recipients>; Sat, 24 May 2014 19:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fJxCEp+O3zurY7gYMGx09ye2ZRLkVCtay2BCzuZNMWc=;
        b=ZDSvYa3PDE/oHj0Y/bZ9aZdfcg+lTrfiSKgPaWLo4fWI8NnXUSRbBOmtgt9VTiYyvA
         kWv5Dci0rvNXggHP+CnzkHIBZqp4u9OKgFpWuvWCk4EgTriJw+NzEJijyMB4LZhL0v/6
         Pi9H9G0jERsWE6N44Vu+szP7S11lkaGKXqmpQIIXKvOn6p3/wPJXlWjC5kwLDy2tx4zz
         7+sSnWFRGdBCZmiaoIahfjkKZHZiQLW53u7sii1CwHKxW/Q2u3qo0z85ovn8e7XP/2fM
         JHS9SQsj2iBOoeOIeWAXBw0/05ngJE4C07qSZ2mH49q4suqOudSdtAQyWXZScf/xoIkj
         AvGw==
X-Received: by 10.66.65.169 with SMTP id y9mr17118160pas.145.1400983307361;
        Sat, 24 May 2014 19:01:47 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id bi15sm5881084pac.31.2014.05.24.19.01.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 May 2014 19:01:46 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Fix inconsistancy of __NR_Linux_syscalls value
Date:   Sun, 25 May 2014 10:00:36 +0800
Message-Id: <1400983236-21290-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Originally, __NR_O32_Linux_syscalls, __NR_N32_Linux_syscalls and
__NR_64_Linux_syscalls have the same values as __NR_Linux_syscalls in
corresponding ABIs. But after commit 367f0b50e502d (MIPS: Wire up
renameat2 syscall) they are not the same. I think this is incorrect and
need a fix.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/uapi/asm/unistd.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index 2692abb..5805414 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -381,7 +381,7 @@
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		350
+#define __NR_O32_Linux_syscalls		351
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -710,7 +710,7 @@
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		310
+#define __NR_64_Linux_syscalls		311
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1043,6 +1043,6 @@
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		314
+#define __NR_N32_Linux_syscalls		315
 
 #endif /* _UAPI_ASM_UNISTD_H */
-- 
1.7.7.3
