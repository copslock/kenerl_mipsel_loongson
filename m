Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 05:36:18 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:60426 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007461AbaK1Ed2XA15J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Nov 2014 05:33:28 +0100
Received: by mail-pa0-f42.google.com with SMTP id et14so6052935pad.15
        for <multiple recipients>; Thu, 27 Nov 2014 20:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NjUvFJ9u467XSz4eGMaDccjflkPeeBPOl//u5an6nYA=;
        b=qE03/BFF+LRvoZ8dRwuTJyp77RUdD8b1dDHnAo2yDX6V4WxyNDi21dR8F/uSI/Tm6b
         aE1FRKBeN3iFba98KdISKNpUv8uPq5+Cgn79JPsUiUNYk2SbrCRo3c0JbyJbBkp6koH3
         6f/gG01dKwbij8R74vc5UJQWu9mwLisJ/t58d3wc48cw801jeFufLGsCFb2G7eucNQZl
         VMISmxbLgQ0mwOFNbF65Oro9Rmhsdf6Om6bssQZQRUNRXqGuDQH2PQI0TXNjJNk4lYs5
         jHjrrivu2t09+mLXTbHmCAYUVBE0WYA3Db2lc0Li6Q+Q+UQiN5hNumFe0lHBnTRIZtTA
         jaWQ==
X-Received: by 10.68.203.130 with SMTP id kq2mr13321872pbc.1.1417149202271;
        Thu, 27 Nov 2014 20:33:22 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id u5sm8482887pdc.79.2014.11.27.20.33.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Nov 2014 20:33:21 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 11/16] MIPS: Reorder MIPS_L1_CACHE_SHIFT priorities
Date:   Thu, 27 Nov 2014 20:32:17 -0800
Message-Id: <1417149142-3756-12-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44502
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

Enabling support for more than one BMIPS CPU in the same build may
result in different L1_CACHE_SHIFT values, e.g.

    CPU_BMIPS5000 selects MIPS_L1_CACHE_SHIFT_7
    CPU_BMIPS4380 selects MIPS_L1_CACHE_SHIFT_6
    anything else defaults to MIPS_L1_CACHE_SHIFT_5

Ensure that if more than one MIPS_L1_CACHE_SHIFT_x option is selected,
Kconfig sets CONFIG_MIPS_L1_CACHE_SHIFT to the highest value.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 601b991dcdce..b4cdf722aeee 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1167,10 +1167,10 @@ config MIPS_L1_CACHE_SHIFT_7
 
 config MIPS_L1_CACHE_SHIFT
 	int
-	default "4" if MIPS_L1_CACHE_SHIFT_4
-	default "5" if MIPS_L1_CACHE_SHIFT_5
-	default "6" if MIPS_L1_CACHE_SHIFT_6
 	default "7" if MIPS_L1_CACHE_SHIFT_7
+	default "6" if MIPS_L1_CACHE_SHIFT_6
+	default "5" if MIPS_L1_CACHE_SHIFT_5
+	default "4" if MIPS_L1_CACHE_SHIFT_4
 	default "5"
 
 config HAVE_STD_PC_SERIAL_PORT
-- 
2.1.0
