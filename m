Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jun 2009 07:52:53 +0200 (CEST)
Received: from kroah.org ([198.145.64.141]:56153 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492729AbZFPFwr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jun 2009 07:52:47 +0200
Received: from localhost (c-76-105-230-205.hsd1.or.comcast.net [76.105.230.205])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coco.kroah.org (Postfix) with ESMTPSA id 2D19148E19;
	Mon, 15 Jun 2009 22:51:43 -0700 (PDT)
From:	Greg Kroah-Hartman <gregkh@suse.de>
To:	linux-kernel@vger.kernel.org
Cc:	Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 54/64] mips: remove driver_data direct access of struct device
Date:	Mon, 15 Jun 2009 22:46:43 -0700
Message-Id: <1245131213-24168-54-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <20090616051351.GA23627@kroah.com>
References: <20090616051351.GA23627@kroah.com>
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

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
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/sni/eisa.c b/arch/mips/sni/eisa.c
index 7396cd7..6827feb 100644
--- a/arch/mips/sni/eisa.c
+++ b/arch/mips/sni/eisa.c
@@ -38,7 +38,7 @@ int __init sni_eisa_root_init(void)
 	if (!r)
 		return r;
 
-	eisa_root_dev.dev.driver_data = &eisa_bus_root;
+	dev_set_drvdata(&eisa_root_dev.dev, &eisa_bus_root);
 
 	if (eisa_root_register(&eisa_bus_root)) {
 		/* A real bridge may have been registered before
-- 
1.6.3.2
