Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 21:08:23 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:29413 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20041763AbYFXUIO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 21:08:14 +0100
Received: (qmail 2871 invoked by uid 1000); 24 Jun 2008 22:08:10 +0200
Date:	Tue, 24 Jun 2008 22:08:10 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [RFC PATCH 0/7] Alchemy updates
Message-ID: <20080624200810.GA2463@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

Here's a set of patches to modernize Alchemy setup and PM code.
All are compile tested with db1000 + db1200 defconfig, and run-tested
as far as was possible on Au1200 hardware I have access to.

Comments welcome!

Thanks,
	Manuel Lauss
