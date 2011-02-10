Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2011 10:07:15 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:53066 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490993Ab1BJJHM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Feb 2011 10:07:12 +0100
Received: by bwz5 with SMTP id 5so1758145bwz.36
        for <multiple recipients>; Thu, 10 Feb 2011 01:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=1DTO9EvcojE48iUKGD2x1kGcjLFKY9PXypjQei2Ij3s=;
        b=O90ZM5y3vZMTwoSOimOBMhSA/66olPzPbGmquUCh8PhFZ41RH7h4eIrRfRSBtFPG7H
         Or2PEmbr59o6dz8bmrANJa8tB8efwt/0/9ZXghVZfXFs6RVly50tVwy1slCR4rsxwQNb
         fORUHf1+kuH853dADcTFinbzls2UMmIvEcauk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DkAm6dMJBFjn4qj8tRQcHMUZJaNAt3/2D+UYCD04jsb4HZJZx/0W6xiSZ5JGAflUJY
         Cwm8llTzasH+WuKxnicBgC9sZsGfyFwuXMNklCQxR44wrPVFW4Bp2+ot/0v6lJjd38Wa
         A2pNpTxMppFyNENZFNigPixbfr8Pa5BJ3gBi0=
Received: by 10.204.100.70 with SMTP id x6mr6287750bkn.0.1297328826543;
        Thu, 10 Feb 2011 01:07:06 -0800 (PST)
Received: from localhost.localdomain (178-191-14-1.adsl.highway.telekom.at [178.191.14.1])
        by mx.google.com with ESMTPS id v1sm817617bkt.5.2011.02.10.01.07.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Feb 2011 01:07:05 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     =?UTF-8?q?Ralf=20B=E4chle?= <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 0/2] Alchemy: use new irq methods
Date:   Thu, 10 Feb 2011 10:07:00 +0100
Message-Id: <1297328822-4621-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

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
