Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2007 11:20:03 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11715 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025489AbXEaKUB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 May 2007 11:20:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4VAJmrE022195
	for <linux-mips@linux-mips.org>; Thu, 31 May 2007 11:19:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4UGV5Wo005766
	for linux-mips@linux-mips.org; Wed, 30 May 2007 17:31:05 +0100
Date:	Wed, 30 May 2007 17:31:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Git via http
Message-ID: <20070530163105.GC2226@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Some people have reported issues with cloning and pulling from
git.linux-mips.org via http.  This should be fixed now.  Let me know.
The proper fix is still to use a sane protocol like git and if
necessary fix the firewall.  Http really is just a kludge for the
poor sods that suffer from one.

  Ralf
