Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 18:59:17 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
	(ralf@eddie.linux-mips.org)) by ftp.linux-mips.org id S1491794AbZGAQ7O
	for <"|/home/ecartis/ecartis -s linux-mips">;
	Wed, 1 Jul 2009 18:59:14 +0200
Message-Id: <20090701112926.825088732@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Wed, 01 Jul 2009 12:29:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org, trivial@kernel.org,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, Maxime Bizon <mbizon@freebox.fr>,
	Florian Fainelli <florian@openwrt.org>
Subject: [patch 00/12] Add support for Broadcom BCM63xx SoCs
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-archive-position: 23566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

This is a patch series which has been sitting in the linux-bcm63xx git
repository for quite a while.  I'm posting this series for it to receive
the necessary review - in particular the drivers have so far been
ignored virtually entirely.

  Ralf
