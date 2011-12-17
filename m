Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 13:59:00 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:64039 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903684Ab1LQM64 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 13:58:56 +0100
Received: by eaak12 with SMTP id k12so3598636eaa.36
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 04:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gpcngWWP+pKnkVhEAWFpHRnlll7wcF2bdC8TYw8NK60=;
        b=UDk6filMV6a3fBOZks7znY6aev4+ikfYJKiEfHUQpfwPt2tuhbimZ+YQSXmOa94ws7
         d2awobVVnNcWjEd5Ybfmsr1Z0ZUSw0e5FYZyEPv8SSCjmh2640BZA2xF2lvrrkTYlkAF
         AU2fL0d2tSmA/a5TNq4XfsDI0FXDo4NMi9Z7M=
Received: by 10.213.7.145 with SMTP id d17mr1193463ebd.65.1324126730635;
        Sat, 17 Dec 2011 04:58:50 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id s16sm14739907eef.2.2011.12.17.04.58.49
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 04:58:49 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 0/5] MTD: bcm63xxpart: improve robustness
Date:   Sat, 17 Dec 2011 13:58:13 +0100
Message-Id: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 32114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14074

This patchset aims at improving the robustness of the CFE detection and
image tag validation and parsing.

The image tag parsing improvement is especially useful when booting a
ramdisk image through tftp, since there is no guarantee that the image
on the flash is valid at this point.

As usual this patchset should got through the MTD tree and is based on
the l2-mtd-2.6 git.

Jonas Gorski (5):
  MTD: bcm63xxpart: check version marker string for newer CFEs
  MTD: bcm63xxpart: make sure CFE and NVRAM partitions are at least 64K
  MTD: bcm63xxpart: don't assume NVRAM is always the fourth partition
  MIPS: BCM63XX: bcm963xx_tag.h: make crc fields integers
  MTD: bcm63xxpart: check the image tag's crc32

 arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h |   11 +--
 drivers/mtd/bcm63xxpart.c                         |   89 ++++++++++++++-------
 2 files changed, 66 insertions(+), 34 deletions(-)

-- 
1.7.2.5
