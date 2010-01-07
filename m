Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 20:04:29 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17081 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492464Ab0AGTEZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 20:04:25 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b46302e0002>; Thu, 07 Jan 2010 11:04:14 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 11:03:36 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 11:03:36 -0800
Message-ID: <4B463005.8060505@caviumnetworks.com>
Date:   Thu, 07 Jan 2010 11:03:33 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Netdev <netdev@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 0/7] Staging: Improvments to Octeon Ethernet driver (second
 attempt).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jan 2010 19:03:36.0186 (UTC) FILETIME=[1D5795A0:01CA8FCC]
X-archive-position: 25528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5124

These patches attempt to cleanup and improve the octeon-ethernet
driver in staging.  The first patch fixes up Octeon interrupt handling
in preparation for the following patches.  At David Miller's
suggestion I have factored the changes into many more individual
patches than I had in the first version.

Since Octeon is a MIPS based SOC, we might want to merge the entire
series via Ralf's linux-mips.org tree.

I will reply with the seven patches.

David Daney (7):
   MIPS: Octeon: Fix EIO handling.
   Staging: Octeon Ethernet: Remove unused code.
   Staging: Octeon Ethernet: Fix memory allocation.
   Staging: Octeon Ethernet: Rewrite transmit code.
   Staging: Octeon Ethernet: Convert to NAPI.
   Staging: Octeon Ethernet: Enable scatter-gather.
   Staging: Octeon Ethernet: Use constants from in.h

  arch/mips/cavium-octeon/octeon-irq.c      |   40 +++-
  drivers/staging/octeon/Kconfig            |    1 +
  drivers/staging/octeon/ethernet-defines.h |   31 ---
  drivers/staging/octeon/ethernet-mem.c     |   89 ++-----
  drivers/staging/octeon/ethernet-rx.c      |  377 
++++++++++++++++------------
  drivers/staging/octeon/ethernet-rx.h      |   25 ++-
  drivers/staging/octeon/ethernet-tx.c      |  342 
+++++++++++++-------------
  drivers/staging/octeon/ethernet-tx.h      |   27 +--
  drivers/staging/octeon/ethernet.c         |  155 +++++--------
  drivers/staging/octeon/octeon-ethernet.h  |   48 +---
  10 files changed, 537 insertions(+), 598 deletions(-)
