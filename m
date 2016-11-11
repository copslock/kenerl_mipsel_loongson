From: Jan Glauber <jglauber@cavium.com>
Date: Fri, 11 Nov 2016 09:40:15 +0100
Subject: [PATCH 3/3] i2c: octeon: thunderx: Debug prints for timeout and
 recovery
Message-ID: <20161111084015.Il2y6LnQXNDivL8oqEKOTMTgL-Q5O6jU8oelCBMf6Vc@z>

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 1d8775799..a2a92b6 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -72,9 +72,10 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 		return 0;
 	}
 
-	if (!time_left)
+	if (!time_left) {
+		pr_err("%s: timed out\n", __func__);
 		return -ETIMEDOUT;
-
+	}
 	return 0;
 }
 
@@ -169,8 +170,10 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 		return 0;
 	}
 
-	if (!time_left)
+	if (!time_left) {
+		pr_err("%s: timed out\n", __func__);
 		return -ETIMEDOUT;
+	}
 	return 0;
 }
 
@@ -280,6 +283,7 @@ static int octeon_i2c_start(struct octeon_i2c *i2c)
 
 error:
 	/* START failed, try to recover */
+	pr_err("%s: try to recover from status: %d\n", __func__, stat);
 	ret = octeon_i2c_recovery(i2c);
 	return (ret) ? ret : -EAGAIN;
 }
-- 
1.9.1


--T4sUOijqQbZv57TR--
