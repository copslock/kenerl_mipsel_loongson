Return-Path: <SRS0=4KhX=WZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04768C3A59F
	for <linux-mips@archiver.kernel.org>; Thu, 29 Aug 2019 11:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9B522CF5
	for <linux-mips@archiver.kernel.org>; Thu, 29 Aug 2019 11:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfH2LTt (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:19:49 -0400
Received: from foss.arm.com ([217.140.110.172]:42860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbfH2LTU (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 29 Aug 2019 07:19:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F23F71570;
        Thu, 29 Aug 2019 04:19:19 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 801123F59C;
        Thu, 29 Aug 2019 04:19:18 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com,
        tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com,
        luto@kernel.org
Subject: [PATCH 7/7] x86: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Date:   Thu, 29 Aug 2019 12:18:43 +0100
Message-Id: <20190829111843.41003-8-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190829111843.41003-1-vincenzo.frascino@arm.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

As a consequence of Commit 623fa33f7bd6 ("lib:vdso: Remove
VDSO_HAS_32BIT_FALLBACK") VDSO_HAS_32BIT_FALLBACK define is not
required anymore hence can be removed.

Remove unused VDSO_HAS_32BIT_FALLBACK from x86 vdso.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/x86/include/asm/vdso/gettimeofday.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index e9ee139cf29e..52c3bcd672cf 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -96,8 +96,6 @@ long clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 
 #else
 
-#define VDSO_HAS_32BIT_FALLBACK	1
-
 static __always_inline
 long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
-- 
2.23.0

