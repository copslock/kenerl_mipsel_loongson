Return-Path: <SRS0=Eolf=YJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB30AFA3728
	for <linux-mips@archiver.kernel.org>; Wed, 16 Oct 2019 13:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB98218DE
	for <linux-mips@archiver.kernel.org>; Wed, 16 Oct 2019 13:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbfJPNkf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:40:35 -0400
Received: from foss.arm.com ([217.140.110.172]:40244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730762AbfJPNkf (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 16 Oct 2019 09:40:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8002C142F;
        Wed, 16 Oct 2019 06:40:34 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B909B3F68E;
        Wed, 16 Oct 2019 06:40:33 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-mips@vger.kernel.org
Cc:     pburton@wavecomp.com, mbizon@freebox.fr, vincenzo.frascino@arm.com
Subject: [PATCH] mips: vdso: Fix __arch_get_hw_counter()
Date:   Wed, 16 Oct 2019 14:40:24 +0100
Message-Id: <20191016134024.46671-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On some MIPS variants (e.g. MIPS r1), vDSO clock_mode is set to
VDSO_CLOCK_NONE.

When VDSO_CLOCK_NONE is set the expected kernel behavior is to fallback
on syscalls. To do that the generic vDSO library expects UULONG_MAX as
return value of __arch_get_hw_counter().

Fix __arch_get_hw_counter() on MIPS defining a __VDSO_USE_SYSCALL case
that addressed the described scenario.

Reported-by: Maxime Bizon <mbizon@freebox.fr>
Cc: Paul Burton <pburton@wavecomp.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/include/asm/vdso/gettimeofday.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index e78462e8ca2e..b08825531e9f 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -24,6 +24,8 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
+#define __VDSO_USE_SYSCALL		ULLONG_MAX
+
 #ifdef CONFIG_MIPS_CLOCK_VSYSCALL
 
 static __always_inline long gettimeofday_fallback(
@@ -205,7 +207,7 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 		break;
 #endif
 	default:
-		cycle_now = 0;
+		cycle_now = __VDSO_USE_SYSCALL;
 		break;
 	}
 
-- 
2.23.0

