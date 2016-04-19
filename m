Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 13:19:20 +0200 (CEST)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:52948 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027009AbcDSLTPOAfy1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 13:19:15 +0200
X-QQ-mid: bizesmtp7t1461064733t819t280
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 19 Apr 2016 19:18:24 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK60
X-QQ-FEAT: vusB/7NFgTu4P1LSppzhCgaTor2JJArkqd/pxM5teoqDWBep5NpF1tQVIY8ni
        anuQIS1w7VpXqkqDcjsCILmnw69tcr6afSr1C1Vk3kO/j2HHeK2sFlwfbAM6D2mBxGdGLQy
        5nf3pj2TH402azHEmA1ANn0FwQOSp2Qeot5mAoRuj4s0VOLuDJ/Gae7S0MjPnLykw2AqCht
        oCvWq4ydMd90nhZFd2L/bQjhewi/xeFCemjseJ9S6v+6vgKJ3Y9Qduebs9+QVCRBn90h57x
        ztpvMIko1Zz2GO
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] drm: Loongson-3 doesn't fully support wc memory
Date:   Tue, 19 Apr 2016 19:19:11 +0800
Message-Id: <1461064751-17873-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53098
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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 include/drm/drm_cache.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index 461a055..cebecff 100644
--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -39,6 +39,8 @@ static inline bool drm_arch_can_wc_memory(void)
 {
 #if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
 	return false;
+#elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
+	return false;
 #else
 	return true;
 #endif
-- 
2.7.0
