Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2011 16:21:56 +0200 (CEST)
Received: from mail1.pearl-online.net ([62.159.194.147]:51586 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491191Ab1IOOVt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Sep 2011 16:21:49 +0200
Received: from Mobile0.Peter (109.125.101.165.dynamic.cablesurf.de [109.125.101.165])
        by mail1.pearl-online.net (Postfix) with ESMTPA id 18E9F202CE;
        Thu, 15 Sep 2011 16:21:44 +0200 (CEST)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id p8FFTBd7001279;
        Thu, 15 Sep 2011 15:29:11 GMT
Received: from Indigo2.Peter (localhost [127.0.0.1])
        by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id p8FDn3BQ014996;
        Thu, 15 Sep 2011 15:49:03 +0200
Received: from localhost (pf@localhost)
        by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id p8FDn3Z5014993;
        Thu, 15 Sep 2011 15:49:03 +0200
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:   Thu, 15 Sep 2011 15:49:03 +0200 (CEST)
From:   peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     Joshua Kinard <kumba@gentoo.org>, attilio.fiandrotti@gmail.com
Subject: [PATCH 0/4] Impact video driver for SGI Indigo2
In-Reply-To: <Pine.LNX.4.64.1109111200400.4146@Indigo2.Peter>
Message-ID: <Pine.LNX.4.64.1109151436580.14966@Indigo2.Peter>
References: <Pine.LNX.4.64.1109111200400.4146@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7819



With this and the following messages the patch for the Impact video
driver will be resubmitted.

- Now - most important - the MUA sends text out unaltered.

- The diff-text is split into several patches, roughly according to
  destinations, although these patches are not all independent. ('hope
  this helps to handle it better :)

- The early-console stuff, probably helpfull only to kernel-debuggers,
  is extracted to an additional patch, waiting backstage for delivery
  on demand (only). (This console in principle is usable from kernel-
  entry on)


================================================================

This patch brings, yet missing, parts that make a Linux-driven Indigo2
Impact (IP28 and most probably IP22-Impact) an usable desktop-machine
"out of the box".
The driver provides the framebuffer console and an interface for the
Xserver (mmap'ing a DMA-pool to the shadow framebuffer and doing the
necessary cacheflush).
Meanwhile only a few files are affected and obviously no side-effects
to other parts of the kernel are to be expected.

BTW: it would be appreciated, if someone could verify, that this driver
also works for IP22 Impact.


 include/video/impact.h           |  205 ++++++++
 drivers/video/impact.c           | 1020 ++++++++++++++++++++++++++++++++++++++
 drivers/video/Kconfig            |    6 +
 drivers/video/Makefile           |    1 +
 drivers/video/logo/Kconfig       |    2 +-
 arch/mips/configs/ip28_defconfig |    1 +
 arch/mips/sgi-ip22/ip22-setup.c  |   26 +
 7 files changed, 1260 insertions(+), 1 deletions(-)
