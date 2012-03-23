Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2012 23:52:12 +0100 (CET)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50620 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903743Ab2CWWvz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2012 23:51:55 +0100
Received: by obbup16 with SMTP id up16so3428999obb.36
        for <multiple recipients>; Fri, 23 Mar 2012 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=x3b05EfBxcu6xu/TMq6+fVlCCp09maCZ3JtkjQEdG98=;
        b=MQcoJrgluV87VUiRvECtqCatCdZs0pPxK/DvBinegIeu5YG4ubuWnmqODXLZnJPQBy
         /8NPKiEMy33I7DLOvY0ezp37/Or4dkeOYPXLGPYUGZJKje6hncc29MnjzNza/VFJOs+a
         iw4DL7tL6EfDDzwcCStBlv35KShwh/8od/5x0XRm6TX03LR6gp5TEsV4hoeNGw9Cuvj7
         pHFyOwYsrCn7jvxG/qLRlJiT3jZfv0yPZZm1SZI8CSpMzvVyMqFpV5DZqEqMGvd8nknx
         vHvKfUdr3JXoP1H+1kwtlk0DLIkY2eW4DwMvihfD9dkZs6lo6Q+EIgGIMQz491HWW+e0
         CB3A==
Received: by 10.182.119.101 with SMTP id kt5mr16672136obb.70.1332543109714;
        Fri, 23 Mar 2012 15:51:49 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id x5sm9041935obn.5.2012.03.23.15.51.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:51:48 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q2NMpjcg019966;
        Fri, 23 Mar 2012 15:51:46 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q2NMphcK019965;
        Fri, 23 Mar 2012 15:51:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/3] MIPS: OCTEON: irq handling improvements.
Date:   Fri, 23 Mar 2012 15:51:39 -0700
Message-Id: <1332543102-19922-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

These three patches are prerequisites for the follow-on device tree
patches, although they don't touch or use any device tree
functionality.

1/3: Handle GPIO interrupts and their triggering.

2/3: Remove a bunch of unused OCTEON_IRQ_ symbols.

3/3: Remove some duplicate definitions.

David Daney (3):
  MIPS: Octeon: Add irq handlers for GPIO interrupts.
  MIPS: OCTEON: Remove unneeded OCTEON_IRQ_* defines.
  MIPS: OCTEON: Consolidate the edge and level irq_chip structures.

 arch/mips/cavium-octeon/octeon-irq.c           |  175 ++++++++++++++----------
 arch/mips/include/asm/mach-cavium-octeon/irq.h |   40 +-----
 2 files changed, 105 insertions(+), 110 deletions(-)

-- 
1.7.2.3
