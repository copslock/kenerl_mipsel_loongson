Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2009 00:01:01 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7632 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026377AbZEMXAz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2009 00:00:55 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a0b51170002>; Wed, 13 May 2009 19:00:39 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 15:58:00 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 15:58:00 -0700
Message-ID: <4A0B5077.2010600@caviumnetworks.com>
Date:	Wed, 13 May 2009 15:57:59 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] Clean up CP0 hwrena code in traps.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2009 22:58:00.0606 (UTC) FILETIME=[43A983E0:01C9D41E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

There is an ugly #ifdef CONFIG_CPU_CAVIUM_OCTEON in the middle of
traps.c.  We can get rid of it if we add a cpu feature for
implementation dependent hwrena bits.  The first patch adds the
feature macro and the second removes the #ifdef by setting the feature
for Octeon.

I will reply with the two patches.

David Daney (2):
  MIPS: Allow CPU specific overriding of CP0 hwrena impl bits.
  MIPS: Move Cavium CP0 hwrena impl bits to cpu-feature-overrides.h

 arch/mips/include/asm/cpu-features.h               |    4 ++++
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    1 +
 arch/mips/kernel/traps.c                           |    6 +-----
 3 files changed, 6 insertions(+), 5 deletions(-)
