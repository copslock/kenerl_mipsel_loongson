Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2007 06:32:18 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:60172 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022095AbXEPFcQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 May 2007 06:32:16 +0100
Received: (qmail 13028 invoked by uid 1000); 16 May 2007 07:31:13 +0200
Date:	Wed, 16 May 2007 07:31:13 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	i2c@lm-sensors.org
Cc:	linux-mips@linux-mips.org, khali@linux-fr.org
Subject: [PATCH 1/2] i2c-au1550: send i2c stop on error #2
Message-ID: <20070516053113.GA12986@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

When the au1550 i2c driver encounteres an error while addressing a slave
or has no data to send to a slave in the last i2c message, it returns to
the upper layers without issuing a i2c stop condition.  This for example
resulted in the minute register of the RTC on my board to be overwritten
with a random value on a following transfer.

Fix the driver to send a stop over the i2c bus if one of the following
2 conditions are met:
* error when addressing a slave
* no data to send in the last i2c message

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

--- a/drivers/i2c/busses/i2c-au1550.c	2007-04-26 05:08:32.000000000 +0200
+++ b/drivers/i2c/busses/i2c-au1550.c	2007-05-15 20:19:56.000000000 +0200
@@ -260,13 +260,20 @@ static int
 au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_au1550_data *adap = i2c_adap->algo_data;
+	volatile psc_smb_t *sp = (volatile psc_smb_t *)(adap->psc_base);
 	struct i2c_msg *p;
 	int i, err = 0;
 
 	for (i = 0; !err && i < num; i++) {
 		p = &msgs[i];
 		err = do_address(adap, p->addr, p->flags & I2C_M_RD);
-		if (err || !p->len)
+		if (err || ((!p->len) && (i == (num - 1)))) {
+			sp->psc_smbtxrx = PSC_SMBTXRX_STP;
+			au_sync();
+			wait_master_done(adap);
+			continue;
+		}
+		if (!p->len)
 			continue;
 		if (p->flags & I2C_M_RD)
 			err = i2c_read(adap, p->buf, p->len);
