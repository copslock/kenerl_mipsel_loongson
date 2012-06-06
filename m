Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 00:44:31 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:59893 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903712Ab2FFWoZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 00:44:25 +0200
Received: by dadm1 with SMTP id m1so10165382dad.36
        for <multiple recipients>; Wed, 06 Jun 2012 15:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=NbJm++N3EOuWNKjGtDF80XLq5ym67GX8W7GS0kw8rmI=;
        b=u7Cs2Ip+Vwi4Il2yKkFL0MVZLl01FJVIlVjVoS9/1uD7ikv6Xpmzcd7JB1Rv/wUUSq
         brbtaopTafdAUJ7QOR0ZbLHd/BQMlgNSnG2+pmtULJbXPrMo6Fi5To0UxrtrqJ0pcFf1
         fYU5GU7oMUBxoFtLHDEy6eh8fkoTw2NwLm9bK7QU2A69a+7yLs1aYVBbFrz4HzRHtzFE
         OQ/GOl6iiCRSOSikNMe0CY/KtKmbD9ta5iylHHWEAoyDQIGIyDIdKqQfdXcOa/2vzyAB
         a5J84G3LaPk2NyUVeD1Us4nMCPW6C2CxWyOcHqsUfZYzm5VjfXcWoZLRwhvc/M0sXhii
         IArA==
Received: by 10.68.237.74 with SMTP id va10mr1969227pbc.46.1339022658675;
        Wed, 06 Jun 2012 15:44:18 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ve6sm1765119pbc.75.2012.06.06.15.44.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 15:44:17 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q56MiGTu019896;
        Wed, 6 Jun 2012 15:44:16 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q56MiGHr019894;
        Wed, 6 Jun 2012 15:44:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/3] MIPS: OCTEON: irq handling improvements.
Date:   Wed,  6 Jun 2012 15:44:12 -0700
Message-Id: <1339022655-19860-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

v2:

Small bug fix in the GPIO interrupt handling.  Rebased.

v1:

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

 arch/mips/cavium-octeon/octeon-irq.c           |  184 ++++++++++++++---------
 arch/mips/include/asm/mach-cavium-octeon/irq.h |   40 +-----
 2 files changed, 114 insertions(+), 110 deletions(-)

-- 
1.7.2.3
