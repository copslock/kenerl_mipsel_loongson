From: Jan Glauber <jglauber@cavium.com>
Date: Fri, 11 Nov 2016 09:17:19 +0100
Subject: [PATCH 1/3] i2c: octeon: thunderx: TWSI software reset in recovery
Message-ID: <20161111081719.Z0wdWjuoHwGpowakauH8Oicg7wB_ELCG7mUGotsr1nY@z>

I've seen i2c recovery reporting long loops of:

[ 1035.887818] i2c i2c-4: SCL is stuck low, exit recovery
[ 1037.999748] i2c i2c-4: SCL is stuck low, exit recovery
[ 1040.111694] i2c i2c-4: SCL is stuck low, exit recovery
...

Add a TWSI software reset which clears the status and
STA,STP,IFLG in SW_TWSI_EOP_TWSI_CTL.

With this the recovery works fine and above message is not seen.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 419b54b..0b02070 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -791,6 +791,9 @@ static void octeon_i2c_prepare_recovery(struct i2c_adapter *adap)
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 
 	octeon_i2c_hlc_disable(i2c);
+	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_RST, 0);
+	/* wait for software reset to settle */
+	udelay(5);
 
 	/*
 	 * Bring control register to a good state regardless
-- 
1.9.1


--T4sUOijqQbZv57TR
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0002-i2c-octeon-thunderx-Remove-polling-after-interrupt.patch"
