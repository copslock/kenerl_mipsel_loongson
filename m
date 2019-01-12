Return-Path: <SRS0=GeJD=PU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66309C43387
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 19:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCA8206B7
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 19:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfALThr (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:37:47 -0500
Received: from hall.aurel32.net ([163.172.24.10]:49592 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfALThr (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 12 Jan 2019 14:37:47 -0500
Received: from [2a01:e35:2e4c:a861:655e:aef3:f589:b897] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <aurelien@aurel32.net>)
        id 1giP6H-0003gk-TZ; Sat, 12 Jan 2019 20:37:46 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.91)
        (envelope-from <aurelien@aurel32.net>)
        id 1giP6H-0001cu-6s; Sat, 12 Jan 2019 20:37:45 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@vger.kernel.org
Cc:     Dengcheng Zhu <dzhu@wavecomp.com>,
        Paul Burton <pburton@wavecomp.com>, ralf@linux-mips.org,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] MIPS: OCTEON: fix kexec support
Date:   Sat, 12 Jan 2019 20:37:28 +0100
Message-Id: <20190112193728.6205-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Commit 62cac480f33f ("MIPS: kexec: Make a framework for both jumping and
halting on nonboot CPUs") broke the build of the OCTEON platform as
the relocated_kexec_smp_wait() is now static and not longer exported in
kexec.h.

Replace it by kexec_reboot() like it has been done in other places.

Fixes: 62cac480f33f ("MIPS: kexec: Make a framework for both jumping and halting on nonboot CPUs")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/cavium-octeon/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 2c79ab52977a..8bf43c5a7bc7 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -98,7 +98,7 @@ static void octeon_kexec_smp_down(void *ignored)
 	"	sync						\n"
 	"	synci	($0)					\n");
 
-	relocated_kexec_smp_wait(NULL);
+	kexec_reboot();
 }
 #endif
 
-- 
2.19.2

