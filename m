Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2009 12:53:02 +0200 (CEST)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:51543 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491935AbZJSKwz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Oct 2009 12:52:55 +0200
Received: by fxm7 with SMTP id 7so4630482fxm.34
        for <multiple recipients>; Mon, 19 Oct 2009 03:52:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NBUitsc0l68/MyB3Dyax17aewKaKKNeK+HTmvbRJpn4=;
        b=JNwCvgei9Xv0SzFqKSe+oiDad06ATupkhYHTkBLOECcnpyu147K2l/bxemVZEQ+91m
         Wl58qjepbomqs6hTGq7gjMUeohzyhBB37vMC/NwcGheWV5pKiQjZalYNz6K5maMtVqXa
         7AM9L/hkCYho9wzRQo3a7bU4tfRYVdLJnyY8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xMDLFrfTEVY6rCjqac/ky1F0m01GoBQYCzT1Mr+hwotlTY5QAz6BsFoMKtA6WEwDHT
         wVsghy3QEJhxj7A6xgxRLIjkCm682sVuC8u12F+JmZfeTv+nkbx6RDWpkVwdIUBMxDOL
         ZQUjOEZ8D44PZlhMyLQYUQfu7c3nHp1yVqvI8=
Received: by 10.204.13.201 with SMTP id d9mr4757227bka.12.1255949568826;
        Mon, 19 Oct 2009 03:52:48 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil36.netpark.at [217.175.205.164])
        by mx.google.com with ESMTPS id 13sm583900bwz.2.2009.10.19.03.52.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Oct 2009 03:52:46 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: wire up db1x00/platform.c in Makefile
Date:	Mon, 19 Oct 2009 12:53:23 +0200
Message-Id: <1255949603-22906-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Amends commit "MIPS: Alchemy: devboards: wire up new PCMCIA driver."
in mips-queue.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Ralf could you please fold this into the above mentioned patch in -queue?
Thank you!

 arch/mips/alchemy/devboards/db1x00/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1x00/Makefile b/arch/mips/alchemy/devboards/db1x00/Makefile
index ce48d58..613c0c0 100644
--- a/arch/mips/alchemy/devboards/db1x00/Makefile
+++ b/arch/mips/alchemy/devboards/db1x00/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor DBAu1xx0 boards.
 #
 
-obj-y := board_setup.o
+obj-y := board_setup.o platform.o
-- 
1.6.5
