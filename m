Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 07:23:50 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:53253 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901171Ab2FWFXn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jun 2012 07:23:43 +0200
Received: (qmail 24569 invoked from network); 23 Jun 2012 05:23:39 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 23 Jun 2012 05:23:39 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Fri, 22 Jun 2012 22:23:38 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     <ffainelli@freebox.fr>, <mbizon@freebox.fr>,
        <jonas.gorski@gmail.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 0/7] Prerequisites for BCM63XX UDC driver
Date:   Fri, 22 Jun 2012 22:14:50 -0700
Message-Id: <0f67eabbb0d5c59add27e42a08b94944@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 33789
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
Return-Path: <linux-mips-bounce@linux-mips.org>

These patches are intended to lay the groundwork for a new USB Device
Controller (gadget UDC) driver.  arch/mips/bcm63xx updates include:

Clock enable bits
DMA descriptor updates
New register and IRQ definitions
Create platform_device and platform_data

Baseline is:

git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git #mips-for-linux-next

Note that this is not an OTG-capable controller.  Therefore, boards are
permanently wired up for either host mode or device mode.  Device vs.
host can be determined in board_bcm963xx.c based on the detected board ID.
Some boards have connectors/pads for both modes, but need to be
reworked to run in device mode; usually this involves moving 0-ohm
resistors on the D+ and D- lines.
