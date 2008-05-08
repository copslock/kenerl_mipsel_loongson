Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2008 09:00:46 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:960 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022622AbYEHIAn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 May 2008 09:00:43 +0100
Received: (qmail 24467 invoked by uid 1000); 8 May 2008 10:00:40 +0200
Date:	Thu, 8 May 2008 10:00:40 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] au1xmmc updates, #2
Message-ID: <20080508080040.GA24383@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

The following set of patches remove demoboard-specific code from the
au1xmmc.c driver and add new features.

My main motivation was to let boards implement other carddetect schemes,
since on one of my boards the driver-implemented poll timer doesn't work
for some unknown reason.  But this board does have a dedicated carddetect
IRQ and card-present/card-readonly indicators which are incompatible with
the Db1200 implementation.  I also took the opportunity to clean up the
drivers probe() and irq() handlers to make it a "proper" platform device
(patches #3 and #4).

Patch #1 is required to get the driver to build as a module.
Patch #2 is required to be able to load/unload the driver > 16 times.
Patches #5 and #6 implement new features.
Patch #7 does a little codingstyle cleanup, no functional changes.

Change since V1:
- fix a bug in patch #6: SDIO irq should be checked for independently
  from other irq events.
- more trivial cleanups

Db1200 users, please test!  I verified the poll timer works on one of
older boards, however since I don't have Db1200 and Pb1200 boards I'm
not sure whether the driver still works with both SD controllers enabled!

Thanks!
	Manuel Lauss
