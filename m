Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 01:55:43 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10979 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492529Ab0AGAzj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 01:55:39 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b4531010001>; Wed, 06 Jan 2010 16:55:29 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 6 Jan 2010 16:55:15 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 6 Jan 2010 16:55:15 -0800
Message-ID: <4B4530F3.1070701@caviumnetworks.com>
Date:   Wed, 06 Jan 2010 16:55:15 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Netdev <netdev@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 0/3] Staging: Improvments to Octeon Ethernet driver.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jan 2010 00:55:15.0822 (UTC) FILETIME=[134AC8E0:01CA8F34]
X-archive-position: 25522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4570

These patches attempt to cleanup and improve the octeon-ethernet
driver in staging.  The first patch fixes up octeon interrupt handling
in preparation for the following patches.  The second and third
patches convert to NAPI and enable scatter-gather as well is cleaning
up some ugly garbage.

Since Octeon is a MIPS based SOC, we might want to merge the entire
series via Ralf's linux-mips.org tree.

I will reply with the three patches.

David Daney (3):
   MIPS: Octeon: Fix EIO handling.
   Staging: Octeon Ethernet: Clean up and convert to NAPI.
   Staging: Octeon Ethernet: Enable scatter-gather.

  arch/mips/cavium-octeon/octeon-irq.c      |   40 +++-
  drivers/staging/octeon/Kconfig            |    1 +
  drivers/staging/octeon/ethernet-defines.h |   28 ---
  drivers/staging/octeon/ethernet-mem.c     |   89 +++-----
  drivers/staging/octeon/ethernet-rx.c      |  377 
++++++++++++++++------------
  drivers/staging/octeon/ethernet-rx.h      |   25 ++-
  drivers/staging/octeon/ethernet-tx.c      |  330 ++++++++++++-------------
  drivers/staging/octeon/ethernet-tx.h      |   27 +--
  drivers/staging/octeon/ethernet.c         |  157 +++++--------
  drivers/staging/octeon/octeon-ethernet.h  |   48 +---
  10 files changed, 532 insertions(+), 590 deletions(-)
