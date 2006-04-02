Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2006 20:37:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:35296 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133594AbWDBThf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2006 20:37:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k32JmOKX029475
	for <linux-mips@linux-mips.org>; Sun, 2 Apr 2006 20:48:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k32JmMIP029474
	for linux-mips@linux-mips.org; Sun, 2 Apr 2006 20:48:22 +0100
Date:	Sun, 2 Apr 2006 20:48:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Removing support for old boards
Message-ID: <20060402194822.GA26358@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

 o DDB5074 and DDB5476 eval boards don't compile anymore since around
   2.6.0, I've mentioned that before, and two people mentioned their
   interest in continued support for the board but no pathches yet.
 o EV96100 doesn't build anymore since at least November 15, 2003.  No
   bug reports.
 o Jaguar ATX didn't build.  High on my lists of things to be removed
   because of it's awkard architecture that requires old features in the
   generic memory managment code to be left around.
 o None of the other MV-64340 based boards, that is Ocelot C and Ocelot 3
   does build since over a year yet again indicating there is nobody
   left that has any interest in these boards.
 o Altas and SEAD don't build and nobody has complained; MIPS Technologies
   does no longer sell these boards since years.
 o The serial driver for the two IT8172-based boards does not build for
   quite some time yet again (at least since 2.6.0, that's over two year)
   indicating nobody has enough interest to fix the thing.  Same applies
   for the Globespan IVR (CONFIG_MIPS_IVR) board.  A while ago I already
   mentioned the IT8172 board as a candidate for removal; somebody
   (Fuxin?) objected but no fixes ...

So that's my current list of candidates for removal and there are probably
a few more good candidates.  Objections?  Or even better *PATCHES* [1] to
fix things?

  Ralf

[1] Sorry for mentioning the p-word ;-)
