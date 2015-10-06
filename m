Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 16:13:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57807 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009658AbbJFOMmtXs8k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Oct 2015 16:12:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0138A5979AFD5;
        Tue,  6 Oct 2015 15:12:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 6 Oct 2015 15:12:36 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 6 Oct 2015 15:12:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] ttyFDC: Fix build problems due to use of module_{init,exit}
Date:   Tue, 6 Oct 2015 15:12:06 +0100
Message-ID: <1444140726-5740-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.9
In-Reply-To: <1444140726-5740-1-git-send-email-james.hogan@imgtec.com>
References: <1444140726-5740-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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
Cc: <stable@vger.kernel.org> # 4.2.x-
---
 drivers/tty/mips_ejtag_fdc.c | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index a8c8cfd52a23..57ff5d3157a6 100644
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
@@ -1152,12 +1120,11 @@ static struct mips_cdmm_driver mips_ejtag_fdc_tty_driver = {
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
-- 
2.4.9
