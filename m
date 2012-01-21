Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2012 18:13:32 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:55273 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901168Ab2AURNZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2012 18:13:25 +0100
Received: by eekb15 with SMTP id b15so594794eek.36
        for <multiple recipients>; Sat, 21 Jan 2012 09:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CT6f+gaBJGPZYMQj1S2RcFUvZvxOBVi4qfoh1Jk+CnA=;
        b=jjnrPAhgwKPABZWSVkcoNiSlU2EpR6d+ZZ6oELL7PLKUXXOUgTwmtxbiwjJNTqjrqI
         t/N1yOJW9cGA1AlkN/DtML3AEuztLtpKxMdHlUNEocNPke4cR7UVn5tcSuQuR9POWQlN
         t6MHzoM7q/gGLKQf0KrYuUNOj96zNvOSlLmVo=
Received: by 10.213.29.5 with SMTP id o5mr496307ebc.140.1327166000559;
        Sat, 21 Jan 2012 09:13:20 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-10-45.adsl.highway.telekom.at. [188.22.10.45])
        by mx.google.com with ESMTPS id x4sm28076665eeb.4.2012.01.21.09.13.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Jan 2012 09:13:19 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 0/3] MIPS: Alchemy: updates for 3.4
Date:   Sat, 21 Jan 2012 18:13:12 +0100
Message-Id: <1327165995-27425-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.8.4
X-archive-position: 32295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Here's all I have for the next few merge windows:
A cleanup and another DB1200 improvement.

Thanks,
      Manuel Lauss

Manuel Lauss (3):
  MIPS: Alchemy: use 64MB RAM as minimum for devboards
  MIPS: Alchemy: devboards: kill prom.c
  MIPS: Alchemy: handle db1200 cpld ints as they come in

 arch/mips/alchemy/devboards/Makefile   |    2 +-
 arch/mips/alchemy/devboards/bcsr.c     |    5 +--
 arch/mips/alchemy/devboards/platform.c |   30 ++++++++++++++
 arch/mips/alchemy/devboards/prom.c     |   69 --------------------------------
 4 files changed, 32 insertions(+), 74 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/prom.c

-- 
1.7.8.4
