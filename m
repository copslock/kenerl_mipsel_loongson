Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:12:53 +0100 (CET)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:42750 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008620AbaLLWIpjPK4A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:45 +0100
Received: by mail-pd0-f169.google.com with SMTP id z10so8005000pdj.0
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sSBtdIMQ5rzsUuM6Cg9oOWGf56VdUst0rjRplCFSl6o=;
        b=vRs6gQjZiWaDtnqf+24sIJDc9xf1Nvo9A7NWEVS2J9Rm7tknkjeXvJNj6GtVyK7xVb
         lchUwdo1Kx9FQ1tpVoyCfBYVswXhRVNErZMoC0Mf/sQFURWiGQTzyE4YAl2mkPa5TaDc
         XYKaeunx6hBFPWCLOXkpB625KvZpUXspf0ERea2qPVGXYYxKhDiUWgh3gSLz8aQhHVBz
         QSIbync+XZZ7fe0ZZRCTFqCWXF70u4ncbXEZFQm4kE9eZBbH5QB3ztC+IVBCUv0+Mhvs
         Z3vIJZn5vGOE8Xx7l+q01sYTRoJVejLgn/k2yPD7gOhaSzvhAdZiqkRLlWzqCgdBNqZH
         rXyQ==
X-Received: by 10.68.179.5 with SMTP id dc5mr30483809pbc.147.1418422120036;
        Fri, 12 Dec 2014 14:08:40 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:39 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 16/23] MIPS: BMIPS: Remove bogus bus name
Date:   Fri, 12 Dec 2014 14:07:07 -0800
Message-Id: <1418422034-17099-17-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44654
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
