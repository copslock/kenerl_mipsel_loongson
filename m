Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2007 09:34:16 +0100 (BST)
Received: from host23-213-dynamic.8-87-r.retail.telecomitalia.it ([87.8.213.23]:43268
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20025501AbXI3IeI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 30 Sep 2007 09:34:08 +0100
Received: from [192.168.2.51]
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IbuFO-0006Xy-SF
	for linux-mips@linux-mips.org; Sun, 30 Sep 2007 10:33:57 +0200
Subject: Using PCI bridges on sgi-ip32 [was: Re: Tests of 2.6.23-rc8 on SGI
	O2]
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <1190973427.11251.17.camel@scarafaggio>
References: <1190973427.11251.17.camel@scarafaggio>
Content-Type: text/plain
Date:	Sun, 30 Sep 2007 10:34:36 +0200
Message-Id: <1191141276.7160.44.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno ven, 28/09/2007 alle 11.57 +0200, Giuseppe Sacco ha scritto:
[...]
> About the first problem, once the machine booted, the lspci command stil
> does not list the available devices on the board. The only listed device
> is the PCI bridge.
> 
> The relevant parts in syslog are these lines
> 
> [...]
> Sep 29 00:42:49 sgi kernel: SCSI subsystem initialized
> Sep 29 00:42:49 sgi kernel: PCI: Bridge: 0000:00:03.0
> Sep 29 00:42:49 sgi kernel:   IO window: disabled.
> Sep 29 00:42:49 sgi kernel:   MEM window: disabled.
> Sep 29 00:42:49 sgi kernel:   PREFETCH window: disabled.
> Sep 29 00:42:49 sgi kernel: PCI: Setting latency timer of device 0000:00:03.0 to 64
> Sep 29 00:42:49 sgi kernel: Time: MIPS clocksource has been installed.
> Sep 29 00:42:49 sgi kernel: NET: Registered protocol family 2
> [...]

The same board on i386, is recognised this way:

Sep 29 10:15:44 casa kernel: PCI: Bridge: 0000:00:09.0
Sep 29 10:15:44 casa kernel:   IO window: d000-dfff
Sep 29 10:15:44 casa kernel:   MEM window: fb700000-fbcfffff
Sep 29 10:15:44 casa kernel:   PREFETCH window: disabled.
Sep 29 10:15:44 casa kernel: PCI: Setting latency timer of device 0000:00:01.0 to 6

And then, lspci, display all devices:

00:09.0 0604: 9710:9250 (rev 01)
00:09.0 PCI bridge: NetMos Technology Unknown device 9250 (rev 01)
01:08.0 0c03: 1033:0035 (rev 43)
01:08.0 USB Controller: NEC Corporation USB (rev 43)
01:08.1 0c03: 1033:0035 (rev 43)
01:08.1 USB Controller: NEC Corporation USB (rev 43)
01:08.2 0c03: 1033:00e0 (rev 04)
01:08.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
01:09.0 0c00: 11c1:5811 (rev 61)
01:09.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 61)
01:0a.0 0200: 10ec:8169 (rev 10)
01:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10

So, should I debug the PCI controller for ip32 (MACE)? What could be the
problem here? Should I report this kind of problem to a different
mailing list?

Thanks,
Giuseppe
