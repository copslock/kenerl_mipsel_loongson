Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2011 23:50:06 +0200 (CEST)
Received: from ogre.sisk.pl ([217.79.144.158]:58501 "EHLO ogre.sisk.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491025Ab1GPVt7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jul 2011 23:49:59 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by ogre.sisk.pl (Postfix) with ESMTP id 335BC1B09BA;
        Sat, 16 Jul 2011 23:21:13 +0200 (CEST)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24313-04; Sat, 16 Jul 2011 23:20:52 +0200 (CEST)
Received: from ferrari.rjw.lan (unknown [76.164.19.200])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ogre.sisk.pl (Postfix) with ESMTP id 04CAD1B0826;
        Sat, 16 Jul 2011 23:20:52 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@sisk.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] MIPS build fix related to power management for 3.0
Date:   Sat, 16 Jul 2011 23:50:50 +0200
User-Agent: KMail/1.13.6 (Linux/3.0.0-rc7+; KDE/4.6.0; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@lists.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201107162350.51025.rjw@sisk.pl>
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
X-archive-position: 30643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11765

Hi Linus,

Please pull a MIPS build fix related to PM for 3.0 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

It fixes a build regression resulting from a missing conversion from using
a sysdev to using syscore_ops for PM/shutdown in the MIPS tree.


 arch/mips/kernel/i8259.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

----------

Rafael J. Wysocki (1):
      PM / MIPS: Convert i8259.c to using syscore_ops
