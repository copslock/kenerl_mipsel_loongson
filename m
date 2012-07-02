Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2012 06:34:47 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:44534 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901168Ab2GBEen (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Jul 2012 06:34:43 +0200
Received: by pbbrq13 with SMTP id rq13so7942484pbb.36
        for <linux-mips@linux-mips.org>; Sun, 01 Jul 2012 21:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=nQwYUgQd5HVDNRB1k3UgWX84MrCbzHT5HBbCA2c9wUw=;
        b=VdE0DlgUn6XtOYBrDu6xmoRncFAkC4nIUKTbdNCur6sDpLoiyDrvCpmsTN1BjIP8gO
         smV17Lc2HFCBdjBiaC5/IkK0yU7kO3gUs5RbCMGmeOcyYQXIvaR1AGUDZuR/DD0D+ZPD
         1MhiI4RPD0JC18uvjzbfk4CTTbAFKuWLv31jYw5GcU/8hya0JxPzgFgUXrRyhqF8rk86
         c7rgGv+fle01bvhvYz4jWOtZWwmYFBxcM15/xyXEcBg4H6iQblVaosz9CGNNB+u/NJx6
         eJkroOQHW+M1XTl0O1FbX5eGo0VRbmOUzAQQT+RZuPSCKhDWXZIU+TJ564Evd0BqAV91
         ddSA==
Received: by 10.66.74.97 with SMTP id s1mr18529198pav.11.1341203676465;
        Sun, 01 Jul 2012 21:34:36 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id qi8sm12018430pbc.36.2012.07.01.21.34.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 01 Jul 2012 21:34:35 -0700 (PDT)
From:   roy.qing.li@gmail.com
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: fix tc_id calculation
Date:   Mon,  2 Jul 2012 12:34:30 +0800
Message-Id: <1341203670-17544-1-git-send-email-roy.qing.li@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 33873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roy.qing.li@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: RongQing.Li <roy.qing.li@gmail.com>

Now the tc_id is:
  (read_c0_tcbind() >> TCBIND_CURTC_SHIFT) & TCBIND_CURTC;
After substitute macro:
  (read_c0_tcbind() >> 21) & ((0xff) << 21)
It should be:
  (read_c0_tcbind() & ((0xff)<< 21)) >>21

Signed-off-by: RongQing.Li <roy.qing.li@gmail.com>
---
 arch/mips/kernel/smp-cmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index e7e03ec..afc379c 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -102,7 +102,7 @@ static void cmp_init_secondary(void)
 	c->vpe_id = (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE;
 #endif
 #ifdef CONFIG_MIPS_MT_SMTC
-	c->tc_id  = (read_c0_tcbind() >> TCBIND_CURTC_SHIFT) & TCBIND_CURTC;
+	c->tc_id  = (read_c0_tcbind() & TCBIND_CURTC) >> TCBIND_CURTC_SHIFT;
 #endif
 }
 
-- 
1.7.1
