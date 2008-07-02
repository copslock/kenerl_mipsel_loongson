Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 14:18:15 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:10199 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S62076964AbYGBNSH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jul 2008 14:18:07 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m62DHKom003359
	for <linux-mips@linux-mips.org>; Wed, 2 Jul 2008 15:17:46 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m62DHKvJ003352
	for linux-mips@linux-mips.org; Wed, 2 Jul 2008 14:17:20 +0100
Date:	Wed, 2 Jul 2008 14:17:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Branch out of range issues
Message-ID: <20080702131720.GC15896@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Recently a few people have reported "branch out of range" problems building
recent kernels.  One way to fix those - at the risk of causing considerable
collateral damage - is using -ffunction-sections.  I'm hessitating to make
a change like this so short before a kernel release since at this point I'm
not convinved that this is actually needed.  Anyway I'd appreciate feedback
on the problem.

Thanks,

  Ralf
