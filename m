Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 07:35:25 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:11393 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20029913AbYFIGfX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 07:35:23 +0100
Received: (qmail 8802 invoked by uid 1000); 9 Jun 2008 08:35:21 +0200
Date:	Mon, 9 Jun 2008 08:35:21 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	drzeus@drzeus.cx, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] au1xmmc updates #4
Message-ID: <20080609063521.GA8724@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

The following set of patches updates the au1xmmc driver with new features
and moves code not belonging to the driver source to MIPS/Alchemy board
files.

I also took the opportunity to clean up the drivers probe() and irq()
handlers to make it a "proper" platform device (patches #1 and #2).

Patches #3, #4 and #6 implement new features, #5 and #7 are cleanups.

The patches are intended to be applied on top of each other, against
current mainline git (2.6.23-rc5+).

Changes since V3:
- previous patches #1 and #2 are dropped since they are already upstream.
  ("Alchemy: export get_au1x00_speed for modules" and
   "Alchemy: dbdma: add API to delete custom DDMA device")

- few additional minor fixes and patches folded into others.

- I'm taking over maintainership of the driver for as long as I have
  hardware to test it on.

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
