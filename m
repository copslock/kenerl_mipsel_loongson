Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 18:58:54 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47721 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009772AbaLYR5OYeG8R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:14 +0100
Received: by mail-pa0-f52.google.com with SMTP id eu11so12034010pac.11;
        Thu, 25 Dec 2014 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GZInRxuV1pmq7JPMXbe3VHBT9vlRsxFuJ64x3OKEu48=;
        b=Pf6686IWiq0pf4C9yUJlS+q+xyBFNsZnxbzc1uVF05aqMoc4SjYgTaaj/yVn6KTams
         tzZjUUPlEym8dt5JzmRU9xjdoiQVMOH8IeUDKSYPfRMuN9WG/zBHssPHWacTCEgboUeN
         L7l5fjw41ZdgE+jhPKJpP7u55qzvV0ishlgAirF9BVgKYtVfQVF5Gvh/MkEEGIsObfTv
         Uw540LqGV+Ew/M3vhOHayAkdmAdPHk0Aaq7QL2oiqZJwwk1iqZjZNdHEw+2S4hO7UHIx
         MZEbXc2ddrmBiLzk5U4fzBHSfaj90w5gjPuP6SKEQ88AfwgcLe3Nvac3zo/vZ7k/Wd9j
         ldOg==
X-Received: by 10.68.138.229 with SMTP id qt5mr63035634pbb.62.1419530228798;
        Thu, 25 Dec 2014 09:57:08 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.07
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:08 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 06/25] irqchip: Update docs regarding irq_domain_add_tree()
Date:   Thu, 25 Dec 2014 09:49:01 -0800
Message-Id: <1419529760-9520-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44916
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
index 39cfa72..3a8e15c 100644
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
