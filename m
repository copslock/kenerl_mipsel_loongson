Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 15:48:15 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49802 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021598AbXGFOsN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jul 2007 15:48:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l66EehUW023606
	for <linux-mips@linux-mips.org>; Fri, 6 Jul 2007 15:40:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l66EehTD023605
	for linux-mips@linux-mips.org; Fri, 6 Jul 2007 15:40:43 +0100
Date:	Fri, 6 Jul 2007 15:40:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Au1550 OSS sound driver
Message-ID: <20070706144043.GA23569@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Does anybody have convincing arguments why I should *NOT* delete this
driver?  It's sitting since ages in the lmo repositories, as an OSS
driver isn't in the shape to be merged upstream, so doesn't receive
testing by the autobuilders, I don't think I've seen any testers.

Volunters to rewrite this for ALSA?

(Show me the patches, not promises! :-)

  Ralf
