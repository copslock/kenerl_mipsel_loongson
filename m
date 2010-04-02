Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2010 03:19:54 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10745 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492102Ab0DBBS6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Apr 2010 03:18:58 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bb5460c0000>; Thu, 01 Apr 2010 18:19:08 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 1 Apr 2010 18:18:05 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 1 Apr 2010 18:18:05 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o321I3Nt012786;
        Thu, 1 Apr 2010 18:18:03 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o321I16M012785;
        Thu, 1 Apr 2010 18:18:01 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Cc:     davem@davemloft.net, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] Fix ethernet driver for Octeon based Movidis hardware
Date:   Thu,  1 Apr 2010 18:17:53 -0700
Message-Id: <1270171075-12741-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 02 Apr 2010 01:18:05.0630 (UTC) FILETIME=[58DFA5E0:01CAD202]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The Movidis X16 bootloader doesn't enable the mdio bus.  The first
patch fixes this by enabling the mdio bus when the driver is
initialized.

Also the addresses of the PHYs was unknown for this device.  The
second patch adds the corresponding PHY addresses.

With both patches applied I can successfully use all eight Ethernet
ports.

Please consider for 2.6.34.  Since Octeon is an embedded MIPS SOC it
is unlikely to break the kernel for any workstations.  Any or all of
these could be considered for merging via Ralf's linux-mips.org tree.

Thanks,

David Daney (2):
  netdev: phy/mdio-octeon: Enable the hardware before using it.
  staging: octeon-ethernet: Use proper phy addresses for Movidis
    hardware.

 drivers/net/phy/mdio-octeon.c              |   10 ++++++++++
 drivers/staging/octeon/cvmx-helper-board.c |    8 ++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)
