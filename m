Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:00:40 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56007 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009887AbaLYR5YcvirZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:24 +0100
Received: by mail-pd0-f172.google.com with SMTP id y13so11928530pdi.3;
        Thu, 25 Dec 2014 09:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PQ3pkUmReqZJMgPyF1annDxz3aLP1wNOC+GEEXyfJKw=;
        b=txk8gz9hSYm5hxW3IZAO7ZMb8PL2kcfiMhuSK+kuEsR31+xA9+Q4NB/Rg4Y1ylGOhs
         c4H7Oh3pxG6NMNG5F2BgKSENBPqhEyaNvHXjD/+cvmmTsQ5sv6f8LA6wF5QuUHW7UWBh
         9zcXv+FcyKcuMTXKM3+cLamsSCsvG9Tv/L+lWzF9xD88ikBUCfYhTr/rFtJYjmfDRKZj
         C6tF8wwrIjz3AER/mzifmFhZnJsTYnpHqHt+vtHxc9ZW9USJLBFEVFzl+ZZZk9Qoh96R
         b/huforlUfeQMGy9j5Yh2eKT9wm7doPZ+7KdpF3fZE7gyxwh4V+LUuh3f5AVWhakxfbC
         SR/A==
X-Received: by 10.68.95.228 with SMTP id dn4mr63112306pbb.10.1419530238895;
        Thu, 25 Dec 2014 09:57:18 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.17
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:18 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 12/25] MIPS: Let __dt_register_buses accept a single bus type
Date:   Thu, 25 Dec 2014 09:49:07 -0800
Message-Id: <1419529760-9520-13-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44922
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
