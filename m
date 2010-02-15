Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 21:12:29 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19937 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492094Ab0BOUMZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 21:12:25 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b79aab00000>; Mon, 15 Feb 2010 12:12:32 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 12:12:22 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 12:12:22 -0800
Message-ID: <4B79AAA6.60005@caviumnetworks.com>
Date:   Mon, 15 Feb 2010 12:12:22 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     ralf.baechle@gmail.com, linux-mips <linux-mips@linux-mips.org>,
        Netdev <netdev@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 0/4] Improvements to octeon_ethernet.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2010 20:12:22.0488 (UTC) FILETIME=[2EEB8D80:01CAAE7B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Here are a couple of improvements to the octeon_ethernet in
drivers/staging/octeon.  The first patch is just cleanup, the rest are
genuine bug fixes.

I will reply with the four patches.

We may want to merge via Ralf's linux-mips.org tree as Octeon is
infact a MIPS based SOC and he has a bunch of other patches queued
there that these depend on.

David Daney (4):
   Staging: octeon: remove unneeded includes
   Staging: Octeon:  Run phy bus accesses on a workqueue.
   MIPS: Octeon: Do proper acknowledgment of CIU timer interrupts.
   Staging: Octeon:  Free transmit SKBs in a timely manner.

  arch/mips/cavium-octeon/octeon-irq.c      |   67 +++++++++++++-
  drivers/staging/octeon/Kconfig            |    1 -
  drivers/staging/octeon/ethernet-defines.h |    5 +-
  drivers/staging/octeon/ethernet-mdio.h    |    1 -
  drivers/staging/octeon/ethernet-rgmii.c   |   56 +++++++++---
  drivers/staging/octeon/ethernet-sgmii.c   |    1 -
  drivers/staging/octeon/ethernet-spi.c     |    1 -
  drivers/staging/octeon/ethernet-tx.c      |  137 
++++++++++++++++++++++------
  drivers/staging/octeon/ethernet-tx.h      |    6 +-
  drivers/staging/octeon/ethernet-xaui.c    |    1 -
  drivers/staging/octeon/ethernet.c         |  141 
++++++++++++++++-------------
  drivers/staging/octeon/octeon-ethernet.h  |   11 ++-
  12 files changed, 303 insertions(+), 125 deletions(-)
