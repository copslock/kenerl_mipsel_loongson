Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Feb 2014 21:01:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:36290 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6869162AbaB1UAuOAJJi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Feb 2014 21:00:50 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6C00F9F4BE6F2;
        Fri, 28 Feb 2014 18:23:33 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 28 Feb 2014 18:23:36 +0000
Received: from fun-lab.mips.com (192.168.136.61) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 28 Feb
 2014 10:23:34 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <john@phrozen.org>, <ralf@linux-mips.org>,
        <Steven.Hill@imgtec.com>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 3/3] MIPS: APRP: Choose the correct VPE loader by fixing the linking
Date:   Fri, 28 Feb 2014 10:23:03 -0800
Message-ID: <1393611783-7037-4-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1393611783-7037-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1393611783-7037-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Now we have CONFIG_MIPS_VPE_LOADER and CONFIG_MIPS_VPE_LOADER_[CMP|MT]. The
latter two are used by the 2 exclusive flavors. The vpe_run in malta-amon.c
is for CMP APRP. Without the fix, this vpe_run will be used in MT APRP.

Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/mti-malta/malta-amon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mti-malta/malta-amon.c b/arch/mips/mti-malta/malta-amon.c
index 592ac04..84ac523 100644
--- a/arch/mips/mti-malta/malta-amon.c
+++ b/arch/mips/mti-malta/malta-amon.c
@@ -72,7 +72,7 @@ int amon_cpu_start(int cpu,
 	return 0;
 }
 
-#ifdef CONFIG_MIPS_VPE_LOADER
+#ifdef CONFIG_MIPS_VPE_LOADER_CMP
 int vpe_run(struct vpe *v)
 {
 	struct vpe_notifications *n;
-- 
1.8.5.3
