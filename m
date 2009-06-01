Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 18:23:53 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:35386 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025666AbZFARWD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 18:22:03 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 61094112408A; Mon,  1 Jun 2009 19:21:58 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>
Subject: More updates to bcm63xx support (resend)
Date:	Mon,  1 Jun 2009 19:21:48 +0200
Message-Id: <1243876918-9905-1-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


[Resend, I forgot to generate an actual patch series and missed one
patch doing so, sorry for the noise]

Hi Ralf,

The following patch series (on top of Florian's latest post) are
mostly trivial fixes & cleanup requested by subsystem maintainers.

Patch 2 and 4 are actual bugfixes.

Florian has some more patches to send to you, I will wait for them to
be folded in the bcm63xx tree and then repost the whole serie.

I only got feedback from USB maintainer, and addressed most of them.
Davem has accidentally dropped the patch from its patchwork, so I
think just resubmitting will do. Nothing from serial & pcmcia.

The ethernet PHY support patch should be dropped, the only feature we
get is IRQ support which after field testing seems to be buggy. Maybe
later.

Is it ok for you if I ask for the patches to go through your tree once
they get acked ?

Thanks !
