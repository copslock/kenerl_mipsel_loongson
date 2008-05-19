Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2008 09:03:48 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:15788 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022091AbYESIDp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 May 2008 09:03:45 +0100
Received: (qmail 22027 invoked by uid 1000); 19 May 2008 10:03:39 +0200
Date:	Mon, 19 May 2008 10:03:39 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	drzeus@drzeus.cx, sshtylyov@ru.mvista.com
Subject: [PATCH 0/9] au1xmmc updates #3
Message-ID: <20080519080339.GA21985@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

The following set of patches remove demoboard-specific code from the
au1xmmc.c driver and adds new features.

My main motivation was to let boards implement other carddetect schemes,
since on one of my boards the driver-implemented poll timer doesn't work
for some unknown reason.  But this board does have a dedicated carddetect
IRQ and card-present/card-readonly indicators which are incompatible with
the Db1200 implementation.

I also took the opportunity to clean up the drivers probe() and irq()
handlers to make it a "proper" platform device (patches #3 and #4)
and add a few other features.

Patch #1 is required to get the driver to build as a module.
Patch #2 is required to be able to load/unload the driver > 16 times.
Patches #5 and #6 implement new features.
Patch #7 does a little codingstyle cleanup, no functional changes.
Patch #8 adds an optimization to the request callback.
Patch #9 adds back pb1200 MMC activity LED support (patch #3 removes it).

patches #3-#9 are intended to be applied on top of each other, against
current mainline git (2.6.23-rc3).

Changes since V2:
- address almost all Sergei Shtylyov's comments:
  pb1200/db1200 mmc device registration moved back to original location,
  remove the au1xmmc.h header as part of codingstyle cleanup
  other nits.

- 2 more patches (#8, #9)

Changes since V1:
- fix a bug in patch #6: SDIO irq should be checked for independently
  from other irq events.
- more trivial cleanups

Db1200 users, please test!  I verified the poll timer works on one of
older boards, however since I don't have Db1200 and Pb1200 boards I'm
not sure whether the driver still works with both SD controllers enabled!

Thanks!
	Manuel Lauss
