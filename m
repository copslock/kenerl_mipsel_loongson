Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 05:57:13 +0100 (CET)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36109 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008831AbbCZE4HhHIfl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 05:56:07 +0100
Received: by pdbcz9 with SMTP id cz9so50882558pdb.3;
        Wed, 25 Mar 2015 21:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9zOdgQ7dI1XQbPWIgmDyo3hE1aVfjmDyzWUE5+rFiP0=;
        b=Q7Fs2oiZug6wLGE54VtDr6EWI3a8yX3Ve9nSpuTiUV7tg31DKaFKME+pnZpZkbNt1t
         DGBaqmrUrv/pphTBQdXNlwIxh9YNJFi26G1LluYRVUeGXnd4k4bYZl/olmwMWtJsgE0G
         cmaAif8IyBkFAmgPOTqtlaPoWzPC4QtNpuOFShHWuEoLUfq73UAlIOYlLixaGjRFvLVL
         ilTOTK//FO5/ZIyviLzsXImOUVvnVxKn62eyWB/GNoZY+yfiDOcP8CQeJYzKeNWm6m8d
         XfzCeUJvetBud8PzBKt+Uj546kOcuPr6LuxlKimV4Otl0Ss1NX57E9+ycrqyW/JSLtYV
         //Sw==
X-Received: by 10.70.129.108 with SMTP id nv12mr23449127pdb.71.1427345762493;
        Wed, 25 Mar 2015 21:56:02 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id hz13sm4110902pab.6.2015.03.25.21.56.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2015 21:56:01 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] MIPS: BMIPS: restrict DTB selection to BMIPS_GENERIC
Date:   Wed, 25 Mar 2015 21:55:15 -0700
Message-Id: <1427345715-16516-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1427345715-16516-1-git-send-email-f.fainelli@gmail.com>
References: <1427345715-16516-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Since we are always sourcing arch/mips/bmips/Kconfig and there is no
dependency on BMIPS_GENERIC, we will offer building BMIPS-related DTBs
while this is not relevant for the other MIPS platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bmips/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index 6ffc42cbb846..f35c84c019df 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -1,3 +1,5 @@
+if BMIPS_GENERIC
+
 choice
 	prompt "Built-in device tree"
 	help
@@ -56,3 +58,5 @@ config DT_BCM97425SVMB
 	select BUILTIN_DTB
 
 endchoice
+
+endif
-- 
2.1.0
