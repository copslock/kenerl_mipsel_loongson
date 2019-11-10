Return-Path: <SRS0=owFe=ZC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DCCC17440
	for <linux-mips@archiver.kernel.org>; Sun, 10 Nov 2019 03:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C14208C3
	for <linux-mips@archiver.kernel.org>; Sun, 10 Nov 2019 03:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355019;
	bh=8DD4osZh3pqSw/v3Z8lBeKCbS7/Ml7qR65jLNRSZyrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QVMjg0Kb66/AC+whnUkXOXX8dQ+E6ZTq/pmNscavAAYy6dzZb7V/gIUZJNAmdJATI
	 pQ1WkQEv8DVzqNXkfD3wFUl/8AKIC2obJM/tNWRMY/Dj7yhElnXCxHP7C/tHq+P/Ol
	 N3g3JpYphxbQMhjkP6BIgWVc58QNgRO7BU32lOHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfKJDDi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:03:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbfKJCrO (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 9 Nov 2019 21:47:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A408215EA;
        Sun, 10 Nov 2019 02:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354033;
        bh=8DD4osZh3pqSw/v3Z8lBeKCbS7/Ml7qR65jLNRSZyrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WuiMuTiOcXSbCPgREiPK1DMSPQpGCXNjGr2LKgjnppMLrAeJ2KDn75B70yEF4ZLde
         5IiUu0pK1dp4sKSK7G+ZrGF3VtN0Rlk7G1XSCeyDLEgkeuZdi1n6qI1OR35jj9J268
         LfR4g53oVOWJV6VPsuzibLg/s8FJp29/cyIftSvY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dengcheng Zhu <dzhu@wavecomp.com>,
        Rachel Mozes <rachel.mozes@intel.com>,
        Paul Burton <paul.burton@mips.com>, pburton@wavecomp.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 048/109] MIPS: kexec: Relax memory restriction
Date:   Sat,  9 Nov 2019 21:44:40 -0500
Message-Id: <20191110024541.31567-48-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Dengcheng Zhu <dzhu@wavecomp.com>

[ Upstream commit a6da4d6fdf8bd512c98d3ac7f1d16bc4bb282919 ]

We can rely on the system kernel and the dump capture kernel themselves in
memory usage.

Being restrictive with 512MB limit may cause kexec tool failure on some
platforms.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20568/
Cc: pburton@wavecomp.com
Cc: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/kexec.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 493a3cc7c39ad..cfdbe66575f4d 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -12,11 +12,11 @@
 #include <asm/stacktrace.h>
 
 /* Maximum physical address we can use pages from */
-#define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000)
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
 /* Maximum address we can reach in physical address mode */
-#define KEXEC_DESTINATION_MEMORY_LIMIT (0x20000000)
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
  /* Maximum address we can use for the control code buffer */
-#define KEXEC_CONTROL_MEMORY_LIMIT (0x20000000)
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
 /* Reserve 3*4096 bytes for board-specific info */
 #define KEXEC_CONTROL_PAGE_SIZE (4096 + 3*4096)
 
-- 
2.20.1

