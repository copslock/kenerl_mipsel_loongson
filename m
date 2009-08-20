Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2009 23:10:11 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:40089 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492863AbZHTVKF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Aug 2009 23:10:05 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a8dbb360000>; Thu, 20 Aug 2009 17:08:09 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Aug 2009 14:07:35 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Aug 2009 14:07:35 -0700
Message-ID: <4A8DBB17.5020301@caviumnetworks.com>
Date:	Thu, 20 Aug 2009 14:07:35 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	ralf@linux-mips.org, mpm@selenic.com, herbert@gondor.apana.org.au
CC:	linux-mips@linux-mips.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] New hardware RNG for Octeon SOCs (v2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Aug 2009 21:07:35.0521 (UTC) FILETIME=[3DB30510:01CA21DA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Based on feedback from AKPM, I have a new revision of the Octeon
hardware RNG driver.

The changes from v1 are minor, just eliminating some bogus casting by
accessing the driver state by embedding struct hwrng in the driver
data, which is now accessed with the container_of() trick.

The first patch adds some port definitions and the octeon_rng platform
device.  The second is the driver.

Since Octeon is a mips port, we might want to merge both patches via
Ralf's linux-mips.org tree.

David Daney (2):
   MIPS: Octeon:  Add hardware RNG platform device.
   hw_random: Add hardware RNG for Octeon SOCs.

  arch/mips/cavium-octeon/setup.c              |   43 ++++++++
  arch/mips/include/asm/octeon/cvmx-rnm-defs.h |   88 +++++++++++++++
  drivers/char/hw_random/Kconfig               |   13 +++
  drivers/char/hw_random/Makefile              |    1 +
  drivers/char/hw_random/octeon-rng.c          |  147 
++++++++++++++++++++++++++
  5 files changed, 292 insertions(+), 0 deletions(-)
  create mode 100644 arch/mips/include/asm/octeon/cvmx-rnm-defs.h
  create mode 100644 drivers/char/hw_random/octeon-rng.c
