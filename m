Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 15:25:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36258 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029325AbXI0OZn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Sep 2007 15:25:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8REPgQR021753
	for <linux-mips@linux-mips.org>; Thu, 27 Sep 2007 15:25:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8REPg2P021752
	for linux-mips@linux-mips.org; Thu, 27 Sep 2007 15:25:42 +0100
Date:	Thu, 27 Sep 2007 15:25:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: dyntick / high resolution timers
Message-ID: <20070927142542.GA21650@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Since several month already this patchset is sitting in a separate tree
and I feel if I don't push it out to a wider audience now, its rough
edges will never get cleaned up, so I pushed what I have into the
2.6.24 patch queue branch and to akpm for -mm.

While it works fine for the configurations I've tested (that's mostly
Malta in all variants these days) I have for testing on my desk I'm far
from were I'm confident it'll be fine for all platforms, so testing
appreciated and also really needed.

  Ralf
