Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 10:59:47 +0100 (BST)
Received: from host36-208-dynamic.8-87-r.retail.telecomitalia.it ([87.8.208.36]:6668
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20023371AbXI1J7j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Sep 2007 10:59:39 +0100
Received: from [192.168.2.51]
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IbCa8-0001a6-S3
	for linux-mips@linux-mips.org; Fri, 28 Sep 2007 11:56:26 +0200
Subject: Tests of 2.6.23-rc8 on SGI O2
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Fri, 28 Sep 2007 11:57:07 +0200
Message-Id: <1190973427.11251.17.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi all,
I compiled and tested the latest kernel (from git) for mips on an SGI
O2, in order to check if it fixes a few problems my current kernel has.

The first problem is that a PCI board with a PCI-to-PCI bridge is not
correctly managed. The second problem is the CONFIG_BUILD_ELF64 options
that made all new kernels since 2.6.20 unbootable.

Of course unsetting CONFIG_BUILD_ELF64 worked, and the new kernel booted
correctly.

About the first problem, once the machine booted, the lspci command stil
does not list the available devices on the board. The only listed device
is the PCI bridge.

The relevant parts in syslog are these lines

[...]
Sep 29 00:42:49 sgi kernel: SCSI subsystem initialized
Sep 29 00:42:49 sgi kernel: PCI: Bridge: 0000:00:03.0
Sep 29 00:42:49 sgi kernel:   IO window: disabled.
Sep 29 00:42:49 sgi kernel:   MEM window: disabled.
Sep 29 00:42:49 sgi kernel:   PREFETCH window: disabled.
Sep 29 00:42:49 sgi kernel: PCI: Setting latency timer of device 0000:00:03.0 to 64
Sep 29 00:42:49 sgi kernel: Time: MIPS clocksource has been installed.
Sep 29 00:42:49 sgi kernel: NET: Registered protocol family 2
[...]

Is this a normal behaviour? Should/can I "enable" these windows in any
way?

I also noticed two new problems in this kernel:
A. the connection via an e100 network board is *really* slow: an ssh
connection with public keys take about 40 seconds before the prompt
appear.
B. recompiling with 8mb of frame buffer give an unusable display and
fill my syslog of these messages:
[...]
Sep 27 08:59:18 sgi kernel: CRIME memory error at 0x1800ace0 ST 0x02010000<INV,GBE,NONFATAL>
Sep 27 08:59:18 sgi kernel: CRIME memory error at 0x1800c8e0 ST 0x02010000<INV,GBE,NONFATAL>
Sep 27 08:59:18 sgi kernel: CRIME memory error at 0x1800e4e0 ST 0x02010000<INV,GBE,NONFATAL>
[...]

Thanks a lot,
Giuseppe
