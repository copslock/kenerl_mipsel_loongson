Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2014 10:42:03 +0100 (CET)
Received: from mail-ee0-f51.google.com ([74.125.83.51]:53417 "EHLO
        mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816414AbaCZJmAGiIHv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2014 10:42:00 +0100
Received: by mail-ee0-f51.google.com with SMTP id c13so1429737eek.10
        for <linux-mips@linux-mips.org>; Wed, 26 Mar 2014 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yNpenRLimZQtUqldrksPHGKj3HWJ0PV7I7sGcNjIyoc=;
        b=V1LZcreAR6q/IprbncxK4ZtgfaEKQSFVDm9QRK632mdLQy443iNWsxqdhh8HXlfTqz
         ZTM06umqeUo2Ovyhkov77HTQAw6I1SpglDrKZPWXNWFXoKBXSi3t+wugeENU6HaAPk4t
         dTCGg2skxqzRZeGNYAeo405h/HWfl/drHaCSoy/5C14vSyvhqzqu7RR8wDmQl1hX3Bm9
         r6mimqumFZsW8d1RfU67URGhpFj12XHddOsUTzZ63OeTwY93GEtep81hq02hpAQTuVr1
         qqN9r6RRP8+gp2PRwGWe2Z+nh97IC1lzW/+cicJlSh6uZLmGrB+d8mbzXK5UUfizqP0U
         kFCQ==
X-Received: by 10.15.53.135 with SMTP id r7mr1281492eew.102.1395826914029;
        Wed, 26 Mar 2014 02:41:54 -0700 (PDT)
Received: from localhost.localdomain (p4FD8D458.dip0.t-ipconnect.de. [79.216.212.88])
        by mx.google.com with ESMTPSA id w12sm46087849eez.36.2014.03.26.02.41.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Mar 2014 02:41:53 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/3] MIPS: Alchemy: fix default Alchemy board
Date:   Wed, 26 Mar 2014 10:41:47 +0100
Message-Id: <1395826909-14772-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Forgot to update default board after changing
CONFIG_DB1000 to CONFIG_DB1XXXX.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Please fold this into commit a1c91a372b34a7a61234e07d6850bc2b1f121367 (MIPS: Alchemy: Unify Devboard support.)
in lmo/upstream-sfr.git repo.  Thank you!

 arch/mips/alchemy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index ef53681..b962898 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -16,7 +16,7 @@ config ALCHEMY_GPIO_INDIRECT
 choice
 	prompt "Machine type"
 	depends on MIPS_ALCHEMY
-	default MIPS_DB1000
+	default MIPS_DB1XXX
 
 config MIPS_MTX1
 	bool "4G Systems MTX-1 board"
-- 
1.9.1
