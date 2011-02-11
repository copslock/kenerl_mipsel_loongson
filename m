Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2011 09:48:22 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:60562 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490984Ab1BKIrz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Feb 2011 09:47:55 +0100
Received: by bwz5 with SMTP id 5so2803112bwz.36
        for <multiple recipients>; Fri, 11 Feb 2011 00:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=O7xd5JFOsBowJAYbKwjhGdpeYS6QHvKXh4zGoS7Y9Sw=;
        b=LZq9RKcgSVyJIxoNarmGt6pVe6rc+T9C+BXRxIrdhz0oEQBJVMWJIw/pHwIAWt69WE
         gVXuV0viz9leuPHbWCb7WjDXqolPsdMv58NJwrqUGz7CZxY5Rb1KeNE1ydrW9IyMjubn
         PEWG1mbP5w4DmKf5s9Hc/yDnpm+70wYLjvA3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=A1QUPKJAnUzfRrM0aIWQYdwWu7Yl4PQ/bTdbQ3uv2U55wrIXsCvHYN2IjhvaClYdHu
         YstIwYAwyILsNW2d98D21eKouC+eqXgN+VuLgE5K9k0WTbZTnzNa6puWplML0/jA4c8C
         CNnU1b4S2tyeqyiNHcL7YSg2E33EfFZiOWi18=
Received: by 10.204.121.142 with SMTP id h14mr21988176bkr.93.1297414068394;
        Fri, 11 Feb 2011 00:47:48 -0800 (PST)
Received: from localhost.localdomain (188-22-147-70.adsl.highway.telekom.at [188.22.147.70])
        by mx.google.com with ESMTPS id v25sm290909bkt.18.2011.02.11.00.47.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 00:47:47 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RESEND 0/2] Alchemy: use new irq methods
Date:   Fri, 11 Feb 2011 09:47:42 +0100
Message-Id: <1297414064-3446-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

[Resending without the umlaut in Ralf's surname]

These 2 patches change the core MIPS and Alchmey irq code to use the
new .irq_xxx methods.

The first patch is a prerequisite to turn on GENERIC_HARDIRQS_NO_DEPRECATED.
I have tested it with the C0 timer and it seems to run well, however the MIPS-MT
bits I cannot test.  Someone with capable hardware please test! Thank you!

The second patch changes the core alchemy and DB1200 board irq functions over
to the new .irq_xxx ones.

Run-tested on the DB1200.

Manuel Lauss (2):
  MIPS: Convert to new irq methods.
  Alchemy: Convert to new irq methods.

 arch/mips/Kconfig                  |    1 +
 arch/mips/alchemy/common/irq.c     |   83 +++++++++++++++++++-----------------
 arch/mips/alchemy/devboards/bcsr.c |   18 ++++----
 arch/mips/kernel/irq.c             |   12 ++++-
 arch/mips/kernel/irq_cpu.c         |   42 +++++++++---------
 5 files changed, 85 insertions(+), 71 deletions(-)

-- 
1.7.4
