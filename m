Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Nov 2002 03:25:57 +0100 (MET)
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:14258 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S870763AbSK3CZq>; Sat, 30 Nov 2002 03:25:46 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAU2P9412967
	for linux-mips@linux-mips.org; Sat, 30 Nov 2002 03:25:09 +0100
Date: Sat, 30 Nov 2002 03:25:09 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: IP27 support
Message-ID: <20021130032508.C12839@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I've clean up and checked in all the IP27 patches into CVS.  This also fixed
some stuff that was never working before so whatever kernel you may be
running on an IP27, it seems time to try to upgrade.  There still seem to
be some issues with Origin 2000 systems, I'll try to fix that whenever I
get access (serial console and system controller) to an Origin 2000.

Happy hacking,

  Ralf
