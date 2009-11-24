Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 22:08:49 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37787 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1493578AbZKXVIo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 22:08:44 +0100
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1ND2c2-0004hy-Hx; Tue, 24 Nov 2009 22:07:50 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1ND2bw-0004vk-89; Tue, 24 Nov 2009 22:07:44 +0100
From:	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
To:	linux-kernel@vger.kernel.org
Cc:	akpm@linux-foundation.org, Ming Lei <tom.leiming@gmail.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 06/38] move iodev_remove to .devexit.text
Date:	Tue, 24 Nov 2009 22:07:01 +0100
Message-Id: <1259096853-18909-6-git-send-email-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1259096853-18909-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1259096853-18909-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1259096853-18909-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1259096853-18909-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1259096853-18909-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <1259096853-18909-5-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <ukl@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ukl@pengutronix.de
Precedence: bulk
X-list: linux-mips

The function iodev_remove is used only wrapped by __devexit_p so define
it using __devexit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Ming Lei <tom.leiming@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/basler/excite/excite_iodev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/basler/excite/excite_iodev.c b/arch/mips/basler/excite/excite_iodev.c
index 938b1d0..733b242 100644
--- a/arch/mips/basler/excite/excite_iodev.c
+++ b/arch/mips/basler/excite/excite_iodev.c
@@ -34,7 +34,7 @@
 
 static const struct resource *iodev_get_resource(struct platform_device *, const char *, unsigned int);
 static int __init iodev_probe(struct platform_device *);
-static int __exit iodev_remove(struct platform_device *);
+static int __devexit iodev_remove(struct platform_device *);
 static int iodev_open(struct inode *, struct file *);
 static int iodev_release(struct inode *, struct file *);
 static ssize_t iodev_read(struct file *, char __user *, size_t s, loff_t *);
@@ -103,7 +103,7 @@ static int __init iodev_probe(struct platform_device *dev)
 
 
 
-static int __exit iodev_remove(struct platform_device *dev)
+static int __devexit iodev_remove(struct platform_device *dev)
 {
 	return misc_deregister(&miscdev);
 }
-- 
1.6.5.2
