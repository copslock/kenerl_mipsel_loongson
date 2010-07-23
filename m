Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:58:52 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10115 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492567Ab0GWR56 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:57:58 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c49d8400002>; Fri, 23 Jul 2010 10:58:24 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:57:56 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:57:56 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6NHvr4P024456;
        Fri, 23 Jul 2010 10:57:53 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6NHvr7v024455;
        Fri, 23 Jul 2010 10:57:53 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/3] Octeon SMP initialization and HOTPLUG_CPU fixes.
Date:   Fri, 23 Jul 2010 10:57:48 -0700
Message-Id: <1279907871-24419-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 23 Jul 2010 17:57:56.0758 (UTC) FILETIME=[94A35360:01CB2A90]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

These three basically improve arch/mips/cavium-octeon/smp.c.  The
individual patch logs have the details.

David Daney (3):
  MIPS: Octeon: Clean up SMP CPU numbering.
  MIPS: Octeon: Simplify hotcpu_notifier registration.
  MIPS: Octeon: HOTPLUG_CPU fixes.

 arch/mips/cavium-octeon/octeon_boot.h |   16 ++--
 arch/mips/cavium-octeon/smp.c         |  170 ++++++++++++++++----------------
 arch/mips/include/asm/octeon/octeon.h |    2 +
 3 files changed, 96 insertions(+), 92 deletions(-)
