Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 05:35:46 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64771 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007474AbaK1EdYoHHCj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Nov 2014 05:33:24 +0100
Received: by mail-pa0-f42.google.com with SMTP id et14so6084640pad.29
        for <multiple recipients>; Thu, 27 Nov 2014 20:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UnXtr4bzimnvGn417HvbNed34BL/3riIQwiV47HvdmY=;
        b=MGZOjyee4u8oqaYW49knfL7BU7sarJOSTvLbSkgHWOJWRujyP1wHaROeRqDFsLORmq
         1eEOOHZlNlO7H+Mz5lORnIJtJ8CsQtOhmGP0sEt0KfmsmCJ3uUcOIGwTvER+Ufjxg+S/
         gB8hFEnbn2Ay/dxFigswdr+xFsTpzsIL4bmtI88GFxmWw/YTFdjy1hb9OsIaoR9v9n3/
         s0uwXBd0DzpTJ6F5m/QmqcHUKGirJNWADcuA6HiMoB+cEBItQ7U2W9Xibz5tfRn1MNzx
         vK9dM6HOO68jko5CSndtR+oYcTFMtbcNmi2ZTKNBYYb87HzP/xS52jU9fzcA4xsriVJr
         JY9w==
X-Received: by 10.69.0.138 with SMTP id ay10mr68072549pbd.110.1417149199091;
        Thu, 27 Nov 2014 20:33:19 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id u5sm8482887pdc.79.2014.11.27.20.33.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Nov 2014 20:33:18 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 09/16] MIPS: Let __dt_register_buses accept a single bus type
Date:   Thu, 27 Nov 2014 20:32:15 -0800
Message-Id: <1417149142-3756-10-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44500
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
index 452d4350ce42..e303cb1ef2f4 100644
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
2.1.0
