Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 20:18:10 +0100 (BST)
Received: from [64.94.143.173] ([64.94.143.173]:61382 "HELO moon.ketl.com")
	by ftp.linux-mips.org with SMTP id S20022268AbXJBTSC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 20:18:02 +0100
Received: (qmail 18819 invoked by uid 1006); 2 Oct 2007 18:44:35 -0000
Date:	Tue, 2 Oct 2007 11:44:35 -0700
From:	Chris David <cd@chrisdavid.com>
To:	linux-mips@linux-mips.org
Subject: 2.6 Patch for AMD MIPS Alchemy au1550 I2C interface I2C
Message-ID: <20071002184435.GB18766@moon.ketl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <cd@moon.ketl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cd@chrisdavid.com
Precedence: bulk
X-list: linux-mips

Hello,

Please CC me on replies.

Here is a trivial patch to fix a "mis-used register" problem on the
AMD MIPS Alchemy au1550 I2C interface.  

In summary, The programmable serial controller seem to hang the kernel
when I sent a single an 'address' byte on the I2C bus.  The patch
essentially uses the PSC_SMBSTAT register's TE (transmit FIFO empty)
bit to check when the transmit FIFO is empty, instead of using the
PSC_SMBEVNT register's TU (transmit underflow) bit.  Using the TE bit
fixed the hang problem.

I tested this on kernel 2.6.16, and confirmed the patch updates the
2.6.22 kernel correctly.  If someone else can test this, that would be
great.  And I think it should be included in the kernel.

Again, please CC me on replies.

Thanks,

-Chris


Signed-off-by: Chris David <cd@chrisdavid.com>
---
diff -Naur linux-2.6.16-orig/drivers/i2c/busses/i2c-au1550.c linux-2.6.16/drivers/i2c/busses/i2c-au1550.c
--- linux-2.6.16-orig/drivers/i2c/busses/i2c-au1550.c   2007-09-26 08:38:45.000000000 -0700
+++ linux-2.6.16/drivers/i2c/busses/i2c-au1550.c        2007-09-26 08:43:43.000000000 -0700
@@ -61,17 +61,14 @@
 
        sp = (volatile psc_smb_t *)(adap->psc_base);
 
-       /* Wait for Tx FIFO Underflow.
+       /* Wait for Tx Buffer Empty
        */
        for (i = 0; i < adap->xfer_timeout; i++) {
-               stat = sp->psc_smbevnt;
+               stat = sp->psc_smbstat;
                au_sync();
-               if ((stat & PSC_SMBEVNT_TU) != 0) {
-                       /* Clear it.  */
-                       sp->psc_smbevnt = PSC_SMBEVNT_TU;
-                       au_sync();
+               if ((stat & PSC_SMBSTAT_TE) != 0)
                        return 0;
-               }
+
                udelay(1);
        }
