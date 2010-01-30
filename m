Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 18:54:43 +0100 (CET)
Received: from sakura.staff.proxad.net ([213.228.1.107]:38429 "EHLO
        sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492511Ab0A3Ryj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 18:54:39 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id B7C1C551082; Sat, 30 Jan 2010 18:54:39 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     David Brownell <dbrownell@users.sourceforge.net>,
        linux-usb@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 0/2] USB: add support for Broadcom 63xx OHCI & EHCI.
Date:   Sat, 30 Jan 2010 18:54:29 +0100
Message-Id: <1264874071-28851-1-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.3.3
X-archive-position: 25768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19486

Hi David,

These patches add support for Broadcom 63xx integrated USB OHCI & EHCI
controller. The platform code (device registration) has been sent in a
separate patch to Ralf.

They were already posted a long time ago, and all your comments have
now been addressed.


Maxime Bizon (2):
  USB: add Broadcom 63xx integrated OHCI controller support.
  USB: add Broadcom 63xx integrated EHCI controller support.

 drivers/usb/host/ehci-bcm63xx.c |  154 ++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c     |    5 +
 drivers/usb/host/ohci-bcm63xx.c |  166 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c     |    5 +
 drivers/usb/host/ohci.h         |    2 +-
 5 files changed, 331 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/host/ehci-bcm63xx.c
 create mode 100644 drivers/usb/host/ohci-bcm63xx.c
