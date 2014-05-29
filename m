Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 12:10:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18914 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816676AbaE2KKTgvVw0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 12:10:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A968DED36DF84;
        Thu, 29 May 2014 11:10:10 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 29 May
 2014 11:10:12 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 11:10:12 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.62) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 11:10:11 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH 0/3] Ubiquiti EdgeRouter/EdgeRouter Pro support
Date:   Thu, 29 May 2014 11:10:00 +0100
Message-ID: <1401358203-60225-1-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.62]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

This patch series adds support for the Ubiquiti EdgeRouter and
EdgeRouter Pro (ER-8 and ERPro-8).

The first 2 patches enable the Ethernet interfaces on the boards to be
detected correctly. The 3rd patch enables the {E,O}HCI controllers by
probing them via DT rather than registering them in platform code,
which was only done for CN63XX and therefore would not be done on the
EdgeRouters (CN61XX).

Alex Smith (1):
  MIPS: octeon: Add interface mode detection for Octeon II

David Daney (2):
  staging: octeon-ethernet: Move PHY activation to .ndo_open().
  usb host/MIPS: Remove hard-coded OCTEON platform information.

 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |  12 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    | 166 +++++++++++++++++++++
 arch/mips/cavium-octeon/octeon-platform.c          | 102 -------------
 drivers/staging/octeon/ethernet-mdio.c             |  79 +++++++---
 drivers/staging/octeon/ethernet-rgmii.c            |  23 ++-
 drivers/staging/octeon/ethernet-sgmii.c            |  87 ++++++-----
 drivers/staging/octeon/ethernet-xaui.c             |  83 +++++++----
 drivers/staging/octeon/ethernet.c                  |   2 +-
 drivers/staging/octeon/octeon-ethernet.h           |   4 +
 drivers/usb/host/ehci-octeon.c                     |  17 ++-
 drivers/usb/host/octeon2-common.c                  |  47 +++++-
 drivers/usb/host/ohci-octeon.c                     |  17 ++-
 12 files changed, 424 insertions(+), 215 deletions(-)

-- 
1.9.3
