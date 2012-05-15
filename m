Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 02:05:30 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:47687 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903662Ab2EOAFB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 02:05:01 +0200
Received: by pbbrq13 with SMTP id rq13so7650894pbb.36
        for <multiple recipients>; Mon, 14 May 2012 17:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Ssmh8eUXeY+viPRvhhPPKpTKTE14ZCQ8NUWnBUkRVy0=;
        b=0DhCgmkOC4IswMQ79kBGxq+GGo6DES2sc4hmpITsf5GRHXtpAdvLV7bbu/ffPsf56s
         ycNf+fqyufPgxde5R4qF99Lgi7E8473NDPW7EVahFXep4GXUcqqVHUsYgHBriuWWkvyt
         n/p/p3+D4h6iAgPmNMyyMEj+YHPRBu8oryyMxvRAsmpV94VgfmASNFX0+ea9t5HpSkFw
         RE+Okvx6xwiTDrPgekK7EEh2wXe3BTqeO3zMj/iOS4tyHSUE0Zgvr5X532k4LVw2ZSNg
         H69HPLqAyqhyZi02MSkqF2G2MIrgZKoOSy66K/jn1MZCNYB8S56/CrZx1fdCEV/QeeJ/
         g/8w==
Received: by 10.68.202.167 with SMTP id kj7mr1706065pbc.9.1337040294579;
        Mon, 14 May 2012 17:04:54 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id h10sm23667283pbh.69.2012.05.14.17.04.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 17:04:53 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4F04qrh016053;
        Mon, 14 May 2012 17:04:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4F04p8C016051;
        Mon, 14 May 2012 17:04:51 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/5] MIPS: Move cache setup earlier.
Date:   Mon, 14 May 2012 17:04:45 -0700
Message-Id: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

v2: Rebased to 3.4-rc7

>From v1:

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

 arch/mips/include/asm/setup.h |    3 ++-
 arch/mips/include/asm/traps.h |    1 +
 arch/mips/kernel/setup.c      |    2 ++
 arch/mips/kernel/smp.c        |    2 +-
 arch/mips/kernel/traps.c      |   16 ++++++++++------
 arch/mips/mm/c-octeon.c       |   14 ++++++++------
 arch/mips/mm/c-r4k.c          |   14 ++++++++++----
 7 files changed, 34 insertions(+), 18 deletions(-)

-- 
1.7.2.3
