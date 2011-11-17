Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 15:03:24 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:37010 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904036Ab1KQODU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 15:03:20 +0100
Received: by bkat2 with SMTP id t2so2579969bka.36
        for <multiple recipients>; Thu, 17 Nov 2011 06:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0/NzG6H9XXEr5gucs6+E9xORursC6wFczMAb5qcnJiU=;
        b=aaZEj4JA2i8Pfl5UtzHIl0li7jev13POIbIYtAJC/50usGnORnRwmIILfXwT8VRQwT
         Ue4SEaaFOuuLY2I51k0PFHInYt5sXHP11DUpdYoLBkw2OqpYLZvY98mYBpcgjRpnBZkw
         rf6k9oZQxa8PsQsTv0VVHqwwTNtngonLReWns=
Received: by 10.205.135.129 with SMTP id ig1mr14550117bkc.106.1321538595235;
        Thu, 17 Nov 2011 06:03:15 -0800 (PST)
Received: from localhost.localdomain (dslb-178-003-254-091.pools.arcor-ip.net. [178.3.254.91])
        by mx.google.com with ESMTPS id x14sm41318988bkf.10.2011.11.17.06.03.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 06:03:14 -0800 (PST)
From:   Rene Bolldorf <xsecute@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rene Bolldorf <xsecute@googlemail.com>
Subject: [PATCH 0/2] Summary
Date:   Thu, 17 Nov 2011 15:02:55 +0100
Message-Id: <1321538577-548-1-git-send-email-xsecute@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <CAEWqx59k97AMU6hH0NCC2TMEY2mu8d5ytxO68oEsa=7uvLBA4A@mail.gmail.com>
References: <CAEWqx59k97AMU6hH0NCC2TMEY2mu8d5ytxO68oEsa=7uvLBA4A@mail.gmail.com>
X-archive-position: 31726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14475

Here is patchset v2 with coding style fixes and code improvements.

Rene Bolldorf (2):
  Initial PCI support for Atheros 724x SoCs. (v2)
  Initial support for the Ubiquiti Networks XM board (rev 1.0). (patch
    v2)

 arch/mips/ath79/Kconfig                        |   11 ++
 arch/mips/ath79/Makefile                       |    1 +
 arch/mips/ath79/mach-ubnt-xm.c                 |  119 ++++++++++++++++
 arch/mips/ath79/machtypes.h                    |    1 +
 arch/mips/include/asm/mach-ath79/pci-ath724x.h |   21 +++
 arch/mips/pci/Makefile                         |    1 +
 arch/mips/pci/pci-ath724x.c                    |  174 ++++++++++++++++++++++++
 7 files changed, 328 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/mach-ubnt-xm.c
 create mode 100644 arch/mips/include/asm/mach-ath79/pci-ath724x.h
 create mode 100644 arch/mips/pci/pci-ath724x.c

-- 
1.7.7.1
