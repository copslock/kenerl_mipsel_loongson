Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 20:33:08 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:47595 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903618Ab2D0Scx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 20:32:53 +0200
Received: by dakb39 with SMTP id b39so1178899dak.35
        for <multiple recipients>; Fri, 27 Apr 2012 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=DPq54vx61zP4C/q7m7BkJadHMrnHiAr0ftRMaJCHpIg=;
        b=Kqlot51m2Ypzqe8XXaCbukQjtmUvwLBndyAM9Us+AwoYFLmhaUsnzpbXnjdfmriZeI
         dOEMSIABC/p69bfs7qSdCTbNa2ear4CYtvcra0hkNYK/JwFOOVolSUjGJokXE3uRmC7t
         qT/ncJzsjk22SUjBGy55qAeqTuwWly8yOU+xGYbVK78+vTU/SqjmODVP5sE4FggVGxkF
         x7QoipuREruyMTvpCiRRqAK4MIgizcOqrpXq857SNWzlcq5p51SkLPRNd7tT94XfUTjc
         TuxDphSuwJZOCIjxfbvBSPEFdwskIV8bjPQaaKNKt90OzW1jr/WbjiGCXSnoOHrcfB1y
         0Ctg==
Received: by 10.68.136.1 with SMTP id pw1mr25147033pbb.105.1335551566802;
        Fri, 27 Apr 2012 11:32:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pn10sm5617123pbb.22.2012.04.27.11.32.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 11:32:45 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3RIWiqe019622;
        Fri, 27 Apr 2012 11:32:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3RIWh62019620;
        Fri, 27 Apr 2012 11:32:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/8] MIPS: OCTEON: Interrupt controller enhancements.
Date:   Fri, 27 Apr 2012 11:32:32 -0700
Message-Id: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

These patches are meant to be applied on top of:

http://www.linux-mips.org/archives/linux-mips/2012-03/msg00159.html
http://www.linux-mips.org/archives/linux-mips/2012-04/msg00169.html
http://www.linux-mips.org/archives/linux-mips/2012-04/msg00173.html

The interrupt controller on cn68XX is fundamentally different then on
previous members of the OCTEON family.  To support it requires
importing new register layout definitions for all OCTEONs.  The reason
for the patches are roughly as follows:

1) Recognize cnf71xx parts, as they are referred to in ...

2) Updated register definitions for all OCTEON parts.

3) Fix snafu in previous patch set.

4) Rid ourselves of unused OCTEON_IRQ_* definitions.  We use the
   device tree infrastructure to find most irqs now.

5) The OCTEON_IRQ_* definitions we still use need to be augmented for
   the added number of CPUs and increase in size of other SOC
   resources.

6) Add cn68XX CIU2 support.

7) Quit using sly tricks to avoid taking locks.  These tricks fail
   with threaded interrupt handlers.

8) Fix !CONFIG_SMP build failure.

David Daney (8):
  MIPS: OCTEON: Add detection of cnf71xx parts.
  MIPS: OCTEON: Update register definitions.
  MIPS: OCTEON: Fix GPIO interrupt configuration.
  MIPS: OCTEON: Get rid of unused OCTEON_IRQ_* definitions.
  MIPS: OCTEON: Add OCTEON_IRQ_* definitions for cn68XX chips.
  MIPS: OCTEON: Add support for cn68XX interrupt controller.
  MIPS: Octeon: Make interrupt controller work with threaded handlers.
  MIPS: OCTEON: Don't refer to  octeon_irq_cpu_offline_ciu() when
    !CONFIG_SMP
