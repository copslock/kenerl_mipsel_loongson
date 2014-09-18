Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:52:54 +0200 (CEST)
Received: from mail-ie0-f201.google.com ([209.85.223.201]:37537 "EHLO
        mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009246AbaIRVruL8NQq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:50 +0200
Received: by mail-ie0-f201.google.com with SMTP id rl12so311173iec.2
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fa2yicD8fiMBGLoXBSzhuNi4mpVwCc57/Y+TdPFXgrA=;
        b=h5v1w8Iq6jJdH3qq41SiitzlUcut0wXop0eiqLTZGXkdsJKDbhhpESoy3+uC/d+6v/
         mPy4u7vipKmVhtiw681M09GSHHuxbAw224BUnK4wpg335AjT3FpQe45b5NNST0Khj8IU
         xDcJYvoxhMgVMTM8UV4vhhEWF/wehxbs0SgbzMzj9ZxyM9Bfq16kHO0QvUPTvRMDLvBz
         wINSzocZC9Ut6VMe56TabpHreMyOSPGLXSJJC93JOBDpIjlE54vBQqTeUfUOmaLa8E5r
         NPX3NAi3hAGuZrMwN4LQN0i3B6/SUGKy2f768wKBA+F1bL0Fjwzb2kD4vWm2YLW9WpN/
         su7A==
X-Gm-Message-State: ALoCoQmPXPAK54JU0nUKsqYVBtBiudo26eGPEgby3y2BQQ0f5vs7lC1t185b6F22OPWmaybrHBwC
X-Received: by 10.42.83.5 with SMTP id f5mr6915093icl.27.1411076861307;
        Thu, 18 Sep 2014 14:47:41 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si3545yhe.3.2014.09.18.14.47.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:41 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id P0uuVMGs.3; Thu, 18 Sep 2014 14:47:41 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 32B7A220D1A; Thu, 18 Sep 2014 14:47:40 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/24] MIPS: Malta: Move MSC01 interrupt base
Date:   Thu, 18 Sep 2014 14:47:17 -0700
Message-Id: <1411076851-28242-12-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

The GIC on Malta boards supports a total of 47 interrupts (40 shared
and 7 local) and is assigned a base of 24.  This overlaps with the
MSC01 interrupt assignments which have a base of 64, so move the MSC01
interrupt base back a bit to give the GIC some room.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 arch/mips/include/asm/mips-boards/maltaint.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/maltaint.h b/arch/mips/include/asm/mips-boards/maltaint.h
index e330732..4186606 100644
--- a/arch/mips/include/asm/mips-boards/maltaint.h
+++ b/arch/mips/include/asm/mips-boards/maltaint.h
@@ -33,18 +33,18 @@
 #define MIPSCPU_INT_CORELO	MIPSCPU_INT_MB4
 
 /*
- * Interrupts 64..127 are used for Soc-it Classic interrupts
+ * Interrupts 96..127 are used for Soc-it Classic interrupts
  */
-#define MSC01C_INT_BASE		64
+#define MSC01C_INT_BASE		96
 
 /* SOC-it Classic interrupt offsets */
 #define MSC01C_INT_TMR		0
 #define MSC01C_INT_PCI		1
 
 /*
- * Interrupts 64..127 are used for Soc-it EIC interrupts
+ * Interrupts 96..127 are used for Soc-it EIC interrupts
  */
-#define MSC01E_INT_BASE		64
+#define MSC01E_INT_BASE		96
 
 /* SOC-it EIC interrupt offsets */
 #define MSC01E_INT_SW0		1
-- 
2.1.0.rc2.206.gedb03e5
