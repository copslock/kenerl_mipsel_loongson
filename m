Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2011 15:17:44 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:47832 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491814Ab1BJORV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Feb 2011 15:17:21 +0100
Received: by fxm19 with SMTP id 19so1501541fxm.36
        for <linux-mips@linux-mips.org>; Thu, 10 Feb 2011 06:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=8gk8PV5Q2SillZvZ8W98zFlyBu0r1L9d5dUB+Y/tWmk=;
        b=A5Jy8uI2WKO4OtFy0nn3mJh4a5zwPaensWWGWqwPw50GMW11FISmGDmnq/u/m73CV3
         suok6QB49X8R4i/HrgTMI7oR0W1QVmcsNP5lv+DVyfc1LJnCAZ786Kss4EMSg/fmkiLF
         5IvKxA5VLWCCj8BpEZ37NFPxoKVQfhUHoL9s0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LJrGOa6nkLK5Lw3A0ExNCVYrA5YHGMmI/D/Fk02seqycPMZjjn7WuJsF8wPMupep/2
         KyBWUwSN7bnwdZoFm77ZMQoNvWETTmxwphkA6CZSZ6z7j4/fKDttFA03Ve5ihHrcn95x
         CV4PfN0b6qhLeSlkVeLCypTjnJWjxLnAbqukE=
Received: by 10.223.107.133 with SMTP id b5mr4169209fap.87.1297347435214;
        Thu, 10 Feb 2011 06:17:15 -0800 (PST)
Received: from localhost.localdomain (178-191-11-137.adsl.highway.telekom.at [178.191.11.137])
        by mx.google.com with ESMTPS id n1sm36732fam.16.2011.02.10.06.17.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 06:17:14 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: DB1200: Set Config_OD for improved stability.
Date:   Thu, 10 Feb 2011 15:17:08 +0100
Message-Id: <1297347429-18215-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297347429-18215-1-git-send-email-manuel.lauss@googlemail.com>
References: <1297347429-18215-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Setting Config_OD gets rid of a _LOT_ of spurious CPLD interrupts,
but also decreases overall performance a bit.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/db1200/setup.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
index 8876195..a3729c9 100644
--- a/arch/mips/alchemy/devboards/db1200/setup.c
+++ b/arch/mips/alchemy/devboards/db1200/setup.c
@@ -23,6 +23,13 @@ void __init board_setup(void)
 	unsigned long freq0, clksrc, div, pfc;
 	unsigned short whoami;
 
+	/* Set Config_OD (disable overlapping bus transaction):
+	 * This gets rid of a _lot_ of spurious interrupts (especially
+	 * wrt. IDE); but incurs ~10% performance hit in some
+	 * cpu-bound applications.
+	 */
+	set_c0_config(1 << 19);
+
 	bcsr_init(DB1200_BCSR_PHYS_ADDR,
 		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
 
-- 
1.7.4
