Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 03:41:16 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:40411 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006765AbaKXCk5LJluX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 03:40:57 +0100
Received: by mail-pd0-f180.google.com with SMTP id p10so8823687pdj.25
        for <multiple recipients>; Sun, 23 Nov 2014 18:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zt11MGmRIcaKo0zDscYobZLl9knemw4Zh6OYtnP50Dk=;
        b=PPYBj97h4SEc7mIwfEVpOyPJQbvun8IEtG2jQbofvC8v9McqM+WELSUeVucET91u6P
         TrZtwsc6dRQVxh/LDsB1tiZciB5+GopbxGe2FoUtfVE01exP+iPaW1J33HUW55xn0Fw1
         Ph1PwujaBLiTcB8ZKgdEvexI8i92zUZR3KrVG/IogGJkfCpalCG9ZtlrfVldsnqmrdKu
         3S/PmUrTIS1J8ybO3Bd5bGhuAEqJH18vKywq7d0Kh31K2wIKJYM0JE2+QFVvqv+pYDGM
         fyguAS0WlJlhEVYEZPJJ9E6bGwbbXAMZFObGChoJJnAurz72qvvCMfD59FCskg1HVNBI
         ZB2g==
X-Received: by 10.66.66.135 with SMTP id f7mr29118568pat.67.1416796851059;
        Sun, 23 Nov 2014 18:40:51 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id ml5sm10930673pab.32.2014.11.23.18.40.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Nov 2014 18:40:50 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 01/11] irqchip: Update docs regarding irq_domain_add_tree()
Date:   Sun, 23 Nov 2014 18:40:36 -0800
Message-Id: <1416796846-28149-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44354
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
2.1.1
