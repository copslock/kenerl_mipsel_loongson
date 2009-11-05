Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 18:57:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58922 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493045AbZKERzp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Nov 2009 18:55:45 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA5Hv7Jk024949;
	Thu, 5 Nov 2009 18:57:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA5Hv7gp024948;
	Thu, 5 Nov 2009 18:57:07 +0100
Message-Id: <20091105152555.227009519@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Thu, 05 Nov 2009 16:25:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Julia Lawall <julia@diku.dk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	devel@driverdev.osuosl.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/6] Misc driver fixes for 2.6.32
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

This is a series of patches which 

  o 1/6, 2/6, 3/6: Fixes for the Octeon ethernet driver in drivers/staging.
    The Octeon is a MIPS-based SOC so with permisson from Greg I'm merging
    these via the MIPS tree.
  o 4/6: A fix to a MIPS-specific SPI driver.  Posted before, no comments
    were received.
  o 5/6: A fix to the resource allocation to the framebuffer of the MIPS-
    based SGI O2 and i686-based Visual Workstation.  Also posted before, no
    comments were received.
  o 6/6: A fix to the serial driver for the BCM63xx which is a MIPS-based
    SOC.

  Ralf
