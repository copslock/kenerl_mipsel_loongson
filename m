Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2010 02:24:54 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6638 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491851Ab0BQBYr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Feb 2010 02:24:47 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7b454a0000>; Tue, 16 Feb 2010 17:24:26 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 16 Feb 2010 17:24:16 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 16 Feb 2010 17:24:16 -0800
Message-ID: <4B7B4540.1010700@caviumnetworks.com>
Date:   Tue, 16 Feb 2010 17:24:16 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Netdev <netdev@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 0/2] Staging: Clean up octeon Ethernet some.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2010 01:24:16.0486 (UTC) FILETIME=[EBBEC860:01CAAF6F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

These two patches clean up some comments and get rid of the code that
creates a non-standard file in /proc

As with the previous octeon_ethernet patches, these can probably go
via Ralf's linux-mips.org tree.

I will reply with the two patches.

David Daney (2):
   Staging: Octeon: Reformat a bunch of comments.
   Staging: Octeon: Remove /proc/octeon_ethernet_stats

  drivers/staging/octeon/Makefile          |    1 -
  drivers/staging/octeon/ethernet-mdio.c   |    6 +-
  drivers/staging/octeon/ethernet-mem.c    |   16 ++--
  drivers/staging/octeon/ethernet-proc.c   |  144 
------------------------------
  drivers/staging/octeon/ethernet-proc.h   |   29 ------
  drivers/staging/octeon/ethernet-rx.c     |   17 ++--
  drivers/staging/octeon/ethernet-tx.c     |   14 ++--
  drivers/staging/octeon/ethernet-util.h   |   13 +--
  drivers/staging/octeon/ethernet.c        |   46 +++-------
  drivers/staging/octeon/octeon-ethernet.h |    7 --
  10 files changed, 44 insertions(+), 249 deletions(-)
  delete mode 100644 drivers/staging/octeon/ethernet-proc.c
  delete mode 100644 drivers/staging/octeon/ethernet-proc.h
