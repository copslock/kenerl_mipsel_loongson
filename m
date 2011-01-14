Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2011 02:55:55 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13502 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492828Ab1ANBzw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jan 2011 02:55:52 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d2fad570000>; Thu, 13 Jan 2011 17:56:39 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 13 Jan 2011 17:55:50 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 13 Jan 2011 17:55:50 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0E1tiJk016160;
        Thu, 13 Jan 2011 17:55:45 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0E1tidV016159;
        Thu, 13 Jan 2011 17:55:44 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] MIPS Octeon named block INITRD support.
Date:   Thu, 13 Jan 2011 17:55:41 -0800
Message-Id: <1294970143-16124-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 14 Jan 2011 01:55:50.0823 (UTC) FILETIME=[2B96EB70:01CBB38E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The first patch adds a little generic support, and the second, the
aforementioned Octeon named block INITRD support.

This set depends on my previous patch adding BOOT_MEM_INIT_RAM
support.

David Daney (2):
  MIPS: Allow for initrd outside of the reserved memory range.
  MIPS: Octeon: Add initrd from named block support.

 arch/mips/cavium-octeon/setup.c  |   30 ++++++++++++++++++++++++++----
 arch/mips/include/asm/bootinfo.h |    1 +
 arch/mips/kernel/setup.c         |   12 ++++++++++--
 3 files changed, 37 insertions(+), 6 deletions(-)

-- 
1.7.2.3
