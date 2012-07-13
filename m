Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 10:47:32 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:61696 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903467Ab2GMIr2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2012 10:47:28 +0200
Received: by bkcji2 with SMTP id ji2so2825809bkc.36
        for <multiple recipients>; Fri, 13 Jul 2012 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=n8j2xw9EImNzeTWcJOfDWmqw07zetSwtRMbb3nXMHHo=;
        b=seIZIGcbZIrmWn6l0iekJ10H6yQA2gZef3v4Z+Ko2lz/wbI6lJyZ9qhAqQMcPCQ5Q1
         8P8/H9c5OA6RQfDYHan7/ZhG2T33yej1n2TXXYIJinml+yKv346G3XyxJT/sdaj9D2Z+
         ot1pUppo9HzQUEF3W835e7owT6NUUgUeXwIddBGqDH8Ufi7U9OVsoagWAAD8vQhTMnM4
         YaJz6E5lIVfwj1KsU0/FRVvZsq1ScpcFy5FRSg4YmF1V9JQciZ9+SpZhpmQbDDmJPzHg
         tkvD3EZK3NkOPR1lTyj0AbeZXdNbqZxJky1o3ARWC2r4rNCpizSIkC8tVGq273232xQi
         2BkQ==
Received: by 10.205.136.3 with SMTP id ii3mr154113bkc.101.1342169243083;
        Fri, 13 Jul 2012 01:47:23 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-145-009.pools.arcor-ip.net. [88.73.145.9])
        by mx.google.com with ESMTPS id hg13sm4243506bkc.7.2012.07.13.01.47.21
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jul 2012 01:47:22 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 0/3] MIPS: BCM63XX: small fixes from the BCM6368 patches
Date:   Fri, 13 Jul 2012 10:46:02 +0200
Message-Id: <1342169165-18382-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 33903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

"MIPS: BCM63XX: add external irq support for non 6348 CPUs" and
"MIPS: BCM63XX: add support for bcm6368 CPU" received an update,
but the update never made it into the tree.

Since they can't be updated now, but there were real fixes in them
I decided to split them up into sensible patches and add a proper
commit log for them.

Maxime Bizon (3):
  MIPS: BCM63XX: add external irq support for BCM6345
  MIPS: BCM63XX: don't write to the chipid register on reboot
  MIPS: BCM63XX: use a switch for external irq config

 arch/mips/bcm63xx/irq.c                           |   22 ++++++++++++++++----
 arch/mips/bcm63xx/setup.c                         |    6 +++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    1 +
 3 files changed, 24 insertions(+), 5 deletions(-)

-- 
1.7.2.5
