Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 21:52:00 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52624 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817387Ab2LZUv730ksE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 21:51:59 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id C7F1C8E1C;
        Wed, 26 Dec 2012 21:51:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 21xDEwIG3wAE; Wed, 26 Dec 2012 21:51:44 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 9695E8F60;
        Wed, 26 Dec 2012 21:51:36 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: =?UTF-8?q?=5BPATCH=200/6=5D=20MIPS=3A=20BCM47XX=3A=20nvram=20read=20enhancements?=
Date:   Wed, 26 Dec 2012 21:51:08 +0100
Message-Id: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Clean up the nvram reading code and add support for different nvram 
sizes.

This depends on patch "MIPS: bcm47xx: separate functions finding flash 
window addr" by Rafał Miłeck, Patchwork:  https://patchwork.linux-mips.org/patch/4738/

Hauke Mehrtens (6):
  MIPS: BCM47XX: use common error codes in nvram reads
  MIPS: BCM47XX: return error when init of nvram failed
  MIPS: BCM47XX: nvram add nand flash support
  MIPS: BCM47XX: rename early_nvram_init to nvram_init
  MIPS: BCM47XX: handle different nvram sizes
  MIPS: BCM47XX: add bcm47xx prefix in front of nvram function names

 arch/mips/bcm47xx/nvram.c                          |   98 ++++++++++++++------
 arch/mips/bcm47xx/setup.c                          |    6 +-
 arch/mips/bcm47xx/sprom.c                          |   10 +-
 .../asm/mach-bcm47xx/{nvram.h => bcm47xx_nvram.h}  |   13 +--
 drivers/mtd/bcm47xxpart.c                          |    2 +-
 drivers/net/ethernet/broadcom/b44.c                |    4 +-
 drivers/ssb/driver_chipcommon_pmu.c                |    4 +-
 include/linux/ssb/ssb_driver_gige.h                |    6 +-
 8 files changed, 92 insertions(+), 51 deletions(-)
 rename arch/mips/include/asm/mach-bcm47xx/{nvram.h => bcm47xx_nvram.h} (84%)

-- 
1.7.10.4
