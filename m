Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 01:37:25 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:63974 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23896990AbYKYBhS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Nov 2008 01:37:18 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492b56b30000>; Mon, 24 Nov 2008 20:36:51 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Nov 2008 17:36:49 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Nov 2008 17:36:48 -0800
Message-ID: <492B56B0.9030409@caviumnetworks.com>
Date:	Mon, 24 Nov 2008 17:36:48 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	IDE/ATA development list <linux-ide@vger.kernel.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] libata: Cavium OCTEON SOC Compact Flash driver (v2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2008 01:36:48.0948 (UTC) FILETIME=[48C59F40:01C94E9E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

As part of our efforts to get the Cavium OCTEON processor support
merged (see: http://marc.info/?l=linux-mips&m=122704699515601), I
have a new version of our CF driver for your consideration.

This second version I split into two separate patches.  The first adds
some entries to the ata_timing table in libata-core.  The second is
the driver proper.

I will reply with the two patches.

David Daney (2):
   libata: Add three more columns to the ata_timing table.
   libata: New driver for OCTEON SOC Compact Flash interface (v2).

  drivers/ata/Kconfig          |    9 +
  drivers/ata/Makefile         |    1 +
  drivers/ata/libata-core.c    |   76 ++--
  drivers/ata/pata_octeon_cf.c |  904 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/libata.h       |   14 +-
  5 files changed, 966 insertions(+), 38 deletions(-)
  create mode 100644 drivers/ata/pata_octeon_cf.c
