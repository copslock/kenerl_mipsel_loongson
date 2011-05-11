Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2011 22:22:48 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17640 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491144Ab1EKUWl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2011 22:22:41 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dcaf04c0000>; Wed, 11 May 2011 13:23:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 11 May 2011 13:22:38 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 11 May 2011 13:22:37 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p4BKMUbt032641;
        Wed, 11 May 2011 13:22:30 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p4BKMTmR032640;
        Wed, 11 May 2011 13:22:29 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 0/3] MIPS: lantiq: Fix build problems on linux-queue.
Date:   Wed, 11 May 2011 13:22:24 -0700
Message-Id: <1305145347-32605-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 11 May 2011 20:22:37.0870 (UTC) FILETIME=[2B9AE4E0:01CC1019]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

These patches fix three problems I encountered building a kernel for
the lantiq platform.

David Daney (3):
  MIPS: lantiq: Add missing include to mach-easy50712.c
  MIPS: lantiq: Fix section mismatch in gpio_stp.c
  MIPS: lantiq: Check return value from strict_strtoul().

 arch/mips/lantiq/setup.c               |    3 ++-
 arch/mips/lantiq/xway/gpio_stp.c       |    2 +-
 arch/mips/lantiq/xway/mach-easy50712.c |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

Cc: John Crispin <blogic@openwrt.org>
-- 
1.7.2.3
