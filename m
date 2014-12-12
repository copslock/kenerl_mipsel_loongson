Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:09:30 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36955 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008595AbaLLWIZBxDmX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:25 +0100
Received: by mail-pa0-f50.google.com with SMTP id bj1so8091735pad.9
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GZInRxuV1pmq7JPMXbe3VHBT9vlRsxFuJ64x3OKEu48=;
        b=LlOtVLc3KMejo/y/J2iVgGR70/Ze4bIaMGMKDLkhfwJuBiqexHyZ4DVidKG3x6gH/c
         TLk9eqZHOrI41290xXh0nL/SuvVx8eVcYppMDMAqiwKypuotHbBt3i6QR/U4XWSPac7r
         rbwyrvf1NJ0XG3HbX5nCgSEm78GlNR5FiLhfm0gFBdFfsgklaqVpdP45bHC7D/QmCEd/
         TpM1zpuTN8xQtxtF+8Fjbpe7DJQaDmUoRCsCtPu9HIN838AwI7KEzmRljSZaR+2elavB
         ktkZBWWaEoYhUl3IeXXp55oqoVAVww8rQajAEPScO9rnfJ6VSC12knj9SnlGbFytfl+I
         Xtxg==
X-Received: by 10.70.134.36 with SMTP id ph4mr30407994pdb.29.1418422099360;
        Fri, 12 Dec 2014 14:08:19 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:18 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 04/23] irqchip: Update docs regarding irq_domain_add_tree()
Date:   Fri, 12 Dec 2014 14:06:55 -0800
Message-Id: <1418422034-17099-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44642
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
