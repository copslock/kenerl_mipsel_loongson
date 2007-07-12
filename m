Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 19:19:53 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:13970 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022648AbXGLSTv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 19:19:51 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6CI4kaq023778
	for <linux-mips@linux-mips.org>; Thu, 12 Jul 2007 19:04:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6CI4kUd023777
	for linux-mips@linux-mips.org; Thu, 12 Jul 2007 19:04:46 +0100
Date:	Thu, 12 Jul 2007 19:04:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Alchemy driver sediments to be deleted?
Message-ID: <20070712180445.GA22748@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

So there are these two drivers

 b/drivers/char/au1000_gpio.c                                 |  262 +
 b/drivers/char/au1000_ts.c                                   |  677 +++

sitting in the lmo kernel tree since ages.  au1000_ts isn't even
wired up in the Makefile since years, so unless somebody yells "stop",
I'm going to kill it.

Also, is there anybody still interested in the au1000_gpio driver?

  Ralf
