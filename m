Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2010 15:26:38 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:65138 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491022Ab0LVO0f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Dec 2010 15:26:35 +0100
Received: by vws5 with SMTP id 5so1965316vws.36
        for <multiple recipients>; Wed, 22 Dec 2010 06:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3qQ2BY/EB6dHKwekKjyPhCmb+j36oO3wfvRAKy/P4Cc=;
        b=pqmf6lNg6vqCCzoY7X8/Q1JZnsZYqLlxpOLmwPYyTEzuvsILXQu7C9HUPEk54kWWHU
         Gg8pDeZoKjY9wFeset82krSG5sUJah2z39XHjdjz0i1shZSrxQ2rCjwPTPJ/ZHih2/YZ
         URwi49ndl4zoYk/8V19P9oQ/f8ANRA8bHBkgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JSF1oj52VTHVk+IIA7XzkaN1uA9c2OmCpy0Gd5klHTW60FAvGo91B6sG8UW7ZvtcQT
         d4n2w9dj8wNOO92Cdju8nnOVJEcbNDKBjqPp+c275JSR6nNj4M6jbJoBnY++wjbv4y8Q
         vkR2N45esd1mC6KWl+/8yYSC9hQQ369zy9hAs=
Received: by 10.220.186.205 with SMTP id ct13mr1763769vcb.232.1293027988625;
        Wed, 22 Dec 2010 06:26:28 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id k39sm1330538vcr.2.2010.12.22.06.26.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 06:26:27 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Anatolij Gustschin <agust@denx.de>,
        Anand Gadiyar <gadiyar@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Sarah Sharp <sarah.a.sharp@linux.intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Mortier <mortier@btinternet.com>,
        Andiry Xu <andiry.xu@amd.com>
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH V2 0/2] EHCI support for on-chip PMC MSP USB controller
Date:   Wed, 22 Dec 2010 20:04:07 +0530
Message-Id: <1293028447-21703-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1292929580-5829-1-git-send-email-anoop.pa@gmail.com>
References: <1292929580-5829-1-git-send-email-anoop.pa@gmail.com>
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

Changes Since V1:
1.Updated driver code with changes from ehci-pci.c
2.Moved over current fixup to different patch.
3.Removed #ifdef and added quirk list entry for overcurrent fixup.

Anoop P A (2):
  EHCI support for on-chip PMC MSP USB controller.
  MSP onchip root hub over current quirk.

 .../mips/include/asm/pmc-sierra/msp71xx/msp_regs.h |   17 +-
 arch/mips/include/asm/pmc-sierra/msp71xx/msp_usb.h |  144 +++++
 arch/mips/pmc-sierra/Kconfig                       |    8 +
 arch/mips/pmc-sierra/msp71xx/Makefile              |    2 +-
 arch/mips/pmc-sierra/msp71xx/msp_usb.c             |  239 +++++++---
 drivers/usb/core/hub.c                             |   45 ++-
 drivers/usb/core/quirks.c                          |    3 +
 drivers/usb/host/Kconfig                           |   15 +-
 drivers/usb/host/ehci-hcd.c                        |   12 +
 drivers/usb/host/ehci-pmcmsp.c                     |  551 ++++++++++++++++++++
 include/linux/usb/quirks.h                         |    3 +
 11 files changed, 959 insertions(+), 80 deletions(-)
 create mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/msp_usb.h
 create mode 100644 drivers/usb/host/ehci-pmcmsp.c
