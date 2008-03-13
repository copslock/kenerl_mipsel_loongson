Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2008 13:56:21 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:18571 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28582490AbYCMN4S (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Mar 2008 13:56:18 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2DDuIax002141
	for <linux-mips@linux-mips.org>; Thu, 13 Mar 2008 13:56:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2DDuI0S002140
	for linux-mips@linux-mips.org; Thu, 13 Mar 2008 13:56:18 GMT
Date:	Thu, 13 Mar 2008 13:56:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Alchemy power managment code.
Message-ID: <20080313135618.GA31211@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The Alchemy code in arch/mips/au1000/common/power.c is one of the last
remaining users of pm_send_all() which happens to be a nop call because
nothing registers callbacks with pm_register.  So the pm_send_all() calls
can be removed.

Which leaves pm_do_suspend with no sensible code, so it can be removed.
And ripped like this pm_do_sleep looks it it may well no longer be
functioning.

So, anybody still using that stuff, does it provide any useful
functionality?  Does the CPU frequency stuff actually work?

  Ralf

PS: You should hear the engine of my chainsaw warming up ...
