Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 16:09:16 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:35640 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab1LEPJD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2011 16:09:03 +0100
Received: by fabs1 with SMTP id s1so1350830fab.36
        for <multiple recipients>; Mon, 05 Dec 2011 07:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fv9iO90vlTjYW9SvfXQ5p3NfHH/BPRt8w2QqRxh8k6I=;
        b=Z5E9wBkRB9LKQHVjPt87HH5Vy/xiKTiLQIQz/JpOgRYOdxJqsXvjQeis6N0azJoAPb
         IflnS+YO7Jk0wIy5WQGS0r3tPIkUChvvQuUcLJIm7lUcXWHrBwWVCR7OE6nYW3hMmGO+
         T2wgTL/HXd4vEHLj+Jx5BiMUoc8Je2Mjnkw9U=
Received: by 10.227.205.14 with SMTP id fo14mr15754791wbb.22.1323097737992;
        Mon, 05 Dec 2011 07:08:57 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id dd4sm10772157wib.1.2011.12.05.07.08.56
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 07:08:57 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 0/7] MTD: MAPS: remove bcm963xx-flash
Date:   Mon,  5 Dec 2011 16:08:04 +0100
Message-Id: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 32031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3348

While trying to improve the bcm963xx CFE partition parsing, I noticed
that it could be completely replaced by the generic physmap flash
driver using a custom parser.

The following patch set tries to accomplish that.

The first few patches clean take care of some minor code style issues
first to prevent checkpatch from complaining when moving code around.

After that I move the CFE partition parsing into a parser and make
bcm963xx-flash use it to make sure I don't create a non working version.

Finally I'll allow physmap_flash_data to take partition parser names for
overriding the default parsers list (the OF version already allows that),
let BCM63XX use it, and remove the bcm963xx-flash driver as it is now
completely replaced by physmap + CFE parser.

While most patches are limited to the MTD tree, patch 6/7 touches MIPS,
so it could go in either tree. But since the MTD tree already has some
modifications for bcm963xx-flash, I think it's better to let it go
through the MTD tree, to reduce the (potential for) conflicts.

Regards
Jonas

P.S: This patchset is based on l2-mtd-2.6.git, which seems to be the
"correct" tree now (the website says mtd-2.6.git, but it doesn't look
like the correct one, having no commits). 

Jonas Gorski (7):
  MTD: MAPS: bcm963xx-flash: fix word order for spare partition
  MTD: MAPS: bcm963xx-flash: remove superfluous semicolons
  MTD: MAPS: bcm963xx-flash: clean up printk usage
  MTD: MAPS: bcm963xx-flash: make CFE partition parsing an mtd parser
  MTD: MAPS: physmap: allow partition parsers for physmap_flash_data
  MIPS: BCM63XX: use the new bcm63xxpart parser
  MTD: MAPS: remove the now unused bcm963xx-flash

 arch/mips/bcm63xx/boards/board_bcm963xx.c |    3 +
 drivers/mtd/Kconfig                       |    8 +
 drivers/mtd/Makefile                      |    1 +
 drivers/mtd/bcm63xxpart.c                 |  189 ++++++++++++++++++++
 drivers/mtd/maps/Kconfig                  |    1 +
 drivers/mtd/maps/bcm963xx-flash.c         |  265 -----------------------------
 drivers/mtd/maps/physmap.c                |    5 +-
 include/linux/mtd/physmap.h               |    1 +
 8 files changed, 207 insertions(+), 266 deletions(-)
 create mode 100644 drivers/mtd/bcm63xxpart.c
 delete mode 100644 drivers/mtd/maps/bcm963xx-flash.c

-- 
1.7.2.5
