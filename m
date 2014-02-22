Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Feb 2014 08:34:30 +0100 (CET)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:56475 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815989AbaBVHe1rybt5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Feb 2014 08:34:27 +0100
Received: by mail-pb0-f41.google.com with SMTP id up15so4447976pbc.0
        for <multiple recipients>; Fri, 21 Feb 2014 23:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UH4u6ztrD2dtXxICDSg8iklVfSqNdxtcgVV8Z+TzaUs=;
        b=DFC/nrPtvdZsrf8PmMTitKT5gDKHWfFuuzRIztdXy+reqyV5MLXdFqaHX1U8I6yCqN
         yq1+aqpH9A3KQFK2NlhPwr7MR0tlMAxa6sMixgxeDeLdU4jcAS1uEplkzzF/goUTIU2t
         65nxv3xBHfIvoWkFyKUqWfLDRrO/Y+xPXcNJnfFRqGoJvWgYGiBu50PuaS3xND44OTxr
         CxUepe1AXTOsKCdHXCndCM/JLiJ+kHWAbxKESabjy3K123moy3rdsEze4Hzq1lV3RRvH
         kbcurrI8Qwe13+QJCCWcJwZBjz2AUXVTifFgyJ9zRAyPIL6pLPHOkDS0qcBHXLMZkRzc
         7zcA==
X-Received: by 10.66.148.230 with SMTP id tv6mr13848848pab.155.1393054460989;
        Fri, 21 Feb 2014 23:34:20 -0800 (PST)
Received: from localhost.localdomain (42-72-119-126.dynamic-ip.hinet.net. [42.72.119.126])
        by mx.google.com with ESMTPSA id n6sm28331046pbj.22.2014.02.21.23.34.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Feb 2014 23:34:20 -0800 (PST)
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Viller Hsiao <villerhsiao@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>
Subject: 
Date:   Sat, 22 Feb 2014 15:31:56 +0800
Message-Id: <1393054318-27356-1-git-send-email-villerhsiao@gmail.com>
X-Mailer: git-send-email 1.8.4.3
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: villerhsiao@gmail.com
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

Subject: [PATCH v2 0/2] MIPS: ftrace: Fix icache flush issue

In 32-bit mode, the start address of flushing icache is wrong because
of error address calculation. It causes system crash at boot when
dynamic function trace is enabled. This issue existed since linux-3.8.

In the patch set, I fixed the flushing range and refined the macros
used by it to pass compilation.

Patch 1 is tried to improve the usability of some macros such that
we can make patch 2 cleaner. Patch 2 fixes this issue.

This patch set is based on commit 7d3f1a5 of mips-for-linux-next branch.

Viller Hsiao (2):
  MIPS: ftrace: Tweak safe_load()/safe_store() macros
  MIPS: ftrace: Fix icache flush range error

 arch/mips/include/asm/ftrace.h | 20 ++++++++++----------
 arch/mips/kernel/ftrace.c      |  5 ++---
 2 files changed, 12 insertions(+), 13 deletions(-)

-- 
1.8.4.3
