Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 20:24:57 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2114 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493525AbZHJSYu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2009 20:24:50 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a80655e0000>; Mon, 10 Aug 2009 14:22:24 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Aug 2009 11:21:30 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Aug 2009 11:21:30 -0700
Message-ID: <4A806529.3060609@caviumnetworks.com>
Date:	Mon, 10 Aug 2009 11:21:29 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>
CC:	linux-mips <linux-mips@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] New hardware RNG for Octeon SOCs.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Aug 2009 18:21:30.0174 (UTC) FILETIME=[61C23DE0:01CA19E7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Behold the Random Number Generator driver for Octeon!

The first patch adds some port definitions and the octeon_rng platform
device.  The second is the driver.

I am copying AKPM and Linus as there seems to be no hw_random maintainer.

Since Octeon is a mips port, we might want to merge both patches via
Ralf's tree.

Comments?

David Daney (2):
   MIPS: Octeon:  Add hardware RNG platform device.
   hw_random: Add hardware RNG for Octeon SOCs.

  arch/mips/cavium-octeon/setup.c              |   44 ++++++++
  arch/mips/include/asm/octeon/cvmx-rnm-defs.h |   86 +++++++++++++++
  drivers/char/hw_random/Kconfig               |   13 +++
  drivers/char/hw_random/Makefile              |    1 +
  drivers/char/hw_random/octeon-rng.c          |  146 
++++++++++++++++++++++++++
  5 files changed, 290 insertions(+), 0 deletions(-)
  create mode 100644 arch/mips/include/asm/octeon/cvmx-rnm-defs.h
  create mode 100644 drivers/char/hw_random/octeon-rng.c
