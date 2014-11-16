Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:25:05 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41898 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013778AbaKPAT4bt9Vn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:56 +0100
Received: by mail-pa0-f49.google.com with SMTP id lj1so19726067pab.22
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qeLd8z76obpwW03iGOPN8WoDO40jZ9ToNP10lz7QhqQ=;
        b=oOJCbzGFWSBMLIoPyzlbQCJv2uTuOxNhNT11kyQeMvM2ExqjMmwLSrn0P+0yp5Tw61
         u5i1ImfLcsjMKoUGma9fXdmuTemnJgawcIjZv4GU+eH2jnBf2MI0UH3OdukaiT71qKA8
         rtzhITZGeppSt5wElRv53vT1mKrqoqTyEuOW7OlmkLPLWD5csB90KyDkI/EQE5YOPObW
         0/iE7DxfKWCo2Wo9CJwkIFppXxLySIeVTZU4e15uHWoKLcHwwe/oLQMyO6b31DWTY9YX
         GUXFsph1mzIZNHeehETcoBIG35auBq3GbHxOd5q1fgziEoPuwRwu2tNAygMmwJMeHC7x
         Ol6g==
X-Received: by 10.70.100.170 with SMTP id ez10mr19590263pdb.73.1416097190910;
        Sat, 15 Nov 2014 16:19:50 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:50 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 20/22] MAINTAINERS: Add entry for bcm63xx/bcm33xx UDC gadget driver
Date:   Sat, 15 Nov 2014 16:17:44 -0800
Message-Id: <1416097066-20452-21-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44211
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

This hardware shows up on the newly-supported BCM3384 cable chip, as well
as several old BCM63xx DSL chips.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5e8a55..6ab20b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2094,6 +2094,12 @@ S:	Maintained
 F:	arch/arm/mach-bcm/bcm63xx.c
 F:	arch/arm/include/debug/bcm63xx.S
 
+BROADCOM BCM63XX/BCM33XX UDC DRIVER
+M:	Kevin Cernekee <cernekee@gmail.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/gadget/udc/bcm63xx_udc.*
+
 BROADCOM BCM7XXX ARM ARCHITECTURE
 M:	Marc Carino <marc.ceeeee@gmail.com>
 M:	Brian Norris <computersforpeace@gmail.com>
-- 
2.1.1
