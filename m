Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2016 19:56:16 +0100 (CET)
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33999 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010066AbcAFS4OyrZcQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jan 2016 19:56:14 +0100
Received: by mail-pf0-f170.google.com with SMTP id e65so190260907pfe.1
        for <linux-mips@linux-mips.org>; Wed, 06 Jan 2016 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tRstWZjws3H1bXEPlV8dXzmMgEj151jgLx2c2nafW44=;
        b=mUu0mEEIk4oLsU6y1nUI6HlnKcZHRUYTnpIulYEbghV+WgHNJkI5gPgayGaEODFqGi
         QAccjGoiT7QrJA3Gte7jLrmKgnah6IBh8viWWFZRhF+zQ0OViLrI5R0wiECGjURl6rU2
         Hm1VS4WmIAkfbOYCYvceYe5eWSsQV5EeLxBHqgPa+1CrDCgc8be2KrT5fNF18xC9sVyn
         h6zY776iA+9OwxQd02GtGJXRb5VTD/AgpnhGc4LlWhxC79p1HSw5Ya6RkIiw3rTmoepw
         NLJS50iyvoz5w3PCu3QPrFgFhjYzhzjwZx6DW7S35um8hOJp2WBwbXHK5S/PRZgiLrY3
         8AwQ==
X-Received: by 10.98.70.2 with SMTP id t2mr142115580pfa.119.1452106568857;
        Wed, 06 Jan 2016 10:56:08 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id u67sm137196864pfa.84.2016.01.06.10.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jan 2016 10:56:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     linux-mips@linux-mips.org, gregory.0xf0@gmail.com,
        jaedon.shin@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/3] gpio: brcmstb: Misc changes
Date:   Wed,  6 Jan 2016 10:55:20 -0800
Message-Id: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Linus, Alexandre,

This patch series updates the brcmstb GPIO driver to support the following:

- move the initialization to subsys_initcall to allow using this driver with
  GPIO-driven regulators
- properly configure the driver for big-endian MIPS operation
- enable the driver for MIPS-based brcmstb chips

Thank you!

Florian Fainelli (2):
  gpio: brcmstb: Set endian flags for big-endian MIPS
  gpio: brcmstb: Allow building driver for BMIPS_GENERIC

Jim Quinlan (1):
  gpio: brcmstb: have driver register during subsys_initcall()

 drivers/gpio/Kconfig        |  4 ++--
 drivers/gpio/gpio-brcmstb.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.1.0
