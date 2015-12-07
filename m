Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 16:07:46 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:43484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011821AbbLGPHo1uzQc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 16:07:44 +0100
Received: from localhost (unknown [66.228.68.140])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3BECA81;
        Mon,  7 Dec 2015 15:07:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Jiri Slaby <jslaby@suse.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 4.3 120/125] ttyFDC: Fix build problems due to use of module_{init,exit}
Date:   Mon,  7 Dec 2015 10:02:13 -0500
Message-Id: <20151207145758.117823840@linuxfoundation.org>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <20151207145752.225938417@linuxfoundation.org>
References: <20151207145752.225938417@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.3-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 3e8137a185240fa6da0ff91cd9c604716371903b upstream.

Commit 0fd972a7d91d (module: relocate module_init from init.h to
module.h) broke the build of ttyFDC driver due to that driver's (mis)use
of module_mips_cdmm_driver() without first including module.h, for
example:

In file included from ./arch/mips/include/asm/cdmm.h +11 :0,
                 from drivers/tty/mips_ejtag_fdc.c +34 :
include/linux/device.h +1295 :1: warning: data definition has no type or storage class
./arch/mips/include/asm/cdmm.h +84 :2: note: in expansion of macro ‘module_driver’
drivers/tty/mips_ejtag_fdc.c +1157 :1: note: in expansion of macro ‘module_mips_cdmm_driver’
include/linux/device.h +1295 :1: error: type defaults to ‘int’ in declaration of ‘module_init’ [-Werror=implicit-int]
./arch/mips/include/asm/cdmm.h +84 :2: note: in expansion of macro ‘module_driver’
drivers/tty/mips_ejtag_fdc.c +1157 :1: note: in expansion of macro ‘module_mips_cdmm_driver’
drivers/tty/mips_ejtag_fdc.c +1157 :1: warning: parameter names (without types) in function declaration

Instead of just adding the module.h include, switch to using the new
builtin_mips_cdmm_driver() helper macro and drop the remove callback,
since it isn't needed. If module support is added later, the code can
always be resurrected.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/mips_ejtag_fdc.c |   35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -1048,38 +1048,6 @@ err_destroy_ports:
 	return ret;
 }
 
-static int mips_ejtag_fdc_tty_remove(struct mips_cdmm_device *dev)
-{
-	struct mips_ejtag_fdc_tty *priv = mips_cdmm_get_drvdata(dev);
-	struct mips_ejtag_fdc_tty_port *dport;
-	int nport;
-	unsigned int cfg;
-
-	if (priv->irq >= 0) {
-		raw_spin_lock_irq(&priv->lock);
-		cfg = mips_ejtag_fdc_read(priv, REG_FDCFG);
-		/* Disable interrupts */
-		cfg &= ~(REG_FDCFG_TXINTTHRES | REG_FDCFG_RXINTTHRES);
-		cfg |= REG_FDCFG_TXINTTHRES_DISABLED;
-		cfg |= REG_FDCFG_RXINTTHRES_DISABLED;
-		mips_ejtag_fdc_write(priv, REG_FDCFG, cfg);
-		raw_spin_unlock_irq(&priv->lock);
-	} else {
-		priv->removing = true;
-		del_timer_sync(&priv->poll_timer);
-	}
-	kthread_stop(priv->thread);
-	if (dev->cpu == 0)
-		mips_ejtag_fdc_con.tty_drv = NULL;
-	tty_unregister_driver(priv->driver);
-	for (nport = 0; nport < NUM_TTY_CHANNELS; nport++) {
-		dport = &priv->ports[nport];
-		tty_port_destroy(&dport->port);
-	}
-	put_tty_driver(priv->driver);
-	return 0;
-}
-
 static int mips_ejtag_fdc_tty_cpu_down(struct mips_cdmm_device *dev)
 {
 	struct mips_ejtag_fdc_tty *priv = mips_cdmm_get_drvdata(dev);
@@ -1152,12 +1120,11 @@ static struct mips_cdmm_driver mips_ejta
 		.name	= "mips_ejtag_fdc",
 	},
 	.probe		= mips_ejtag_fdc_tty_probe,
-	.remove		= mips_ejtag_fdc_tty_remove,
 	.cpu_down	= mips_ejtag_fdc_tty_cpu_down,
 	.cpu_up		= mips_ejtag_fdc_tty_cpu_up,
 	.id_table	= mips_ejtag_fdc_tty_ids,
 };
-module_mips_cdmm_driver(mips_ejtag_fdc_tty_driver);
+builtin_mips_cdmm_driver(mips_ejtag_fdc_tty_driver);
 
 static int __init mips_ejtag_fdc_init_console(void)
 {
