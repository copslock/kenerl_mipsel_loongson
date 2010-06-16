Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 00:01:18 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17112 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491198Ab0FPWAr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 00:00:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c1949a20001>; Wed, 16 Jun 2010 15:01:06 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 16 Jun 2010 15:00:44 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 16 Jun 2010 15:00:43 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o5GM0YdA008610;
        Wed, 16 Jun 2010 15:00:35 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o5GM0W8F008609;
        Wed, 16 Jun 2010 15:00:32 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] MIPS vdso fixes.
Date:   Wed, 16 Jun 2010 15:00:26 -0700
Message-Id: <1276725628-8572-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 16 Jun 2010 22:00:43.0704 (UTC) FILETIME=[5DEE2380:01CB0D9F]
X-archive-position: 27148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11588

Here are a couple of vdso fixes.  They aren't major problems, but good
to have none the less, I think.

David Daney (2):
  MIPS: Get rid of useless 'init_vdso successfully' message.
  MIPS: Make init_vdso a subsys_initcall.

 arch/mips/kernel/vdso.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)
