Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:11:12 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:52333 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008604AbaLLWIgxquRJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:36 +0100
Received: by mail-pa0-f45.google.com with SMTP id lf10so7415095pab.18
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PQ3pkUmReqZJMgPyF1annDxz3aLP1wNOC+GEEXyfJKw=;
        b=pI8SWFerwpVBuMl/u+i7+6V5pbx/F01kJrghaa1No94gX5W9nFuWQEYiMBSLazWs7W
         BWIYGWepaG6Z9sJ37mN01MrNdgpnWFgoQI0cbpo6Wd9IOlFM63K7AOlJPn8KwVTiVT4K
         Pxsn8BI6sP6zyEhlGhh0DK9HY7nEOiXAdhVZSQhGLsnowpBxsMmH6FAF1kAaJx0orJuM
         loESZNA6htFrraz8fLFgOhNaQQ3gYQDwgMfKODYF4hFrd48Lx6iH2aEDPi+ipeikii6P
         Wm/t7+iH/Ou+5R2K4lsrjBP/YYvgmKIH82WfAdGuHALh8S5M9wpy0pnmmp7FvFUMOmXj
         +4HQ==
X-Received: by 10.70.42.142 with SMTP id o14mr30701602pdl.17.1418422111287;
        Fri, 12 Dec 2014 14:08:31 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:30 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 10/23] MIPS: Let __dt_register_buses accept a single bus type
Date:   Fri, 12 Dec 2014 14:07:01 -0800
Message-Id: <1418422034-17099-11-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Some machines only have one bus type to register (e.g. "simple-bus").

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/prom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 452d435..e303cb1 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -64,7 +64,10 @@ int __init __dt_register_buses(const char *bus0, const char *bus1)
 		panic("device tree not present");
 
 	strlcpy(of_ids[0].compatible, bus0, sizeof(of_ids[0].compatible));
-	strlcpy(of_ids[1].compatible, bus1, sizeof(of_ids[1].compatible));
+	if (bus1) {
+		strlcpy(of_ids[1].compatible, bus1,
+			sizeof(of_ids[1].compatible));
+	}
 
 	if (of_platform_populate(NULL, of_ids, NULL, NULL))
 		panic("failed to populate DT");
-- 
2.1.1
