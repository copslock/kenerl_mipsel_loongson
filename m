Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 22:48:54 +0200 (CEST)
Received: from mail-wg0-f50.google.com ([74.125.82.50]:61069 "EHLO
        mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006505AbaHVUsxBpmoJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 22:48:53 +0200
Received: by mail-wg0-f50.google.com with SMTP id n12so11092939wgh.9
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VPzAcCV2+ubkAXJW22WYuhyDjKhviIAKqTsK4ZmPf84=;
        b=zU5Vd2ZRJsZCzLle8BAiiufOBo3MASdoPKwUCgy77QuhLLaIzJ4+81Jh+RVriAPxgi
         amvzCNAfDl+rXNiX1VofReF+ZggbNYgcMBVjOtIkeYCeZZ7jZAdDpWnqVoV8Sfu39kKb
         mJp0B5EvaiRdXrS8Av0LEsgf2BgejEYL09nZjSl+/YrC0+vUiGzR2JLFh9Th7LrKe9Oz
         6/yrszoJYzAWhYX7pqSHN2oGGoMTavBEkIUXeC8vEIn0QFu671PBUYjN11lCN0zROT0y
         T87V5L1W1V/qQUUEhbN0d16q8DBj47e4gH1j/FYl/uSXuAF3/0U8XaVBSp9eZnbzztl+
         8oMA==
X-Received: by 10.194.20.230 with SMTP id q6mr62903746wje.43.1408563410973;
        Wed, 20 Aug 2014 12:36:50 -0700 (PDT)
Received: from localhost.localdomain (p4FD8DBDE.dip0.t-ipconnect.de. [79.216.219.222])
        by mx.google.com with ESMTPSA id vn10sm60779177wjc.28.2014.08.20.12.36.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Aug 2014 12:36:50 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/4] MIPS: Alchemy: devboards: sit and spin after poweroff
Date:   Wed, 20 Aug 2014 21:36:30 +0200
Message-Id: <1408563393-132515-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1408563393-132515-1-git-send-email-manuel.lauss@gmail.com>
References: <1408563393-132515-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On boards which don't support poweroff, systemd complains about this fact.
In case poweroff fails, just sit and spin in the wait loop.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index 8df86eb..be139a0 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -11,6 +11,7 @@
 #include <linux/pm.h>
 
 #include <asm/bootinfo.h>
+#include <asm/idle.h>
 #include <asm/reboot.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
@@ -53,6 +54,8 @@ static void db1x_power_off(void)
 {
 	bcsr_write(BCSR_RESETS, 0);
 	bcsr_write(BCSR_SYSTEM, BCSR_SYSTEM_PWROFF | BCSR_SYSTEM_RESET);
+	while (1)		/* sit and spin */
+		cpu_wait();
 }
 
 static void db1x_reset(char *c)
-- 
2.0.4
