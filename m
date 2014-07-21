Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2014 16:27:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47799 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861533AbaGUNgVuBjEK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jul 2014 15:36:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9C2C18D221551
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 14:36:12 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 21 Jul
 2014 14:36:15 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Jul 2014 14:36:14 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.145) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Jul 2014 14:36:14 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 3/3] MIPS: CPS: Initialize EVA before bringing up VPEs from secondary cores
Date:   Mon, 21 Jul 2014 14:35:56 +0100
Message-ID: <1405949756-10427-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405949756-10427-1-git-send-email-markos.chandras@imgtec.com>
References: <1405949756-10427-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.145]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The CPS code is doing several memory loads when configuring the VPEs
from secondary cores, so the segmentation control registers must be
initialized in time otherwise the kernel will crash with strange
TLB exceptions.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cps-vec.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 6f4f739dad96..e6e97d2a5c9e 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -13,6 +13,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/asmmacro.h>
 #include <asm/cacheops.h>
+#include <asm/eva.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/pm.h>
@@ -166,6 +167,9 @@ dcache_done:
 1:	jal	mips_cps_core_init
 	 nop
 
+	/* Do any EVA initialization if necessary */
+	eva_init
+
 	/*
 	 * Boot any other VPEs within this core that should be online, and
 	 * deactivate this VPE if it should be offline.
-- 
2.0.0
