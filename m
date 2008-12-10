Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2008 23:39:14 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:37706 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24152923AbYLJXjE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Dec 2008 23:39:04 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494053040001>; Wed, 10 Dec 2008 18:38:44 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 15:37:53 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 15:37:53 -0800
Message-ID: <494052D1.10208@caviumnetworks.com>
Date:	Wed, 10 Dec 2008 15:37:53 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	IDE/ATA development list <linux-ide@vger.kernel.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/3] libata: Cavium OCTEON SOC Compact Flash driver (v5)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2008 23:37:53.0567 (UTC) FILETIME=[525CE2F0:01C95B20]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

As part of our efforts to get the Cavium OCTEON processor support
merged (see: http://marc.info/?l=linux-mips&m=122834773330212), we
have this CF driver for your consideration.

This fifth version is split into three separate patches.  The first
adds some entries to the ata_timing table in libata-core.c.  The
Second adds some special handling to ata_pio_need_iordy() for Compact
Flash devices, The final patch is is the driver proper.

I will reply with the three patches.

David Daney (3):
   libata: Add another column to the ata_timing table.
   libata: Add special ata_pio_need_iordy() handling for Compact Flash.
   libata: New driver for OCTEON SOC Compact Flash interface (v5).

  drivers/ata/Kconfig          |    9 +
  drivers/ata/Makefile         |    1 +
  drivers/ata/libata-core.c    |   76 ++--
  drivers/ata/pata_octeon_cf.c |  956 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/libata.h       |   10 +-
  5 files changed, 1014 insertions(+), 38 deletions(-)
  create mode 100644 drivers/ata/pata_octeon_cf.c
