Return-Path: <SRS0=1wql=Y6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F0CC47E49
	for <linux-mips@archiver.kernel.org>; Wed,  6 Nov 2019 17:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD50521848
	for <linux-mips@archiver.kernel.org>; Wed,  6 Nov 2019 17:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbfKFRi6 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:38:58 -0500
Received: from mail.ispras.ru ([83.149.199.45]:56718 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732141AbfKFRi6 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 6 Nov 2019 12:38:58 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 12:38:57 EST
Received: from hednb3.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id F2F8754006B;
        Wed,  6 Nov 2019 20:29:38 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: allow building with kcov coverage
Date:   Wed,  6 Nov 2019 20:28:42 +0300
Message-Id: <1573061322-455-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add ARCH_HAS_KCOV and HAVE_GCC_PLUGINS to MIPS config.
Disable instrumentation of vdso to avoid build failure.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 arch/mips/Kconfig       | 2 ++
 arch/mips/vdso/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7cb8947..2ae1e6d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -87,6 +87,8 @@ config MIPS
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
 	select ARCH_HAS_PTE_SPECIAL if !(32BIT && CPU_HAS_RIXI)
+	select ARCH_HAS_KCOV
+	select HAVE_GCC_PLUGINS
 
 menu "Machine selection"
 
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 996a934..e059389 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -75,6 +75,7 @@ CFLAGS_REMOVE_vdso.o = -pg
 
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
 
 #
 # Shared build commands.
-- 
2.7.4

