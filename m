Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 03:43:19 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:59428 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006778AbaKXClK6SDHw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 03:41:10 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so8601410pab.14
        for <multiple recipients>; Sun, 23 Nov 2014 18:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/t+jUSlEpszrGszDHejaFJDGBrVYxTfPkpwJUK+AiSA=;
        b=cXK1zmXMmkrLqjZ8B7dpJyWw/5SSxaCABgHtWpP2eQAU2pF/JYDMmkVddYMYz5ckmZ
         LUyAmsjUBPN/ACfvw+zz8DnP0KFW0IkeUqVJBlxtYwi3R9mJn3xytcuxcETMwLtvWTgI
         T831YeKiMfK9oUVZhlm8QIzu5FGguIaI311id6e+1Y5azKcaDrRBt81cbh/fq6ozolAj
         1v58Awzoj7zKMiBwz9NPtodwFGbh3R5WXpU/7Hva1KcXtvXvCKWIPFKqb3AIlHhL45UC
         N5lYUtU4No/g+vKDtKQ2VXjj7Dix8880IQR6Kdi3yGbrvr0UmSkoI/FDRG0Ebh7iBdj+
         RYsA==
X-Received: by 10.68.229.33 with SMTP id sn1mr28348836pbc.63.1416796864504;
        Sun, 23 Nov 2014 18:41:04 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id ml5sm10930673pab.32.2014.11.23.18.41.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Nov 2014 18:41:03 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 08/11] MIPS: Let __dt_register_buses accept a single bus type
Date:   Sun, 23 Nov 2014 18:40:43 -0800
Message-Id: <1416796846-28149-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44361
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
2.1.1
