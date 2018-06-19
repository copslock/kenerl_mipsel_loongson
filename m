Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 23:48:15 +0200 (CEST)
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43978 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993097AbeFSVrXoLc0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 23:47:23 +0200
Received: by mail-yw0-f194.google.com with SMTP id r19-v6so441958ywc.10;
        Tue, 19 Jun 2018 14:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wLVnH7vIuGi0xSrrr/f9kAJNZm3q+kno8SThjP7bEPk=;
        b=lDVCZfnFimmHdQ1nHaWryPZBrq59VsmwZKnG71CC4IVK9HzirENrA45ap3zf2DqsHl
         bS9wA3wdJTP951CYEBVh+l6p0vBYoNWfIfZ2l+Kg9KZFMGmmUe6cKog5LQQTpD9ybcSV
         RVHzv7dmml7DZc6LZY8KOTHiole+8Fm3F5V3O3UaVxh8PniwMp54sPOTzYhyGCxhHRqe
         nBCQoYVRnUB1Ibh/cDAOCmLNpACal1PrQH1wQbTStcr4gLdFhhG33Bdotpm9vD0xbrQj
         ae4HN419yJTBBhQ2mZ4gvpS5CS32cXbBk1Vw22NyN5QkDsXydh+/QYUJz1DfGHKm3By+
         UhaA==
X-Gm-Message-State: APt69E3OhxXFI43gkE/ACenE1y2f8cMa0xI1IdJAXdnF/OtGi6sJr0nW
        zhkzKM+6+o6bIiFb29teOIqzD8A=
X-Google-Smtp-Source: ADUXVKK95K8qb9qEUxyZffW815yMRebygAB5bY6ffYmiYsR8JhWIoRoWunrDUe6Q+dKD/gP3UWe7Kw==
X-Received: by 2002:a0d:c905:: with SMTP id l5-v6mr9331254ywd.308.1529444837527;
        Tue, 19 Jun 2018 14:47:17 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/5] MIPS: bmips: remove unnecessary call to register "simple-bus"
Date:   Tue, 19 Jun 2018 15:47:08 -0600
Message-Id: <20180619214710.22066-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
References: <20180619214710.22066-1-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

The DT core will register "simple-bus" by default, so it is not necessary
for arch specific code to do so unless there are custom match entries,
auxdata or parent device. Neither of those apply here, so remove the call.

Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/bmips/setup.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 3b6f687f177c..231fc5ce375e 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -202,13 +202,6 @@ void __init device_tree_init(void)
 	of_node_put(np);
 }
 
-int __init plat_of_setup(void)
-{
-	return __dt_register_buses("simple-bus", NULL);
-}
-
-arch_initcall(plat_of_setup);
-
 static int __init plat_dev_init(void)
 {
 	of_clk_init(NULL);
-- 
2.17.1
