Return-Path: <SRS0=K/c0=Q7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC1C4360F
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 10:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BAE20663
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 10:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="ayJKR4g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfBXKFl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 24 Feb 2019 05:05:41 -0500
Received: from [115.28.160.31] ([115.28.160.31]:45318 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1728120AbfBXKFl (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Sun, 24 Feb 2019 05:05:41 -0500
Received: from localhost.localdomain (unknown [116.236.177.50])
        by mailbox.box.xen0n.name (Postfix) with ESMTPA id D86C3601C8;
        Sun, 24 Feb 2019 17:37:02 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1551001023; bh=J7iATcxVrVbgSMYpAyIOEoUkNVWUfAtyvY/ElhHuLgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayJKR4g+kWUtCj+zA5zNLBk29oROmIXYvg05Kh+uUuMcQglnmaikmc8O9dvYPtKTw
         v17V5byanql0CtU/FH2UejIxM776Eb01hQMJ+tY4XAiNU3UFR0NJY/D9bQA0W8/QnT
         J+nV1UGj8V/KrEiUeUZhM7Db6tAQ02T/53NPV5Q4=
From:   kernel@xen0n.name
To:     linux-mips@vger.kernel.org
Cc:     Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [RFC PATCH 2/2] MIPS: VDSO: support extcc-based timekeeping
Date:   Sun, 24 Feb 2019 17:36:35 +0800
Message-Id: <20190224093635.1242-3-kernel@xen0n.name>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190224093635.1242-1-kernel@xen0n.name>
References: <20190224093635.1242-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Wang Xuerui <wangxuerui@qiniu.com>

The clocksource bits are ready, just wire things up in VDSO for a
significant user-space timekeeping performance gain.  There are several
ABI problems uncovered by vdsotest though, but daily usage of the test
system didn't expose any of them.  These inconsistencies will be fixed
in a later commit (presently TODO).

According to vdsotest (formatting is manually added, only the affected
figures are shown):

    category                          before  after
    --------                          ------  -----
    clock-gettime-monotonic: syscall: 409     401 nsec/call
    clock-gettime-monotonic:    libc: 476     141 nsec/call
    clock-gettime-monotonic:    vdso: 462     123 nsec/call

    clock-gettime-realtime:  syscall: 405     407 nsec/call
    clock-gettime-realtime:     libc: 474     142 nsec/call
    clock-gettime-realtime:     vdso: 457     125 nsec/call

    gettimeofday:            syscall: 406     407 nsec/call
    gettimeofday:               libc: 455     121 nsec/call
    gettimeofday:               vdso: 440     102 nsec/call

The benchmark was run on a single-socket 3A3000 @ 1.4GHz.  There is
still plenty of headroom for improvements of course, but let's take
care of the micro-optimizations later.

Signed-off-by: Wang Xuerui <wangxuerui@qiniu.com>
Tested-by: Wang Xuerui <wangxuerui@qiniu.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/clocksource.h | 1 +
 arch/mips/loongson64/common/extcc.c | 3 +--
 arch/mips/vdso/gettimeofday.c       | 8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/clocksource.h b/arch/mips/include/asm/clocksource.h
index 3deb1d0c1a94..6a126a475892 100644
--- a/arch/mips/include/asm/clocksource.h
+++ b/arch/mips/include/asm/clocksource.h
@@ -17,6 +17,7 @@
 #define VDSO_CLOCK_NONE		0	/* No suitable clocksource. */
 #define VDSO_CLOCK_R4K		1	/* Use the coprocessor 0 count. */
 #define VDSO_CLOCK_GIC		2	/* Use the GIC. */
+#define VDSO_CLOCK_EXTCC	3	/* Use the Loongson ExtCC. */
 
 /**
  * struct arch_clocksource_data - Architecture-specific clocksource information.
diff --git a/arch/mips/loongson64/common/extcc.c b/arch/mips/loongson64/common/extcc.c
index 702cb389856a..0f6775099411 100644
--- a/arch/mips/loongson64/common/extcc.c
+++ b/arch/mips/loongson64/common/extcc.c
@@ -23,8 +23,7 @@ static struct clocksource extcc_clocksource = {
 	.read		= extcc_read,
 	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VALID_FOR_HRES,
-	/* TODO later */
-	.archdata	= { .vdso_clock_mode = VDSO_CLOCK_NONE },
+	.archdata	= { .vdso_clock_mode = VDSO_CLOCK_EXTCC },
 };
 
 void __init extcc_clocksource_init(void)
diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index e22b422f282c..92eef8de36a4 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -17,6 +17,9 @@
 #include <asm/io.h>
 #include <asm/unistd.h>
 #include <asm/vdso.h>
+#ifdef CONFIG_LOONGSON_EXTCC_CLKSRC
+#include <asm/mach-loongson64/extcc.h>
+#endif
 
 #ifdef CONFIG_MIPS_CLOCK_VSYSCALL
 
@@ -148,6 +151,11 @@ static __always_inline u64 get_ns(const union mips_vdso_data *data)
 	case VDSO_CLOCK_GIC:
 		cycle_now = read_gic_count(data);
 		break;
+#endif
+#ifdef CONFIG_LOONGSON_EXTCC_CLKSRC
+	case VDSO_CLOCK_EXTCC:
+		cycle_now = __extcc_read_ordered();
+		break;
 #endif
 	default:
 		return 0;
-- 
2.20.1

