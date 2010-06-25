Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jun 2010 01:46:57 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4148 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492390Ab0FYXqZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Jun 2010 01:46:25 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c253fe50000>; Fri, 25 Jun 2010 16:46:45 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 25 Jun 2010 16:46:21 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 25 Jun 2010 16:46:21 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o5PNkEEP028964;
        Fri, 25 Jun 2010 16:46:14 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o5PNkA3a028963;
        Fri, 25 Jun 2010 16:46:10 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] arch_hweight implementation for MIPS
Date:   Fri, 25 Jun 2010 16:46:06 -0700
Message-Id: <1277509568-28927-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 25 Jun 2010 23:46:21.0674 (UTC) FILETIME=[9D5F5CA0:01CB14C0]
X-archive-position: 27252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17736

Recently the core hweight implementation was reworked to make it
easier for an architecture to implement optimized hweight()
operations.

For MIPS, I get lazy and fall back to letting GCC emit the optimized
code if it can.  If ARCH_HAS_USABLE_BUILTIN_POPCOUNT is defined, we
let GCC do it, otherwise, the fallback library call is used.

The second patch turns this on for OCTEON as it has POP and DPOP
instructions that GCC knows about.

David Daney (2):
  MIPS: Create and use asm/arch_hweight.h
  MIPS: Octeon: Define ARCH_HAS_USABLE_BUILTIN_POPCOUNT for OCTEON.

 arch/mips/include/asm/arch_hweight.h               |   38 ++++++++++++++++++++
 arch/mips/include/asm/bitops.h                     |    5 ++-
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    8 ++++
 3 files changed, 50 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/arch_hweight.h
