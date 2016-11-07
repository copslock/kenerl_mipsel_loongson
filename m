Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 21:10:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40019 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992009AbcKGUKAikmV8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 21:10:00 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8C6C12101EACC;
        Mon,  7 Nov 2016 20:09:50 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 20:09:53 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-i2c@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        Peter Swain <pswain@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
Date:   Mon, 7 Nov 2016 20:09:21 +0000
Message-ID: <20161107200921.30284-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107200921.30284-1-paul.burton@imgtec.com>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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
early") modified octeon_i2c_wait() & octeon_i2c_hlc_wait() to attempt to
check for a valid bit being clear & if not to sleep for a while then try
again before waiting on a waitqueue which may time out. However it does
so by sleeping within a function called as the condition provided to
wait_event_timeout() which seems to cause strange behaviour, with the
system hanging during boot with the condition being checked constantly &
the timeout not seeming to have any effect.

Fix this by instead checking for the valid bit being clear in the
octeon_i2c(_hlc)_wait() functions & sleeping there if that condition is
not met, then calling the wait_event_timeout with a condition that does
not sleep.

Tested on a Rhino Labs UTM-8 with Octeon CN7130.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Jan Glauber <jglauber@cavium.com>
Cc: Peter Swain <pswain@cavium.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
---

 drivers/i2c/busses/i2c-octeon-core.c | 58 ++++++++++--------------------------
 1 file changed, 15 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 419b54b..2e270a1 100644
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
@@ -80,8 +62,13 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	}
 
 	i2c->int_enable(i2c);
-	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_ready(i2c, &first),
-				       i2c->adap.timeout);
+	time_left = i2c->adap.timeout;
+	if (!octeon_i2c_test_iflg(i2c)) {
+		usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
+		time_left = wait_event_timeout(i2c->queue,
+					       octeon_i2c_test_iflg(i2c),
+					       time_left);
+	}
 	i2c->int_disable(i2c);
 
 	if (i2c->broken_irq_check && !time_left &&
@@ -99,26 +86,8 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 
 static bool octeon_i2c_hlc_test_valid(struct octeon_i2c *i2c)
 {
-	return (__raw_readq(i2c->twsi_base + SW_TWSI(i2c)) & SW_TWSI_V) == 0;
-}
-
-static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c, bool *first)
-{
 	/* check if valid bit is cleared */
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
+	return (__raw_readq(i2c->twsi_base + SW_TWSI(i2c)) & SW_TWSI_V) == 0;
 }
 
 static void octeon_i2c_hlc_int_clear(struct octeon_i2c *i2c)
@@ -176,7 +145,6 @@ static void octeon_i2c_hlc_disable(struct octeon_i2c *i2c)
  */
 static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
-	bool first = true;
 	int time_left;
 
 	/*
@@ -194,9 +162,13 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 	}
 
 	i2c->hlc_int_enable(i2c);
-	time_left = wait_event_timeout(i2c->queue,
-				       octeon_i2c_hlc_test_ready(i2c, &first),
-				       i2c->adap.timeout);
+	time_left = i2c->adap.timeout;
+	if (!octeon_i2c_hlc_test_valid(i2c)) {
+		usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
+		time_left = wait_event_timeout(i2c->queue,
+					       octeon_i2c_hlc_test_valid(i2c),
+					       time_left);
+	}
 	i2c->hlc_int_disable(i2c);
 	if (!time_left)
 		octeon_i2c_hlc_int_clear(i2c);
-- 
2.10.2
