Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 20:57:52 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:51878 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365972AbZAOU51 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jan 2009 20:57:27 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496fa31b0004>; Thu, 15 Jan 2009 15:56:59 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 12:56:10 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 12:56:10 -0800
Message-ID: <496FA2E9.9030403@caviumnetworks.com>
Date:	Thu, 15 Jan 2009 12:56:09 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	IDE/ATA development list <linux-ide@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] libata: Add OCTEON Compact Flash driver.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2009 20:56:10.0112 (UTC) FILETIME=[B1862800:01C97753]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Greetings ata hackers,

Linus recently merged support for the mips/Octeon cpu.

Please consider adding this driver for the Compact Flash system
present on many of the OCTEON development boards.

This is a two part patch set, the first part adds a new column to the
ata_timing table (for dmack_hold).  This is used by the second patch
which is the driver itself.

I will reply with the two patches.

Thanks,

David Daney (2):
   libata: Add another column to the ata_timing table.
   libata: New driver for OCTEON SOC Compact Flash interface (v6).

  drivers/ata/Kconfig          |    9 +
  drivers/ata/Makefile         |    1 +
  drivers/ata/libata-core.c    |   72 ++--
  drivers/ata/pata_octeon_cf.c |  956 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/libata.h       |    9 +-
  5 files changed, 1009 insertions(+), 38 deletions(-)
  create mode 100644 drivers/ata/pata_octeon_cf.c
