Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2007 13:50:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:35733 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022307AbXEOMuA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 May 2007 13:50:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4FCnpvb022475
	for <linux-mips@linux-mips.org>; Tue, 15 May 2007 13:49:52 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4FCnpqL022474
	for linux-mips@linux-mips.org; Tue, 15 May 2007 14:49:51 +0200
Date:	Tue, 15 May 2007 14:49:51 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Alchemy MMC driver maintenance.
Message-ID: <20070515124951.GB22404@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Any takers?

----- Forwarded message from Pierre Ossman <drzeus-mmc@drzeus.cx> -----

From:	Pierre Ossman <drzeus-mmc@drzeus.cx>
Date:	Mon, 14 May 2007 21:38:49 +0200
To:	LKML <linux-kernel@vger.kernel.org>
CC:	Nicolas FERRE <nicolas.ferre@rfo.atmel.com>,
	Andrew Victor <andrew@sanpeople.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	David Brownell <david-b@pacbell.net>,
	"Juha Yrjölä" <juha.yrjola@solidboot.com>,
	Carlos Aguiar <carlos.aguiar@indt.org.br>,
	"Briglia >> \"Anderson F. Briglia\"" <anderson.briglia@indt.org.br>,
	Kyungmin Park <kmpark@infradead.org>,
	"Khasim, Syed" <x0khasim@ti.com>
Subject: [RFC] Orphaning MMC host drivers
Content-Type: multipart/mixed; boundary="=_hera.drzeus.cx-25460-1179171560-0001-2"

I've reached the point where I've grown tired of trying to figure out who has
hardware for what. I intend to commit the following in a few days so if you care
about the quality of the drivers it's time to step up to the plate.

There's a rather long list of cc here, but I've included everyone that has been
involved in the drivers in one way or another in case one or two maintainers can
actually be found.

Even if you don't feel like maintaining this, feel free to suggest mailing lists
that should be added to the entries.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org


commit 11c3d5e4b871fc69d72f67811d4eb6bfd7084c43
Author: Pierre Ossman <drzeus@drzeus.cx>
Date:   Mon May 14 21:25:26 2007 +0200

    mmc: mark unmaintained drivers
    
    Most of the host controller drivers in the MMC layer lacks an
    official maintainer. Make sure this is mentioned in MAINTAINERS
    in case someone wants to pick up the ball.
    
    Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

diff --git a/MAINTAINERS b/MAINTAINERS
index 68a56ad..8f1b60c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -346,6 +346,9 @@ P:	Ivan Kokshaysky
 M:	ink@jurassic.park.msu.ru
 S:	Maintained for 2.4; PCI support for 2.6.
 
+AMD AU1XX0 MMC DRIVER
+S:	Orphan
+
 AMD GEODE PROCESSOR/CHIPSET SUPPORT
 P:	Jordan Crouse
 M:	info-linux@geode.amd.com
@@ -418,6 +421,9 @@ P:	Ian Molton
 M:	spyro@f2s.com
 S:	Maintained
 
+ARM PRIMECELL MMCI PL180/1 DRIVER
+S:	Orphan
+
 ARM/ADI ROADRUNNER MACHINE SUPPORT
 P:	Lennert Buytenhek
 M:	kernel@wantstofly.org
@@ -649,6 +655,9 @@ L:	linux-atm-general@lists.sourceforge.net (subscribers-only)
 W:	http://linux-atm.sourceforge.net
 S:	Maintained
 
+ATMEL AT91 MCI DRIVER
+S:	Orphan
+
 ATMEL MACB ETHERNET DRIVER
 P:	Haavard Skinnemoen
 M:	hskinnemoen@atmel.com
@@ -2382,6 +2391,9 @@ M:	stelian@popies.net
 W:	http://popies.net/meye/
 S:	Maintained
 
+MOTOROLA I.MX MMCI DRIVER
+S:	Orphan
+
 MOUSE AND MISC DEVICES [GENERAL]
 P:	Alessandro Rubini
 M:	rubini@ipvvis.unipv.it
@@ -2902,6 +2914,9 @@ M:	nico@cam.org
 L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
 S:	Maintained
 
+PXA MMCI DRIVER
+S:	Orphan
+
 QLOGIC QLA2XXX FC-SCSI DRIVER
 P:	Andrew Vasquez
 M:	linux-driver@qlogic.com
@@ -3417,6 +3432,9 @@ P:      Alex Dubov
 M:      oakad@yahoo.com
 S:      Maintained
 
+TI OMAP MMC INTERFACE DRIVER
+S:	Orphan
+
 TI OMAP RANDOM NUMBER GENERATOR SUPPORT
 P:	Deepak Saxena
 M:	dsaxena@plexity.net

----- End forwarded message -----

  Ralf
