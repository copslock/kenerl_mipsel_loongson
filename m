Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 20:43:24 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10274 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025846AbZELTnR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 20:43:17 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a09d13f0004>; Tue, 12 May 2009 15:42:55 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 12:40:35 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 12:40:34 -0700
Message-ID: <4A09D0B1.2030305@caviumnetworks.com>
Date:	Tue, 12 May 2009 12:40:33 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/3] Remove 'ehb' instructions from Cavium TLB handlers.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2009 19:40:34.0864 (UTC) FILETIME=[84A2FB00:01C9D339]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The Cavium Octeon CPU never needs the ehb instruction, this patch set
removes it resulting in shorter TLB handler hot paths.

I will reply with the three patches.

David Daney (3):
   MIPS: Allow R2 CPUs to turn off generation of 'ehb' instructions.
   MIPS: Remove execution hazard barriers for Octeon.
   MIPS: Remove dead case label.

  arch/mips/include/asm/cpu-features.h               |    4 ++++
  .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    1 +
  arch/mips/mm/tlbex.c                               |    4 ++--
  3 files changed, 7 insertions(+), 2 deletions(-)
