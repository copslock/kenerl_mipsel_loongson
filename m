Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2006 15:53:52 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2178 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039438AbWLKPxv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Dec 2006 15:53:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kBBFrgch003729
	for <linux-mips@linux-mips.org>; Mon, 11 Dec 2006 15:53:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kBBFrfGL003728
	for linux-mips@linux-mips.org; Mon, 11 Dec 2006 15:53:41 GMT
Date:	Mon, 11 Dec 2006 15:53:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Git stuff
Message-ID: <20061211155341.GA3542@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I've been asked what that strange commit

commit e81fbbbb9a0d8072460c223e935fb1aca4231dc0
Merge: 6f0b1e5... 9202f32...
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Mon Dec 11 12:25:29 2006 +0000

    Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torva
    
    nothing to commit

from around noon today means - it's a merge commit where after resolution
of the merge conflict there was nothing left to commit.  Nothing to worry :)

Also sorry for the flood of commit messages.  I cherry pick any commit
that is a fix to the -stable branches which ends multiplying the number
of commits.  If you only care about certain branches you can use i.e.
procmail to filter away the uninterestin messages.  The format of the
mail messages was choosen to make that easy.

  Ralf
