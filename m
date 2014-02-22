Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Feb 2014 08:47:40 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:43445 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822302AbaBVHriR7HNJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Feb 2014 08:47:38 +0100
Received: by mail-pa0-f47.google.com with SMTP id kp14so4426213pab.6
        for <multiple recipients>; Fri, 21 Feb 2014 23:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LUlIREadiZiO4aVIruWpzlmmGRTHK/IDHIiihaMDgns=;
        b=HKMfVLKVb5oZ5ObU+jEj8NSiZrNyye3PyvczeUkBuQecRS1/SBb4kyC2IALeFzwgEZ
         iCwIpKhvcmJVSgy1cKeeylKrBWo+VIHBUL4tl89l2T8WLerj0nLr2cnHoTQzMjZ7LwKq
         hLCgiJ029PLZ4AEPWuA6l8Zml3otu75cIzCVw03VjjGt2HRGEV6FI0M8AXmPfDgXrfyE
         5nXSIjR5rwV1XGEOShbqpfkPTK6epOmlZ1NYfXJ/c1AWsy+v1ml8RhcCO5NbZr3vVqWJ
         H2MK045aeuuHOD98FRh+RVH0iUTK8bd5EabluDIDW27lDKHLKUUPbhaTC2tqEQ2LLxEM
         jDaA==
X-Received: by 10.66.156.137 with SMTP id we9mr13997620pab.30.1393055252043;
        Fri, 21 Feb 2014 23:47:32 -0800 (PST)
Received: from localhost.localdomain (42-72-119-126.dynamic-ip.hinet.net. [42.72.119.126])
        by mx.google.com with ESMTPSA id xs1sm67029365pac.7.2014.02.21.23.47.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Feb 2014 23:47:31 -0800 (PST)
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com,
        ralf@linux-mips.org, Qais.Yousef@imgtec.com,
        Viller Hsiao <villerhsiao@gmail.com>
Subject: [PATCH v2 0/2] MIPS: ftrace: Fix icache flush issue
Date:   Sat, 22 Feb 2014 15:46:47 +0800
Message-Id: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
X-Mailer: git-send-email 1.8.4.3
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39373
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
