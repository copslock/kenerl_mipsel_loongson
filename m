Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2014 10:22:48 +0100 (CET)
Received: from mail-pb0-f45.google.com ([209.85.160.45]:48340 "EHLO
        mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816015AbaCVJWomr-qp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Mar 2014 10:22:44 +0100
Received: by mail-pb0-f45.google.com with SMTP id uo5so3417156pbc.32
        for <multiple recipients>; Sat, 22 Mar 2014 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=/OY0Rk+oGH9Q6QVcxl1PA6TXMAiI6jiwRaoTz5XDlIk=;
        b=TDJuxV5xKcrIJYVMBjIjqZIz87OgAlBj9ubGbpqx0V/TcYeoMbMLxM5CahTW66IqBx
         /70yTI/dM60ATGXD+qf9CqN9Wy4+xBkyh+ABLvUExd/T8S63hNGfKHIRtds9af6NFkCB
         hF4W/fLRiWChsvlTt4HOr2oRc4uD+ECrOGkKqMp70PDos7YTelIMlzITGFK4yyBMrHBg
         Q/jUg27mnaarTyPpYdJ9TgjeB2+Q7/1BbVZp53WA28sgDzBbRJlZ/JtRxiPvDEiK0pZ2
         48qH/DVU9CLJJq1VcvpGd6tsE+2Vk7h6na9KzjtxeaBCcS3WzprM4BHWU+7srRcfmJNV
         xILQ==
X-Received: by 10.68.36.41 with SMTP id n9mr57700405pbj.99.1395480157659;
        Sat, 22 Mar 2014 02:22:37 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id rk15sm39233449pab.37.2014.03.22.02.22.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 22 Mar 2014 02:22:37 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Hibernate: flush TLB entries in swsusp_arch_resume()
Date:   Sat, 22 Mar 2014 17:21:44 +0800
Message-Id: <1395480105-24622-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39545
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

The original MIPS hibernate code flushes cache and TLB entries in
swsusp_arch_resume(). But they are removed in Commit 44eeab67416711
(MIPS: Hibernation: Remove SMP TLB and cacheflushing code.). A cross-
CPU flush is surely unnecessary because all but the local CPU have
already been disabled. But a local flush (at least the TLB flush) is
needed. When we do hibernation on Loongson-3 with an E1000E NIC, it is
very easy to produce a kernel panic (kernel page fault, or unaligned
access). The root cause is E1000E driver use vzalloc_node() to allocate
pages, the stale TLB entries of the booting kernel will be misused by
the resumed target kernel.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: <stable@vger.kernel.org>
---
 arch/mips/power/hibernate.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
index 7e0277a..32a7c82 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -43,6 +43,7 @@ LEAF(swsusp_arch_resume)
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
+	jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
 	PTR_LA t0, saved_regs
 	PTR_L ra, PT_R31(t0)
 	PTR_L sp, PT_R29(t0)
-- 
1.7.7.3
