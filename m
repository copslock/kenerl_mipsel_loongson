Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:19:44 +0100 (CET)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:58354 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013745AbaKPAT0kVnD5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:26 +0100
Received: by mail-pd0-f175.google.com with SMTP id y10so152620pdj.20
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Na0rTQCSF+j0epU6CM5wSxMKjB5oKdzSLGrwQq2XsI=;
        b=P/ORJi0Mer570WaRktLnacV1obSaLwb9cI8U55+ttG4bfbHEJIc57r7EhVn40O6ldA
         A+Kgb6UJoicQLDeRuVEQsQlXZzRGPpfyIJiyt3jAa4CpYolWtUh/xOtcyKKz9hwfuGsV
         DbpZD1616JtTBLYj8PrKsWAt9Mm1Zwe9O77plENVZutppwTFcxsRyVFmUcYqxNCKnNWf
         QMKlwxfFlKw37uf4mqm5urC8p4tGIwYa4XoKV5K4SQ6pUwKv/DXY1oMzhbB7NemUyU8I
         B1zflTlW33a4TY9rD1tr+SDu7NF6L1GAG0Wu8iqxZ1SYpmrVQvNMBcjyadO/UY+a8Z9D
         Z5qQ==
X-Received: by 10.70.43.176 with SMTP id x16mr19608798pdl.31.1416097160871;
        Sat, 15 Nov 2014 16:19:20 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:20 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/22] irqchip: Update docs regarding irq_domain_add_tree()
Date:   Sat, 15 Nov 2014 16:17:25 -0800
Message-Id: <1416097066-20452-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44192
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
index 8a8b82c..0ccd7b7 100644
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
2.1.1
