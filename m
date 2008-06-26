Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2008 20:36:50 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:56037 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28576619AbYFZTgp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jun 2008 20:36:45 +0100
Received: (qmail 21743 invoked by uid 1000); 26 Jun 2008 21:36:43 +0200
Date:	Thu, 26 Jun 2008 21:36:43 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH v2 0/8] Alchemy updates
Message-ID: <20080626193643.GA21604@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

Here's a new set of patches to modernize Alchemy setup and PM code.
All are compile tested with db1000 + db1200 defconfig, and run-tested
as far as was possible on Au1200 hardware I have access to (the core
PM code works very well).

Changes since first submission:
- address Sergei's comments,
- change TOY clocksource to RTC clocksource
- add another patch (#5)


Comments welcome!

Thanks,
	Manuel Lauss
