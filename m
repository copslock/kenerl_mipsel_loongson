Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2012 20:13:29 +0200 (CEST)
Received: from mail209.messagelabs.com ([216.82.255.3]:16746 "EHLO
        mail209.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903589Ab2C1SNZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2012 20:13:25 +0200
X-Env-Sender: hartleys@visionengravers.com
X-Msg-Ref: server-12.tower-209.messagelabs.com!1332958350!1834142!52
X-Originating-IP: [216.166.12.178]
X-StarScan-Version: 6.5.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17561 invoked from network); 28 Mar 2012 18:13:21 -0000
Received: from out001.collaborationhost.net (HELO out001.collaborationhost.net) (216.166.12.178)
  by server-12.tower-209.messagelabs.com with RC4-SHA encrypted SMTP; 28 Mar 2012 18:13:21 -0000
Received: from etch.local (10.2.3.210) by smtp.collaborationhost.net
 (10.2.0.191) with Microsoft SMTP Server (TLS) id 8.3.213.0; Wed, 28 Mar 2012
 13:12:59 -0500
From:   H Hartley Sweeten <hartleys@visionengravers.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] mtd: plat_nand: Add default partition parser and use it
Date:   Wed, 28 Mar 2012 11:12:48 -0700
User-Agent: KMail/1.9.9
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>,
        <uclinux-dist-devel@blackfin.uclinux.org>,
        <linux-sh@vger.kernel.org>, <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <201203281112.48788.hartleys@visionengravers.com>
X-archive-position: 32806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartleys@visionengravers.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch series adds cmdlinepart as the default partition parser for the
plat_nand driver and updates all the arch setup code to use it.

Arch setup code that requires other partition parsers can still pass that
information as chip.part_probe_types.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
  mtd: plat_nand: Add default partition parser to driver
  arm: Use the plat_nand default partition parser
  blackfin: Use the plat_nand default partition parser
  mips: Use the plat_nand default partition parser
  sh: Use the plat_nand default partition parser

 arch/arm/mach-ep93xx/snappercl15.c        |    3 ---
 arch/arm/mach-ep93xx/ts72xx.c             |    3 ---
 arch/arm/mach-ixp4xx/ixdp425-setup.c      |    3 ---
 arch/arm/mach-omap1/board-fsample.c       |    3 ---
 arch/arm/mach-omap1/board-h2.c            |    3 ---
 arch/arm/mach-omap1/board-h3.c            |    3 ---
 arch/arm/mach-omap1/board-perseus2.c      |    3 ---
 arch/arm/mach-orion5x/ts78xx-setup.c      |    3 ---
 arch/arm/mach-pxa/balloon3.c              |    3 ---
 arch/arm/mach-pxa/em-x270.c               |    3 ---
 arch/arm/mach-pxa/palmtx.c                |    3 ---
 arch/blackfin/mach-bf561/boards/acvilon.c |    3 ---
 arch/mips/alchemy/devboards/db1200.c      |    3 ---
 arch/mips/alchemy/devboards/db1300.c      |    3 ---
 arch/mips/alchemy/devboards/db1550.c      |    3 ---
 arch/mips/pnx833x/common/platform.c       |    6 ------
 arch/sh/boards/mach-migor/setup.c         |    1 -
 drivers/mtd/nand/plat_nand.c              |    8 ++++++--
 18 files changed, 6 insertions(+), 54 deletions(-)
