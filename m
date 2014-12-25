Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:02:26 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52291 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009909AbaLYR5eBUr4g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:34 +0100
Received: by mail-pa0-f48.google.com with SMTP id rd3so12010339pab.35;
        Thu, 25 Dec 2014 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sSBtdIMQ5rzsUuM6Cg9oOWGf56VdUst0rjRplCFSl6o=;
        b=AVJOmvK8/WKvSKZBezoz1xPunH29QOTNAEGmrD02VHgC6Qnu9DvtQ1gW0ufzHs7Jq8
         P3TjOugDOWzyAxeM8YSkYeQhQaPnN5IcF2gSVG1Pr2l0nAGu0HaziPNig7bFymJQ9AXm
         tfQEfjwFUJt4x46ezoOapTiDwycLkFfvw5oTO3DlckRJdcrqRSY1UrD2xqQs3aqroygm
         IwrqZU7Y3Q3h5YtL9Ryg82CluYckv0CDEVU3o+7bAfQL10SuWwaP1NrszvhrH0FieraB
         lk64bTNj5L/c5M8wxzWi5h5MLdtF6SvbNM0YEBjtolwo3zdbyPVo5S/6Nl6V0T5Orhjo
         VvTg==
X-Received: by 10.68.69.80 with SMTP id c16mr63044280pbu.125.1419530248230;
        Thu, 25 Dec 2014 09:57:28 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.26
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:27 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 18/25] MIPS: BMIPS: Remove bogus bus name
Date:   Thu, 25 Dec 2014 09:49:13 -0800
Message-Id: <1419529760-9520-19-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44928
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

There is no "bcm3384" bus so let's just remove it to avoid confusion.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/bmips/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 5099109..ac402ed 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -83,7 +83,7 @@ void __init device_tree_init(void)
 
 int __init plat_of_setup(void)
 {
-	return __dt_register_buses("brcm,bcm3384", "simple-bus");
+	return __dt_register_buses("simple-bus", NULL);
 }
 
 arch_initcall(plat_of_setup);
-- 
2.1.1
