Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 15:25:19 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2771 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903784Ab2HNNZK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 15:25:10 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 14 Aug 2012 06:23:41 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 14 Aug 2012 06:24:15 -0700
Received: from jc-linux.netlogicmicro.com (unknown [10.7.2.153]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E3BF89F9F5; Tue, 14
 Aug 2012 06:24:52 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 0/2] MIPS: Netlogic: Fixes for 3.6
Date:   Tue, 14 Aug 2012 18:56:11 +0530
Message-ID: <1344950773-29299-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7C348ED63NK15214745-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Two patches for Netlogic processors for 3.6, the second patch is critical
and fixes a hang on boot in 3.6, and the first patch is optional and fixes
a BUG() when preempt is enabled.

I had send these two separately earlier today, but the patches had a
mixture of netlogic and broadcom mail addresses.

JC.

Jayachandran C (2):
  MIPS: Netlogic: define cpu_has_fpu macro
  MIPS: Synchronize MIPS count one CPU at a time

 .../asm/mach-netlogic/cpu-feature-overrides.h      |    2 ++
 arch/mips/include/asm/r4k-timer.h                  |    8 +++---
 arch/mips/kernel/smp.c                             |    4 +--
 arch/mips/kernel/sync-r4k.c                        |   26 +++++++++-----------
 4 files changed, 19 insertions(+), 21 deletions(-)

-- 
1.7.9.5
