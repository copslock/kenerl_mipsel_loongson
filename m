Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 04:05:27 +0200 (CEST)
Received: from mail-la0-f52.google.com ([209.85.215.52]:62244 "EHLO
        mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007121AbaH3CF0dVeoM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 04:05:26 +0200
Received: by mail-la0-f52.google.com with SMTP id ty20so3649475lab.11
        for <multiple recipients>; Fri, 29 Aug 2014 19:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eLsJnfKo6fbMJed9Prt5dhgI6LeZusEPvBNqxLf6JNQ=;
        b=bN+/nrnw4e14DbDUQjYmq30CTb3XUUdUlw615FMcbc4GqbYi8f3xdJZRtFl+zpjeFp
         K/Zj6aVYF+zasXynS79AJK9uk4nPJcGXfg3bqQCMOeYDTP2ZbtpDuxCnZPAph3k6r/1k
         u/i7DBPc5SBF1XDaBLrh4BMIRo1GFL+FVQkxbxGNdwZYQnLNC7eA8jHPBszGZVbw01Rp
         vM26VKwtVzKVTbvLDON+DnUVSIZXFtf413mHhKvDmRGwSmTD/hqtJmZmkyBB9V3NUJWV
         9T1kE2lvujhkWgnK3CcHhSfhjB10FZEzzlKLcxR/kH4J36XGlxRHXA+GGRkCZYbncjRm
         HQsw==
X-Received: by 10.152.36.229 with SMTP id t5mr15009837laj.42.1409364320910;
        Fri, 29 Aug 2014 19:05:20 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([188.113.6.134])
        by mx.google.com with ESMTPSA id l10sm2512262lbc.3.2014.08.29.19.05.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2014 19:05:20 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 0/5] MIPS: trivial PCI related cleanups
Date:   Sat, 30 Aug 2014 06:06:23 +0400
Message-Id: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

This series is attempt to cleanup some tiny issues, found during studying
the MIPS PCI code.

The first four patches remove the odd locking in the functions, which
are read and write the PCI device configuration registers. Ggeneric PCI code
already do proper locking so no need to add another one. Local PCI read/write
functions are never called simultaneously, also they do not require
synchronization with the PCI controller ops, since they are used before the
controller registration.

Lantiq also uses lock in config_read/config_write functions, but seems that
there are some reasons to do that, since the same lock used in other places
(e.g. flash driver, GPIO driver). So I left them as is.

The fifth patch makes PCI_DMA_BUS_IS_PHYS constant. There are no supported
machine with a IOMMU unit, so there are no reasons to keep run-time detection
support.

Sergey Ryazanov (5):
  MIPS: NILE4: remove odd locking in PCI config space access code
  MIPS: MSP71xx: remove odd locking in PCI config space access code
  MIPS: pci-ar7{1x,24}x: remove odd locking in PCI config space access  
      code
  MIPS: pci-rt3883: remove odd locking in PCI config space access code
  MIPS: make PCI_DMA_BUS_IS_PHYS=1 constant

 arch/mips/include/asm/pci.h      | 10 ++++------
 arch/mips/kernel/setup.c         |  7 -------
 arch/mips/pci/ops-nile4.c        | 12 +-----------
 arch/mips/pci/ops-pmcmsp.c       | 12 ------------
 arch/mips/pci/pci-ar71xx.c       | 13 -------------
 arch/mips/pci/pci-ar724x.c       | 23 -----------------------
 arch/mips/pci/pci-ip32.c         |  1 -
 arch/mips/pci/pci-rt3883.c       |  9 ---------
 arch/mips/pci/pci.c              |  3 ---
 arch/mips/pnx833x/common/setup.c |  3 ---
 10 files changed, 5 insertions(+), 88 deletions(-)

-- 
1.8.1.5
