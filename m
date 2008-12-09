Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2008 01:44:55 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:50768 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207536AbYLIBnt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Dec 2008 01:43:49 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493dcd300003>; Mon, 08 Dec 2008 20:43:12 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Dec 2008 17:37:47 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Dec 2008 17:37:46 -0800
Message-ID: <493DCBEA.9090007@caviumnetworks.com>
Date:	Mon, 08 Dec 2008 17:37:46 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	IDE/ATA development list <linux-ide@vger.kernel.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/3] libata: Cavium OCTEON SOC Compact Flash driver (v4)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2008 01:37:46.0852 (UTC) FILETIME=[BD119240:01C9599E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

As part of our efforts to get the Cavium OCTEON processor support
merged (see: http://marc.info/?l=linux-mips&m=122834773330212), we
have this CF driver for your consideration.

This version is split into three separate patches.  The first adds
some entries to the ata_timing table in libata-core.  The Second adds
some special handling to ata_pio_need_iordy() for Compact Flash
devices, The final patch is is the driver proper.

I will reply with the three patches.

David Daney (3):
   libata: Add two more columns to the ata_timing table.
   libata: Add special ata_pio_need_iordy() handling for Compact Flash.
   libata: New driver for OCTEON SOC Compact Flash interface (v3).

  drivers/ata/Kconfig          |    9 +
  drivers/ata/Makefile         |    1 +
  drivers/ata/libata-core.c    |   78 ++--
  drivers/ata/pata_octeon_cf.c |  945 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/libata.h       |   12 +-
  5 files changed, 1007 insertions(+), 38 deletions(-)
  create mode 100644 drivers/ata/pata_octeon_cf.c
