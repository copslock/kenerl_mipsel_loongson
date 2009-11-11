Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 06:39:37 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:51326 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492043AbZKKFja (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 06:39:30 +0100
Received: by pwi15 with SMTP id 15so504053pwi.24
        for <multiple recipients>; Tue, 10 Nov 2009 21:39:22 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kL5DEThVRU+FCz7jApMACAEsgj+LluB+0m67OJdRsdQ=;
        b=wjI72scOZeVlXMBilkV3Qq0ZvuFYAtg7m0VKHoKa3StRVO6EcJW7QLqrhGMvEvYkqd
         IrM4AVCSV27b4CszyvJwibkuUd+gJ3tGWwzbc2DRiDmFDW5fNVtXbrpkkcsI5Huf+G/s
         TNDQVPnlLtdXvdrmbE3apBbAvqRBO5konOisg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YuwuaN6b7K1SRvJz+cDrHZZb7T1Io9oSpYiLFqHVFRYpF5Bx0pcDCFeKv1DmZuqeNJ
         VXIAgC/KFXgPDB/aqV+B57Uc7yzUNzAKvOapRbIpybkdojpdQvzgLAdlr0e5Qj90VrQB
         F0m/t6Q/vmhvUsQGlXLGDY50ik/Y3UNYjTpT8=
Received: by 10.114.237.37 with SMTP id k37mr2305695wah.31.1257917961955;
        Tue, 10 Nov 2009 21:39:21 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm850415pxi.6.2009.11.10.21.39.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 21:39:21 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 0/2] Cleanups of loongson support
Date:	Wed, 11 Nov 2009 13:39:10 +0800
Message-Id: <cover.1257917611.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset is needed for the coming patchsets.

  o [loongson] mem.c: indent the file with TAB instead of whitespaces
    The old mem.c use the whitespaces as the indent, fix it.
  o [loongson] 2f: Cleanups of the #if clauses
    add two new options for describing the features of loongson2f, and
    replaces the old ugly #if clauses by them.

Thanks & Regards,
	Wu Zhangjin

Wu Zhangjin (2):
  [loongson] mem.c: indent the file with TAB instead of whitespaces
  [loongson] 2f: Cleanups of the #if clauses

 arch/mips/Kconfig                              |    8 ++++++
 arch/mips/include/asm/mach-loongson/loongson.h |    6 ++--
 arch/mips/include/asm/mach-loongson/pci.h      |    4 +-
 arch/mips/loongson/common/init.c               |    2 +-
 arch/mips/loongson/common/mem.c                |   29 ++++++++++++-----------
 arch/mips/loongson/common/pci.c                |    2 +-
 6 files changed, 30 insertions(+), 21 deletions(-)
