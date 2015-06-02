Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 22:17:04 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:60969 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007106AbbFBURCFtrFc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 22:17:02 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.1/8.15.1) with ESMTPS id t52KGRxn014533
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 2 Jun 2015 13:16:27 -0700 (PDT)
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.224.2; Tue, 2 Jun 2015 13:16:27 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mips@linux-mips.org>, <x86@kernel.org>
Subject: [PATCH 0/4] Relocate module code from init.h to module.h
Date:   Tue, 2 Jun 2015 16:16:04 -0400
Message-ID: <1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.2.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

What started as a removal of no longer required include <linux/init.h>
due to the earlier __cpuinit and __devinit removal led to the observation
that some module specfic support was living in init.h itself, thus
preventing the full removal from introducing compile regressions.

This series of commits includes the final relocation of the modular
init code from <init.h> to <module.h> -- we do this because modular
users will always be users of init functionality, but users of init
functionality are not necessarily always modules.  Once done, the
trivial one line removals can be finalized at any time, a bit at a
time, through maintainer trees etc.

In order to do that, a couple of final things that this will uncover
are fixed up here -- things that weren't easily categorized into any
of the other previous series leading up to this final one.  The
previous groupings of commits that get us to this final series are:

1: [PATCH 00/11] Delete new __cpuinit users and then delete stubs
   https://lkml.kernel.org/r/1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com

2: [PATCH 00/11] Fix implicit includes of <module.h> that will break.                                                                                                                    
   https://lkml.kernel.org/r/1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>

3: [PATCH 00/15] Replace module_init with device_initcall in non modules                                                                                                                 
   https://lkml.kernel.org/r/1432860493-23831-1-git-send-email-paul.gortmaker@windriver.com

4: [PATCH 00/11] Replace module_init with an alternate initcall in non modules                                                                                                           
   https://lkml.kernel.org/r/1433120052-18281-1-git-send-email-paul.gortmaker@windriver.com

5: [PATCH 0/7] Introduce builtin_driver and use it for non-modular code
   https://lkml.kernel.org/r/1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>

This group of six is factored out from what was a previously larger series[1]
so that there is a common theme and lower patch count to ease review.  Setting
aside the trivial one line include <linux/init.h> removals for later also
greatly reduces the series size and makes all six parts more manageable.

Paul.

[1] http://lkml.kernel.org/r/1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com

---

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org
Cc: x86@kernel.org

Paul Gortmaker (4):
  x86: replace __init_or_module with __init in non-modular vsmp_64.c
  arm: fix implicit #include <linux/init.h> in entry asm.
  mips: make loongsoon serial driver explicitly modular
  module: relocate module_init from init.h to module.h

 arch/arm/kernel/entry-armv.S       |  2 +
 arch/mips/loongson/common/serial.c |  9 +++-
 arch/x86/kernel/vsmp_64.c          |  2 +-
 include/linux/init.h               | 78 -----------------------------------
 include/linux/module.h             | 84 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 81 deletions(-)

-- 
2.2.1
