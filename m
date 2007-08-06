Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 19:17:09 +0100 (BST)
Received: from nbd.name ([88.198.39.176]:49351 "EHLO ds10.mine.nu")
	by ftp.linux-mips.org with ESMTP id S20021633AbXHFSRG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 19:17:06 +0100
Received: from e177167218.adsl.alicedsl.de ([85.177.167.218] helo=dhcp-242.hh.ccc.de)
	by ds10.mine.nu with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nbd@openwrt.org>)
	id 1II76m-0005Q2-5k; Mon, 06 Aug 2007 20:15:12 +0200
Message-ID: <46B764D3.2030402@openwrt.org>
Date:	Mon, 06 Aug 2007 20:13:39 +0200
From:	Felix Fietkau <nbd@openwrt.org>
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
MIME-Version: 1.0
To:	Michael Buesch <mb@bu3sch.de>
CC:	Aurelien Jarno <aurelien@aurel32.net>,
	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: Re: [PATCH -mm 3/4] MIPS: Add BCM947XX to Kconfig
References: <20070806150931.GH24308@hall.aurel32.net> <200708062009.14971.mb@bu3sch.de>
In-Reply-To: <200708062009.14971.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <nbd@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
Precedence: bulk
X-list: linux-mips

Michael Buesch wrote:

> Shouldn't we leave the PCICORE an option instead of force selecting
> it here?
> My WRT54G doesn't have a (usable) PCI core. So it would work
> without the driver for it.
> Especially on the small WAP54G disabling PCIcore support could
> be useful to reduce the kernel size.
Yeah, leave it as an option, but I think a 'default y if BCM947XX' on
the PCICORE option would be reasonable, since many 47xx devices do have pci.

- Felix
