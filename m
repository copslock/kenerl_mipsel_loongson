Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:23:08 +0100 (CET)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32944 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013771AbaKPATqYwY4R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:46 +0100
Received: by mail-pd0-f178.google.com with SMTP id y13so3809162pdi.37
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7iDHcTPuTmwr5l4kg4g1mfylCceznNpeHLIwjk2SH9Y=;
        b=QbKqmunKVtJRuT2/GemjVUp0q4WrfegVCjPNEWso974vGFcp3RdJRe8aaB57PvLkOP
         aAkBIY2ROMl4jT469f7Y8Lu7DL0z0v0C+jcvcViCUzIQbzaTaJNq0D0rulhq54QTojlz
         QNW/DpvBVETSQuHZ73SYRg65ASpbSBbbk2muBi6UoBINa/4ECJjhYZQTj2tX1tDoFDvz
         5rVBGEWAu+sZ0KJ/bsc6JvXhrDeon1ZDLxSpg6VnRJqClWhRz3iR1fM+OeeRLg0fqnEx
         jhXJBUzO5AYZs4A2a8QEyU2QOyzwC+jN/FXITmnBbpx97RAl6+Ze0NJDORLEY3UZM4Zr
         6OOg==
X-Received: by 10.70.129.209 with SMTP id ny17mr40526pdb.163.1416097180460;
        Sat, 15 Nov 2014 16:19:40 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:39 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 13/22] MIPS: Allow MIPS_CPU_SCACHE to be used with different line sizes
Date:   Sat, 15 Nov 2014 16:17:37 -0800
Message-Id: <1416097066-20452-14-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44204
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

CONFIG_MIPS_CPU_SCACHE determines whether to build sc-mips.c.  However,
it is currently hardwired to use an L1_SHIFT of 6 (64 bytes).  Move the
L1_SHIFT selection into the CPU or SoC section so that other SoCs can
select different values.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 92033b7..3d56928 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -326,6 +326,7 @@ config MIPS_MALTA
 	select I8259
 	select MIPS_BONITO64
 	select MIPS_CPU_SCACHE
+	select MIPS_L1_CACHE_SHIFT_6
 	select PCI_GT64XXX_PCI0
 	select MIPS_MSC
 	select SWAP_IO_SPACE
@@ -1909,7 +1910,6 @@ config IP22_CPU_SCACHE
 config MIPS_CPU_SCACHE
 	bool
 	select BOARD_SCACHE
-	select MIPS_L1_CACHE_SHIFT_6
 
 config R5000_CPU_SCACHE
 	bool
-- 
2.1.1
