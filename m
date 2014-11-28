Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 05:33:29 +0100 (CET)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34430 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007460AbaK1EdMWbS4Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Nov 2014 05:33:12 +0100
Received: by mail-pd0-f169.google.com with SMTP id fp1so5919069pdb.0
        for <multiple recipients>; Thu, 27 Nov 2014 20:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k3C5fa6kZFWI6kh2ZszkHDagvRnpFy107aTkvOjbFNc=;
        b=cQMcRdHej/f9EFdgcVyPOAcwLU/m/7/tlleAPJ14riQzeHXNhGZUIOikIuYwPEFoWf
         pc+huFWOLqL988F2gTz8c2eaL/ZgN+ufiB1/aY8MCGu6JzKa6K0iAWZlgCLtz/84UI2e
         /9Od5RH6mSA++0QHntMHIlSvVrO2LSVhEuAmmYWni9Anhi+pnoo/wxs70I+vg+652W/l
         xMeHj7Ng2jDM2BRZ3X9mVHRkXi6+koXiSbf1mdoRWwkoo3pJTAZ953Vkp6YgiIvbpIXd
         gz4eVazgLZdy6FZ2OF8ipJC1vuu5O4gTUMkdD3lv8X00lIQU2XbBQB0tKzoX6b3YhR1C
         XP+A==
X-Received: by 10.68.229.33 with SMTP id sn1mr69185744pbc.63.1417149186390;
        Thu, 27 Nov 2014 20:33:06 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id u5sm8482887pdc.79.2014.11.27.20.33.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Nov 2014 20:33:05 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 01/16] irqchip: Update docs regarding irq_domain_add_tree()
Date:   Thu, 27 Nov 2014 20:32:07 -0800
Message-Id: <1417149142-3756-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44492
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

Several drivers now use this API, including the ARM GIC driver, so remove
the outdated comment.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 Documentation/IRQ-domain.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/IRQ-domain.txt b/Documentation/IRQ-domain.txt
index 8a8b82c9ca53..0ccd7b7f6043 100644
--- a/Documentation/IRQ-domain.txt
+++ b/Documentation/IRQ-domain.txt
@@ -95,8 +95,7 @@ since it doesn't need to allocate a table as large as the largest
 hwirq number.  The disadvantage is that hwirq to IRQ number lookup is
 dependent on how many entries are in the table.
 
-Very few drivers should need this mapping.  At the moment, powerpc
-iseries is the only user.
+Very few drivers should need this mapping.
 
 ==== No Map ===-
 irq_domain_add_nomap()
-- 
2.1.0
