Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2009 21:05:18 +0100 (BST)
Received: from kroah.org ([198.145.64.141]:37335 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023350AbZEDUFL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 May 2009 21:05:11 +0100
Received: from localhost (c-76-105-230-205.hsd1.or.comcast.net [76.105.230.205])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coco.kroah.org (Postfix) with ESMTPSA id 1472448FB3;
	Mon,  4 May 2009 13:05:08 -0700 (PDT)
Date:	Mon, 4 May 2009 13:01:17 -0700
From:	Greg Kroah-Hartman <gregkh@suse.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Greg KH <greg@kroah.com>
Subject: [PATCH] mips: remove driver_data direct access of struct device
Message-ID: <20090504200117.GA22829@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

From: Greg Kroah-Hartman <gregkh@suse.de>

In the near future, the driver core is going to not allow direct access
to the driver_data pointer in struct device.  Instead, the functions
dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
have been around since the beginning, so are backwards compatible with
all older kernel versions.

Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/mips/sni/eisa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/sni/eisa.c
+++ b/arch/mips/sni/eisa.c
@@ -38,7 +38,7 @@ int __init sni_eisa_root_init(void)
 	if (!r)
 		return r;
 
-	eisa_root_dev.dev.driver_data = &eisa_bus_root;
+	dev_set_drvdata(&eisa_root_dev.dev, &eisa_bus_root);
 
 	if (eisa_root_register(&eisa_bus_root)) {
 		/* A real bridge may have been registered before
