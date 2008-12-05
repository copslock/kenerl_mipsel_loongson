Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2008 00:37:11 +0000 (GMT)
Received: from vps1.tull.net ([66.180.172.116]:44938 "HELO vps1.tull.net")
	by ftp.linux-mips.org with SMTP id S24119813AbYLEAhF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2008 00:37:05 +0000
Received: (qmail 26170 invoked by uid 1015); 5 Dec 2008 11:37:00 +1100
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Fri, 05 Dec 2008 11:37:00 +1100
Received: (qmail 31464 invoked by uid 1015); 5 Dec 2008 11:36:56 +1100
Received: from [10.0.0.1] (HELO marcab.local.tull.net) (10.0.0.1)    by tull.net (qpsmtpd/0.40) with SMTP; Fri, 05 Dec 2008 11:36:56 +1100
Received: by marcab.local.tull.net (sSMTP sendmail emulation); Fri, 05 Dec 2008 11:36:54 +1100
Date:	Fri, 05 Dec 2008 11:36:54 +1100
From:	Nick Andrew <nick@nick-andrew.net>
Subject: Fix incorrect use of loose in vpe.c
To:	Jonathan Corbet <corbet@lwn.net>,	Kevin D. Kissell <kevink@mips.com>,	Lucas Woods <woodzy@gmail.com>,	Nick Andrew <nick@nick-andrew.net>,	Ralf Baechle <ralf@linux-mips.org>,	linux-mips@linux-mips.org
Cc:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Message-Id: <S24119813AbYLEAhF/20081205003705Z+68377@ftp.linux-mips.org>
Return-Path: <nick@nick-andrew.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nick@nick-andrew.net
Precedence: bulk
X-list: linux-mips

Fix incorrect use of loose in vpe.c

From: Nick Andrew <nick@nick-andrew.net>

It should be 'lose', not 'loose'.

Signed-off-by: Nick Andrew <nick@nick-andrew.net>
---

 arch/mips/kernel/vpe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 972b2d2..a1b3da6 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -1134,7 +1134,7 @@ static int vpe_release(struct inode *inode, struct file *filp)
 
 	/* It's good to be able to run the SP and if it chokes have a look at
 	   the /dev/rt?. But if we reset the pointer to the shared struct we
-	   loose what has happened. So perhaps if garbage is sent to the vpe
+	   lose what has happened. So perhaps if garbage is sent to the vpe
 	   device, use it as a trigger for the reset. Hopefully a nice
 	   executable will be along shortly. */
 	if (ret < 0)
