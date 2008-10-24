Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 23:47:12 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:31915 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S22319683AbYJXWrE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 23:47:04 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id AF14AC8101;
	Sat, 25 Oct 2008 01:46:57 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id GzyD6OceJQcK; Sat, 25 Oct 2008 01:46:57 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 8A155C80FD;
	Sat, 25 Oct 2008 01:46:57 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 4A54D108028; Sat, 25 Oct 2008 01:46:56 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [MIPS] sgi_btns: add license specification
Date:	Sat, 25 Oct 2008 01:46:57 +0300
Message-Id: <1224888417-26494-2-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224888417-26494-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1224888417-26494-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The SGI Volume Button interface driver uses GPL-only symbols
platform_driver_unregister and platform_driver_register, but
lacks license specification. Thus, when compiled as a module,
this driver cannot be installed. This patch fixes this by
adding the MODULE_LICENSE() specification.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 drivers/input/misc/sgi_btns.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/sgi_btns.c b/drivers/input/misc/sgi_btns.c
index ce238f5..be3a15f 100644
--- a/drivers/input/misc/sgi_btns.c
+++ b/drivers/input/misc/sgi_btns.c
@@ -174,5 +174,6 @@ static void __exit sgi_buttons_exit(void)
 	platform_driver_unregister(&sgi_buttons_driver);
 }
 
+MODULE_LICENSE("GPL");
 module_init(sgi_buttons_init);
 module_exit(sgi_buttons_exit);
-- 
1.5.4.3
