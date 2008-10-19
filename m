Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2008 03:07:08 +0100 (BST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:37588 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S21816155AbYJSCHD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Oct 2008 03:07:03 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 6B501112404E; Sun, 19 Oct 2008 04:07:02 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	ralf@linux-mips.org
Cc:	netdev@vger.kernel.org, afleming@freescale.com, jgarzik@pobox.com,
	linux-usb@vger.kernel.org, dbrownell@users.sourceforge.net,
	linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH/RFC v1 00/12] Support for Broadcom 63xx SOCs
Date:	Sun, 19 Oct 2008 04:07:02 +0200
Message-Id: <1224382022-24173-1-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.5.4.3
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

[first try at patch series mailing, if you're in to/cc list by mistake
please tell me]


Hello everyone,

This is a set of patches that add support for the Broadcom 63xx series
of CPUs and  (some) integrated devices. These are  popular MIPS32 SOCs
found in a lot of DSL modems.

CPUs supported are  6348 and 6358. Support is  provided for integrated
UART,  USB OHCI  and  EHCI, PCI  controller,  ethernet MAC  & PHY  and
PCMCIA/Cardbus controller.

Board support is still rough, each vendor seems to have its own way of
identifying the board  type in nvram, that's why  it will probably not
work out of  the box.  So DON'T FLASH IT BLINDLY  on your modem unless
you have a serial cable, prefer tftpboot/nfsroot for testing.

I used linux-mips git tree  master to generate theses patches, this is
probably  inappropriate considering  they  touch multiple  subsystems.
Since all patches  depends on first two of the series  I wonder how to
submit this properly for inclusion in one merge window (if that's even
do-able).

Patches are also available here in case they were too big:
http://88.191.35.171/bcm63xx/patches/linux-mips-bcm63xx/v1/


I would like to thank my company for letting me release this (hi
boss), and also Broadcom who gave its blessing.

Happy hacking !

-- 
Maxime
