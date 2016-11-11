From: Jan Glauber <jglauber@cavium.com>
Date: Fri, 11 Nov 2016 09:34:34 +0100
Subject: [PATCH 2/3] i2c: octeon: thunderx: Remove polling after interrupt
Message-ID: <20161111083434.dbAT_NLoeNBwmRD3Z_g8ZHmRxG9DM4DA4VEz9s3kF88@z>

Remove the polling after the interrupt. In case the IFLG
is not set although the interrupt occured we will run into
a timeout and retry the operation. This should happen very
seldom.

Note: the default timeout (1s) can be changed via an ioclt
per device.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 43 ++----------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 0b02070..1d8775799 100644
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
1.9.1


--T4sUOijqQbZv57TR
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0003-i2c-octeon-thunderx-Debug-prints-for-timeout-and-rec.patch"
