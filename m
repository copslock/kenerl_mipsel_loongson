Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 01:04:46 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1663 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492509Ab0EEXDv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 01:03:51 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4be1f9650002>; Wed, 05 May 2010 16:04:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:23 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 5 May 2010 16:03:23 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o45N3IM9011083;
        Wed, 5 May 2010 16:03:19 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o45N3GFF011082;
        Wed, 5 May 2010 16:03:16 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     netdev@vger.kernel.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/6] netdev: octeon_mgmt: A few fixes for 2.6.35.
Date:   Wed,  5 May 2010 16:03:07 -0700
Message-Id: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 05 May 2010 23:03:23.0864 (UTC) FILETIME=[29CF8580:01CAECA7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The 1/6 corrects a compile error that seems to have crept
in, as well as correcting the dev_addrs/uc snafu.

2/6 - 5/6 are some other small bug fixes.

6/6 just re-formats the code some.

They are relative to commit 0a12761bcd5646691c5d16dd93df84d1b8849285
in net-next-2.6/master

If OK please apply.

Thanks,
David Daney

David Daney (6):
  netdev: octeon_mgmt: Use proper MAC addresses.
  netdev: octeon_mgmt: Fix race condition freeing TX buffers.
  netdev: octeon_mgmt: Fix race manipulating irq bits.
  netdev: octeon_mgmt: Free TX skbufs in a timely manner.
  netdev: octeon_mgmt: Try not to drop TX packets when stopping the
    queue.
  netdev: octeon_mgmt: Remove some gratuitous blank lines.

 drivers/net/octeon/octeon_mgmt.c |   57 ++++++++++++++++++-------------------
 1 files changed, 28 insertions(+), 29 deletions(-)
