Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2008 23:07:16 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3227 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24152981AbYLEXHM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Dec 2008 23:07:12 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4939b4040000>; Fri, 05 Dec 2008 18:06:44 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 5 Dec 2008 15:06:43 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 5 Dec 2008 15:06:43 -0800
Message-ID: <4939B402.9010004@caviumnetworks.com>
Date:	Fri, 05 Dec 2008 15:06:42 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	IDE/ATA development list <linux-ide@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] libata: Cavium OCTEON SOC Compact Flash driver (v3)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2008 23:06:43.0065 (UTC) FILETIME=[23642E90:01C9572E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

As part of our efforts to get the Cavium OCTEON processor support
merged (see: http://marc.info/?l=linux-mips&m=122834773330212), we
have this CF driver for your consideration.

This version is split into two separate patches.  The first adds
some entries to the ata_timing table in libata-core.  The second is
the driver proper.

I will reply with the two patches.

Thanks,

David Daney (2):
   libata: Add two more columns to the ata_timing table.
   libata: New driver for OCTEON SOC Compact Flash interface (v3).

  drivers/ata/Kconfig          |    9 +
  drivers/ata/Makefile         |    1 +
  drivers/ata/libata-core.c    |   74 ++--
  drivers/ata/pata_octeon_cf.c |  956 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/libata.h       |   12 +-
  5 files changed, 1014 insertions(+), 38 deletions(-)
  create mode 100644 drivers/ata/pata_octeon_cf.c
