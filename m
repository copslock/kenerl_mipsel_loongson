Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 08:39:15 +0100 (CET)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33657 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816759AbaCRHjMpLht2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2014 08:39:12 +0100
Received: by mail-pd0-f178.google.com with SMTP id x10so6747981pdj.9
        for <multiple recipients>; Tue, 18 Mar 2014 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cjzsumlad3UROUJXbIJduoEC+FFCcjre1Epk8RbO4Gs=;
        b=Y7WLxzTY9yHS9Rcw5IjnKdhUDv/074jj+kRY4vhxKKZl0CQYLOgqVRp2Vp/H7rlpAr
         P3kfbnK2oLrDP3+VrkBOhlS+K8iFUjdyQgTXGXByXLfh95blPkvHOaVOt6ZXHdaOggI+
         At/5EwnpcAMzu2IfrMc669my8HrEwcxkaI05VrcxmoQA5m6m21B6HEJUtP2a01u1xuLF
         RWGGbv40LHi4eoJUhhFag8/qWdvM4iB/APM2isfUMhnSnCGJFj+6c4PLvEr2G3T+Ndo/
         LAYGfT4uW3vKYKUgl2N20y2Jj/YuP2NlAfK083PPkFX2gEQ2hXQdDtvKHketaIH7porM
         5PcA==
X-Received: by 10.67.4.169 with SMTP id cf9mr31250138pad.45.1395128346043;
        Tue, 18 Mar 2014 00:39:06 -0700 (PDT)
Received: from localhost.localdomain (42-74-21-171.dynamic-ip.hinet.net. [42.74.21.171])
        by mx.google.com with ESMTPSA id it4sm49826111pbc.39.2014.03.18.00.38.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Mar 2014 00:39:02 -0700 (PDT)
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com,
        ralf@linux-mips.org, Qais.Yousef@imgtec.com,
        Viller Hsiao <villerhsiao@gmail.com>
Subject: [PATCH v3 0/2] MIPS: ftrace: Fix icache flush issue
Date:   Tue, 18 Mar 2014 15:38:28 +0800
Message-Id: <1395128308-31909-1-git-send-email-villerhsiao@gmail.com>
X-Mailer: git-send-email 1.8.4.3
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39487
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


v3 version tweaks some words from v2 to let it more readable.

This patch set is based on mips-for-linux-next branch.

Viller Hsiao (2):
  MIPS: ftrace: Tweak safe_load()/safe_store() macros
  MIPS: ftrace: Fix icache flush range error

 arch/mips/include/asm/ftrace.h | 20 ++++++++++----------
 arch/mips/kernel/ftrace.c      |  5 ++---
 2 files changed, 12 insertions(+), 13 deletions(-)

-- 
1.8.4.3
