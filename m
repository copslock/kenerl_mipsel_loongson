Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 11:56:17 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:38314 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903782Ab1KPK4L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 11:56:11 +0100
Received: by faar25 with SMTP id r25so1653534faa.36
        for <multiple recipients>; Wed, 16 Nov 2011 02:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=t3Z4QX5jKfuM3yRPamLfECvgjyhj1aoNqN5+v7SR2H8=;
        b=RhmWIm+2prrPwNFvqatRAmLJvmp2iPNAmTSrgzjm3UXChgtpbESVKZT282ZZ/Bhs8r
         irECn/R6Q2sWEV/tmqpBqCcKJaO0z9f/vUV0MWFhQw4VsYOFspvcYEkbWGT3nr0JNaGx
         QaDaGYwmTcgIz5jSNaB9WnhD+MqAmlvLDvlfs=
Received: by 10.205.120.20 with SMTP id fw20mr28761869bkc.39.1321440966229;
        Wed, 16 Nov 2011 02:56:06 -0800 (PST)
Received: from localhost.localdomain (dslb-178-003-254-091.pools.arcor-ip.net. [178.3.254.91])
        by mx.google.com with ESMTPS id z7sm38609961bka.1.2011.11.16.02.56.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 02:56:05 -0800 (PST)
From:   Rene Bolldorf <xsecute@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rene Bolldorf <xsecute@googlemail.com>
Subject: [PATCH 0/2] Summary
Date:   Wed, 16 Nov 2011 11:55:38 +0100
Message-Id: <1321440940-20246-1-git-send-email-xsecute@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 31641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13288

Hello,

this patchset adds initial PCI support for 724x Atheros SoCs and initial support for the Ubiquiti Networks XM board (Nanostation Mx, Nanobridge Mx, etc.).

Best Regards

Rene Bolldorf (2):
  Initial PCI support for Atheros 724x SoCs.
  Initial support for the Ubiquiti Networks XM board.

 arch/mips/ath79/Kconfig        |   12 ++++
 arch/mips/ath79/Makefile       |    1 +
 arch/mips/ath79/Platform       |    7 ++-
 arch/mips/ath79/mach-ubnt-xm.c |  110 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/ath79/machtypes.h    |    1 +
 arch/mips/pci/Makefile         |    1 +
 arch/mips/pci/ops-ath724x.c    |  109 +++++++++++++++++++++++++++++++++++++++
 arch/mips/pci/pci-ath724x.c    |   45 ++++++++++++++++
 8 files changed, 283 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/ath79/mach-ubnt-xm.c
 create mode 100644 arch/mips/pci/ops-ath724x.c
 create mode 100644 arch/mips/pci/pci-ath724x.c

-- 
1.7.7.1
