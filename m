Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 18:35:03 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7592 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038753AbWJMRfC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 18:35:02 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9DHZFZn027867
	for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 18:35:16 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9DHZFNl027866
	for linux-mips@linux-mips.org; Fri, 13 Oct 2006 18:35:15 +0100
Date:	Fri, 13 Oct 2006 18:35:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Queue tree
Message-ID: <20061013173514.GC19260@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The queue branch which I've been maintaining after the -rc1 phase
in the main Linux repository on linux-mips.org since a while has caused
some confusion among not so git-savy users.  So I've decieded to move
that branch into a separate linux-queue tree.  I'm actually maintaining
the tree with quilt and a bunch of hacked up scripts, so it's relativly
easy to add, remove, replace, split or merge patches until they finally
make it into the main tree.

The queue tree is at

  git://git.linux-mips.org/pub/scm/linux-queue.git

And of course also accessible via http, rsync and in gitweb.

  Ralf
