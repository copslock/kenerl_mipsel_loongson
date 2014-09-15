Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:54:49 +0200 (CEST)
Received: from mail-oa0-f73.google.com ([209.85.219.73]:54024 "EHLO
        mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009021AbaIOXvp5O4qM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:45 +0200
Received: by mail-oa0-f73.google.com with SMTP id jd19so745267oac.4
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FyCBmMla+h6gUHKOmAxugkv8nrBy4QTlQNHqwvllRE8=;
        b=jY1ydxWjzuUUVPWbP2cn1gI63soyCmEYspV5cpwqOPUsSN79FnfDXCXjGQteg0mxhE
         sy5IqekV29BwCUn2F1W/oK1Zu+M7qvr9YfuZ5xpY5P4cTjFf/ZUgFZXqppVKgOYQ/Ttl
         FboP9vPuY+g1ALdi7j+cUIkpDHIWkbrIQX/C9t8o7P+LJkoFhCQYI3+qVg3cuyZQ1h8R
         snW9rCWHBcYi+gWQmN+Ec/fvFJYgY1BiCfbfYEk2SZ7DrpbeqK6OooQH3HA22bQVOmBt
         Mhli81Ta14Dvw/ZJsvifv305FtYWhlrvw1KNmIuD3kteKZBH19jMhHJ/TBk8Dfty1Cn6
         xZ3g==
X-Gm-Message-State: ALoCoQmdF0PpZG/vOXkPw/tCRZCEmvpcsBTpaO6PMW47PQF/4+/Wq5dBYeJQfs2QcYeLmSR8OYjU
X-Received: by 10.42.70.144 with SMTP id f16mr16796142icj.8.1410825100069;
        Mon, 15 Sep 2014 16:51:40 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id l45si631135yha.2.2014.09.15.16.51.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:40 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id Mdj9PTay.3; Mon, 15 Sep 2014 16:51:39 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id EC456220984; Mon, 15 Sep 2014 16:51:38 -0700 (PDT)
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
Subject: [PATCH 11/24] MIPS: Malta: Move MSC01 interrupt base
Date:   Mon, 15 Sep 2014 16:51:14 -0700
Message-Id: <1410825087-5497-12-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42629
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
