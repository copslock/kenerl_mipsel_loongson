Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 10:33:27 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35234 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992836AbcLIJcebMREt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 10:32:34 +0100
Received: by mail-wm0-f68.google.com with SMTP id a20so2757175wme.2
        for <linux-mips@linux-mips.org>; Fri, 09 Dec 2016 01:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7aEkGhXFVZS+QN8Fx0NkxfvwgmNUL0TARjhuTGCdZNU=;
        b=JgtEgwqTCZ3y8oBD3gAQAyLqEubWb/P04db2UHOBWpjw4RMnlqPS4WzVSASFnL4HXd
         7mftb/6e4Tc2oyWi9FLOl4xwyVNqtHA4O4i2QHYCR/G2YhUEbotU0muOiHMX04Dte1xS
         6055n4/oruQqSll+srpWB1MFLZvtlqTJz4/5Wz6HurxeGZHQDehQyiMzfLI1HMnkHCUg
         eRxbnsn9C4q1Y4whSK/FkPJXdHI2w5byjLgQVeP0qTsyt5qxlaTnkYOJZwLvHSPYFe42
         yy4B4beN4AQTgD0j6ZwmnhSRuzCm47BospPVSz1Ou/oac0t7HT2ciw3orKAYaqbuJ9ON
         Ru2A==
X-Gm-Message-State: AKaTC00QFmMB3vsbrEQuRvfMYHISjotlmr6Rp8XvI1TUyOg7NqWL8bPaQFgUmV/rkjVzxg==
X-Received: by 10.28.132.193 with SMTP id g184mr5582673wmd.130.1481275948064;
        Fri, 09 Dec 2016 01:32:28 -0800 (PST)
Received: from localhost.localdomain (HSI-KBW-046-005-206-247.hsi8.kabel-badenwuerttemberg.de. [46.5.206.247])
        by smtp.gmail.com with ESMTPSA id k11sm19529619wmf.24.2016.12.09.01.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 01:32:27 -0800 (PST)
From:   Jan Glauber <jglauber@cavium.com>
To:     Wolfram Sang <wsa-dev@sang-engineering.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 2/4] i2c: octeon: thunderx: Remove double-check after interrupt
Date:   Fri,  9 Dec 2016 10:31:56 +0100
Message-Id: <20161209093158.3161-3-jglauber@cavium.com>
X-Mailer: git-send-email 2.9.0.rc0.21.g7777322
In-Reply-To: <20161209093158.3161-1-jglauber@cavium.com>
References: <20161209093158.3161-1-jglauber@cavium.com>
Return-Path: <jan.glauber@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jglauber@cavium.com
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

Commit 1bb1ff3e7c74 ("i2c: octeon: Improve performance if interrupt is
early") added a double-check around the wait_event_timeout() condition.
The performance problem that this commit tried to work-around
could not be reproduced. It also makes the wait condition more
complicated then it should be. Therefore remove the double-check.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 43 ++----------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 2b8a7bf..3d10f1a 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -36,24 +36,6 @@ static bool octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 	return (octeon_i2c_ctl_read(i2c) & TWSI_CTL_IFLG);
 }
 
-static bool octeon_i2c_test_ready(struct octeon_i2c *i2c, bool *first)
-{
-	if (octeon_i2c_test_iflg(i2c))
-		return true;
-
-	if (*first) {
-		*first = false;
-		return false;
-	}
-
-	/*
-	 * IRQ has signaled an event but IFLG hasn't changed.
-	 * Sleep and retry once.
-	 */
-	usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
-	return octeon_i2c_test_iflg(i2c);
-}
-
 /**
  * octeon_i2c_wait - wait for the IFLG to be set
  * @i2c: The struct octeon_i2c
@@ -63,7 +45,6 @@ static bool octeon_i2c_test_ready(struct octeon_i2c *i2c, bool *first)
 static int octeon_i2c_wait(struct octeon_i2c *i2c)
 {
 	long time_left;
-	bool first = true;
 
 	/*
 	 * Some chip revisions don't assert the irq in the interrupt
@@ -80,7 +61,7 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	}
 
 	i2c->int_enable(i2c);
-	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_ready(i2c, &first),
+	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
 				       i2c->adap.timeout);
 	i2c->int_disable(i2c);
 
@@ -102,25 +83,6 @@ static bool octeon_i2c_hlc_test_valid(struct octeon_i2c *i2c)
 	return (__raw_readq(i2c->twsi_base + SW_TWSI(i2c)) & SW_TWSI_V) == 0;
 }
 
-static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c, bool *first)
-{
-	/* check if valid bit is cleared */
-	if (octeon_i2c_hlc_test_valid(i2c))
-		return true;
-
-	if (*first) {
-		*first = false;
-		return false;
-	}
-
-	/*
-	 * IRQ has signaled an event but valid bit isn't cleared.
-	 * Sleep and retry once.
-	 */
-	usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
-	return octeon_i2c_hlc_test_valid(i2c);
-}
-
 static void octeon_i2c_hlc_int_clear(struct octeon_i2c *i2c)
 {
 	/* clear ST/TS events, listen for neither */
@@ -176,7 +138,6 @@ static void octeon_i2c_hlc_disable(struct octeon_i2c *i2c)
  */
 static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
-	bool first = true;
 	int time_left;
 
 	/*
@@ -195,7 +156,7 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 
 	i2c->hlc_int_enable(i2c);
 	time_left = wait_event_timeout(i2c->queue,
-				       octeon_i2c_hlc_test_ready(i2c, &first),
+				       octeon_i2c_hlc_test_valid(i2c),
 				       i2c->adap.timeout);
 	i2c->hlc_int_disable(i2c);
 	if (!time_left)
-- 
2.9.0.rc0.21.g7777322
