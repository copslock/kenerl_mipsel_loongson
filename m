Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 01:51:31 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35801 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007077AbaKZAv3jKZq4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 01:51:29 +0100
Received: by mail-pa0-f45.google.com with SMTP id lj1so1676722pab.18
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rFjqLpko14K0SO/bdnij6ljpqbZDJyOyb/1RkkzzUYY=;
        b=AJZrTi8PiQJb7GnzQcifArXC4uQOd+l0TV/VXgWwdL3dSS8RivCfi7gbDQF/vPOC2U
         8qXIzRvnxtrW1TxV+R/xRQLMYNJ7xScixj7w5Y9pQ3rv7+i7im2FlryCmT8mc9N/yaDd
         QS6qszQexzcpxQYTJtfl+vXAFPTXqdgcjvh7H3jnN/kIx0PISRcme10+cRSYPh8tlUp3
         Lgs9N2yx0WY9dPFss/M1FOZP400H+c73vqgUTaRn5SyvfX3JZjrilburytHlx7nQyJz+
         RkS2++n6YWyDk7Z0OAeHFTLuzLPuydu6ZEYXXjEDk5tzqjEH0LZxU3zK/17Pg2XQMVWt
         cIug==
X-Received: by 10.68.217.231 with SMTP id pb7mr48463184pbc.124.1416963083565;
        Tue, 25 Nov 2014 16:51:23 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id bj11sm2614439pdb.1.2014.11.25.16.51.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:51:23 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org,
        arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 0/9] Extend various drivers to run on bi-endian BMIPS hosts
Date:   Tue, 25 Nov 2014 16:49:45 -0800
Message-Id: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This patch series incorporates the following changes:

 - Extend brcmstb reset driver to work on MIPS (currently ARM-only).

 - Extend brcmstb GISB bus driver to work on MIPS (currently ARM-only).

 - Extend brcmstb GISB bus driver to work on BE systems (currently LE-only).

 - Extend both drivers to support the older register layouts used on many
   of the BMIPS platforms.

 - Extend {ohci,ehci}-platform drivers to accept the new "native-endian"
   DT property, to accommodate BCM7xxx platforms that can be switched
   between LE/BE with a board jumper.


Dependencies:

power/reset: brcmstb: Register with kernel restart handler (Guenter Roeck)
of: Add helper function to check MMIO register endianness (Kevin Cernekee)

These are both tentatively accepted, but might not be present in the same
tree yet.  As such, we might want to "review now, merge later."


Kevin Cernekee (9):
  power/reset: brcmstb: Make the driver buildable on MIPS
  power/reset: brcmstb: Use the DT "compatible" string to indicate bit
    positions
  power/reset: brcmstb: Add support for old 65nm chips
  bus: brcmstb_gisb: Make the driver buildable on MIPS
  bus: brcmstb_gisb: Introduce wrapper functions for MMIO accesses
  bus: brcmstb_gisb: Look up register offsets in a table
  bus: brcmstb_gisb: Add register offset tables for older chips
  bus: brcmstb_gisb: Honor the "big-endian" and "native-endian" DT
    properties
  usb: {ohci,ehci}-platform: Use new OF big-endian helper function

 .../devicetree/bindings/arm/brcm-brcmstb.txt       |   4 +-
 .../devicetree/bindings/bus/brcm,gisb-arb.txt      |   6 +-
 Documentation/devicetree/bindings/usb/usb-ehci.txt |   2 +
 Documentation/devicetree/bindings/usb/usb-ohci.txt |   2 +
 drivers/bus/Kconfig                                |   2 +-
 drivers/bus/brcmstb_gisb.c                         | 127 ++++++++++++++++++---
 drivers/power/reset/Kconfig                        |   9 +-
 drivers/power/reset/brcmstb-reboot.c               |  41 +++++--
 drivers/usb/host/ehci-platform.c                   |   2 +-
 drivers/usb/host/ohci-platform.c                   |   2 +-
 10 files changed, 161 insertions(+), 36 deletions(-)

-- 
2.1.0
