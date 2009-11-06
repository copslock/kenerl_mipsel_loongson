Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 11:45:51 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:54806 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492503AbZKFKpo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 11:45:44 +0100
Received: by pxi26 with SMTP id 26so300704pxi.21
        for <multiple recipients>; Fri, 06 Nov 2009 02:45:37 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9aaa+OiLua6UMflU4SOidZ37zJKSW77myhDp756Ka0s=;
        b=kEdBl5SfvT6byGqmmJtOvEiOIxJbNqCiD8XIPPMONOQUEq4PgGdh6UM16bWwMGLNqz
         KQxOR0WwuVhzRp9fkvbreIVTko3pXaRuusxyHuFffOriKJLPVHwPeodV/9go8j0v1Cuk
         Vi8mF4JjXO46cdMZ+WDMkV974WimzOxLEqVSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ucZLRqY55CifA6yTJaf6iml0y++wXxEdRsESHjxQqIoDLrK1pXC+UPeQqD4lA7iUte
         RHGXxmLavUiNzmHAtx26K5VqQpEvX/pSCvWGVMHSDZqmsrtp6cHpyq15S2KPPnICOBwi
         zTS1Dz0DPJ5VXc56zm7XPFZCJUzA18lXDnqv0=
Received: by 10.114.10.13 with SMTP id 13mr6539986waj.176.1257504337243;
        Fri, 06 Nov 2009 02:45:37 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm763633pxi.6.2009.11.06.02.45.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 02:45:36 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 0/2] add loongson2f support
Date:	Fri,  6 Nov 2009 18:45:04 +0800
Message-Id: <cover.1257504140.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The coming two patches add loongson2f support, including the basic loongson2f
features support and a fix for oprofile of loongson2f.

Wu Zhangjin (2):
  [loongson] add basic loongson-2f support
  [loongson] oprofile: avoid do_IRQ for perfcounter when the interrupt
    is from bonito

 arch/mips/Kconfig                                  |   18 ++++
 arch/mips/Makefile                                 |    2 +
 .../mips/include/asm/mach-loongson/dma-coherence.h |    4 +
 arch/mips/include/asm/mach-loongson/loongson.h     |   84 +++++++++++++++++++-
 arch/mips/include/asm/mach-loongson/mem.h          |   27 +++++--
 arch/mips/include/asm/mach-loongson/pci.h          |   28 ++++++-
 arch/mips/loongson/common/bonito-irq.c             |    5 +-
 arch/mips/loongson/common/init.c                   |    8 ++
 arch/mips/loongson/common/mem.c                    |   17 ++++
 arch/mips/loongson/common/pci.c                    |    8 ++
 arch/mips/oprofile/op_model_loongson2.c            |    5 +-
 11 files changed, 193 insertions(+), 13 deletions(-)
