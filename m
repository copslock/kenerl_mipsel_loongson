Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jun 2010 21:15:59 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16165 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492298Ab0FXTPC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jun 2010 21:15:02 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c23aeca0000>; Thu, 24 Jun 2010 12:15:22 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 24 Jun 2010 12:14:59 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 24 Jun 2010 12:14:58 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o5OJEpHJ026345;
        Thu, 24 Jun 2010 12:14:51 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o5OJEprC026344;
        Thu, 24 Jun 2010 12:14:51 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     netdev@vger.kernel.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] Fix some section mismatch errors for Octeon network drivers
Date:   Thu, 24 Jun 2010 12:14:46 -0700
Message-Id: <1277406888-26309-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 24 Jun 2010 19:14:58.0861 (UTC) FILETIME=[89A585D0:01CB13D1]
X-archive-position: 27250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16958

It seems the kernel build system is becoming more rigorous in its
checking of section mismatches.  Please consider these two patches to
correct the problems.

The warnings were not seen under 2.6.34, so one could argue that these
are fixing a regression (although admittedly it a minor one).

David Daney (2):
  netdev: octeon_mgmt: Fix section mismatch errors.
  netdev: mdio-octeon: Fix section mismatch errors.

 drivers/net/octeon/octeon_mgmt.c |    6 +++---
 drivers/net/phy/mdio-octeon.c    |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)
