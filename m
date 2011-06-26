Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 17:45:48 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47106 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491926Ab1F0Ppe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jun 2011 17:45:34 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5RFbwfj019364;
        Mon, 27 Jun 2011 16:37:58 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5RFbrZa019347;
        Mon, 27 Jun 2011 16:37:53 +0100
Message-Id: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Cox <alan@linux.intel.com>,
        Brent Casavant <bcasavan@sgi.com>,
        David Airlie <airlied@linux.ie>,
        "David S. Miller" <davem@davemloft.net>,
        Grant Grundler <grundler@parisc-linux.org>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Richard Purdie <rpurdie@rpsys.net>,
        Steffen Klassert <klassert@mathematik.tu-chemnitz.de>,
        Tejun Heo <tj@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-scsi@vger.kernel.org,
        linux-serial@vger.kernel.org, netdev@vger.kernel.org
Date:   Sun, 26 Jun 2011 12:19:54 +0100
Subject: [PATCH 00/12] Fix various section mismatches and build errors.
X-archive-position: 30532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21992

I'm getting screen and screens full of section mismatches from my test
builds of the current kernel to the point where it's sometimes more
meaningful messages get hidden by the bulk of mismatches.  This is the
first round of fixes with more to come.

  Ralf

 drivers/gpu/drm/radeon/radeon_clocks.c |    4 ++--
 drivers/leds/leds-lp5521.c             |    4 ++--
 drivers/leds/leds-lp5523.c             |    4 ++--
 drivers/misc/ioc4.c                    |    2 +-
 drivers/net/3c509.c                    |    2 +-
 drivers/net/3c59x.c                    |    2 +-
 drivers/net/depca.c                    |   25 +++++++++++++------------
 drivers/net/hp100.c                    |    2 +-
 drivers/net/ne3210.c                   |   12 +++++++-----
 drivers/net/tulip/de4x5.c              |    2 +-
 drivers/scsi/sim710.c                  |    2 +-
 drivers/tty/serial/Kconfig             |    2 +-
 12 files changed, 33 insertions(+), 30 deletions(-)
