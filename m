Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2011 00:17:51 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:58553 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903755Ab1LSXQz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Dec 2011 00:16:55 +0100
Received: by ghrr15 with SMTP id r15so2072899ghr.36
        for <multiple recipients>; Mon, 19 Dec 2011 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aRBFSDyQGridUBb0yT6+/SMbCPCSs6+VvI/jZl89UTU=;
        b=j9qTw7XISWF8Mw189vGbmG2s2mMkb+z7iol0FZ6UmkqkAm4c9LJXvvTcL9URJbvbRV
         6hAJ6tRy+LA1h7vqWBxPxv2zUOft/4tahaCBvBr9XTDD7ojKpFzYlfta3hwGTbHO2g/F
         WQ1WuW8/91fzJuVzwkQBy5YkkeEUA4X5ziluo=
Received: by 10.236.152.35 with SMTP id c23mr18082661yhk.58.1324336609676;
        Mon, 19 Dec 2011 15:16:49 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id j21sm976767ann.0.2011.12.19.15.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 15:16:48 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBJNGkOs029849;
        Mon, 19 Dec 2011 15:16:46 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBJNGiTE029848;
        Mon, 19 Dec 2011 15:16:44 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/5] MIPS: Move cache setup earlier.
Date:   Mon, 19 Dec 2011 15:16:37 -0800
Message-Id: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15607

From: David Daney <david.daney@cavium.com>

Found on 3.2-rc4, if jump label things are enabled, the kernel will
not boot on MIPS.

As noted in patch 5/5, this was caused by: commit
97ce2c88f9ad42e3c60a9beb9fca87abf3639faa (jump-label: initialize
jump-label subsystem much earlier).

The fix is to make flush_icache_range() usable earlier.  I do this by
calling cpu_cache_init() from setup_arch().  For the boot CPU we can
no longer call this from per_cpu_trap_init(), so I add a flag to that
function so we can skip the call if on the boot CPU.

Some of the code in the various cpu_cache_init() functions however
could not be called this early, so I moved it into functions called by
the new board_cache_error_setup() hook.

Tested on Octeon and ip32-R5000

David Daney (5):
  MIPS: Introduce board_cache_error_setup() hook.
  MIPS: Make set_handler() __cpuinit.
  MIPS: Octeon: Use board_cache_error_setup for cache error handler
    setup.
  MIPS: Use board_cache_error_setup for r4k cache error handler setup.
  MIPS: Move cache setup to setup_arch().

 arch/mips/include/asm/system.h |    2 +-
 arch/mips/include/asm/traps.h  |    1 +
 arch/mips/kernel/setup.c       |    3 +++
 arch/mips/kernel/smp.c         |    2 +-
 arch/mips/kernel/traps.c       |   15 ++++++++++-----
 arch/mips/mm/c-octeon.c        |   14 ++++++++------
 arch/mips/mm/c-r4k.c           |   14 ++++++++++----
 7 files changed, 34 insertions(+), 17 deletions(-)

-- 
1.7.2.3
