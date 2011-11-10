Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 20:10:08 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:37584 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903567Ab1KJTKD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2011 20:10:03 +0100
Received: by faar25 with SMTP id r25so119238faa.36
        for <multiple recipients>; Thu, 10 Nov 2011 11:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=976/97JmQSZW6EkIPey9bL0+djHJVsWdhPNZzFBdDO0=;
        b=ch6340hRjtRrLPEAPJfreQEvDeNp0w3PwvHln3kc6Djl4IzLBQorNmX9k5afprKBxr
         hzB6gocJ3j8pbqWsNtPkWacoc5b1ncXZ67zvuRSlagyXrQAH18XrceNsmJ030+IZygrr
         x7QK9XPsZCglt+qX6pLFz4lyHKx9n/FQbVWKU=
Received: by 10.152.104.167 with SMTP id gf7mr5242575lab.46.1320952198056;
        Thu, 10 Nov 2011 11:09:58 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-13-175.adsl.highway.telekom.at. [188.22.13.175])
        by mx.google.com with ESMTPS id tu2sm8213580lab.11.2011.11.10.11.09.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 11:09:57 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH mips-next 0/3] MIPS: Alchemy: autoselect IRQ at bootup
Date:   Thu, 10 Nov 2011 20:09:35 +0100
Message-Id: <1320952178-14228-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.2
X-archive-position: 31506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9696

This patch merges the codes of both IRQ controller types into one, and
uses autodetection to set up the proper one at boot.  To work around
the plat_irq_dispatch mess both ICs are set up as chained handlers of
the traditional MIPS IRQs.  Should be safe until SMP Alchemys arrive
(which is not going to happen anytime soon, I guess).

Works as intended on all my test boards.

Applies on top of the other Alchemy patches in mips-next-3.3

Manuel Lauss (3):
  MIPS: Alchemy: irq: register pm at irq init time
  MIPS: Alchemy: cascade IRQ controllers to MIPS IRQ controller
  MIPS: Alchemy: merge Au1000 and Au1300-style IRQ controller code.

 arch/mips/alchemy/common/Makefile  |    5 +-
 arch/mips/alchemy/common/gpioint.c |  411 -----------------
 arch/mips/alchemy/common/irq.c     |  864 +++++++++++++++++++++++++-----------
 3 files changed, 614 insertions(+), 666 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/gpioint.c

-- 
1.7.7.2
