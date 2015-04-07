Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 22:35:07 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34118 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014255AbbDGUfFvZHxw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 22:35:05 +0200
Received: by pacyx8 with SMTP id yx8so89901162pac.1;
        Tue, 07 Apr 2015 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rrk1a7BD/Z1r9WimnHnJle8Zy5sqP2kYdQ3nn1aMWjc=;
        b=ZLi42UZWn6WkY2VkC5IydhbLx2eWSNP8+wUgBGtEF8HYVwY5TLmxMNQK0PIhfK7o+4
         LWM8xgD3Wje1sVBUyv+RMU+GsFSzSr5de0wKOTLs1hO22dWb7x7GGyoY97mv9HoJthXt
         OPq8kRyuXvkydfxuB3Xbs9YnSShlZ4yoVput/MZDtEUDSW0Ncf69yFDZDSFXVA0yc9aQ
         95vmeG+WwnSxwgMv4hHeQjA+1Ppb0zDPdFDr8S87DhO68qNa8CsMXR61RkzX0wdWD5wR
         PcgZhRp9nspJHU28AbDRKWuY1OZkkqjD49Kp5wmQSlzx/diRCIJC4nwedJUYpbpHHH20
         z9dA==
X-Received: by 10.70.136.67 with SMTP id py3mr37608360pdb.112.1428438900799;
        Tue, 07 Apr 2015 13:35:00 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id ve3sm8856029pbc.22.2015.04.07.13.34.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Apr 2015 13:34:59 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/3 v2] Make BMIPS post DMA flush hook usable for bcm63xx
Date:   Tue,  7 Apr 2015 13:33:59 -0700
Message-Id: <1428438842-5728-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46817
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

Hi Ralf,

Per your request, this is the patch set which supersedes everything I submitted
before, build tested on mach-bmips and mach-bcm63xx and verified the diassembly
to make sure the post-dma flush hook is inserted.

Patches against mips-for-linux-next on top of:
8a5f1efbb1a13cd2e2a1c2d1ae3773821e8b1d67 ("MIPS: BMIPS: restrict DTB selection
to BMIPS_GENERIC")

Changes in v2:
- move only plat_post_dma_flush, rename to bmips_plat_post_dma_flush
- allow platforms to override only the plat_post_dma_flush from the
  generic implementation
- create a minimalistic dma-coherence.h file for bcm63xx

Florian Fainelli (3):
  MIPS: BMIPS: Move post DMA flush implementation to common header
  MIPS: DMA: Allow platforms to override only the post DMA hook
  MIPS: BCM63xx: Provide a plat_post_dma_flush hook

 arch/mips/include/asm/bmips.h                      | 16 ++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h | 10 ++++++++++
 arch/mips/include/asm/mach-bmips/dma-coherence.h   | 16 +---------------
 arch/mips/include/asm/mach-generic/dma-coherence.h |  2 ++
 4 files changed, 29 insertions(+), 15 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h

-- 
2.1.0
