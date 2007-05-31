Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2007 17:43:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:4234 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025541AbXEaQny (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 May 2007 17:43:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4VGhhZg013489
	for <linux-mips@linux-mips.org>; Thu, 31 May 2007 17:43:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4VGhgXV013488
	for linux-mips@linux-mips.org; Thu, 31 May 2007 17:43:42 +0100
Date:	Thu, 31 May 2007 17:43:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: 2.6.22 fixes and 2.6.23 patches
Message-ID: <20070531164342.GA13399@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

In the past there was a strong tendence that people were sending me patches
for 2.6.$(n + 1) only after 2.6.n was released.  That's a bit painful for
me as it leaves me only the merge window to sort out all the dependencies
and issues that may arise from those patches and oh yes, sometimes my
employer wants me something else to do in the same time.  So if you have
patches pending, send them in time.  I can always drop stuff for $(n + 1)
in the -queue tree even when we're in deep freeze.  Think of it as the
Linux/MIPS -mm tree.

Also it's high time to get all fixes for 2.6.22 upstream so if you have
something send it ASAP, if you think I may have lost it send again.

Thanks,

  Ralf
