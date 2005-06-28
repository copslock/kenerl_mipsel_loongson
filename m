Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2005 12:21:39 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:25367 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226003AbVF2LVX>; Wed, 29 Jun 2005 12:21:23 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j5TBK44m006922;
	Wed, 29 Jun 2005 12:20:04 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j5SLFx4P002928;
	Tue, 28 Jun 2005 22:15:59 +0100
Date:	Tue, 28 Jun 2005 22:15:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	rolf liu <rolfliu@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: can't find interrupt number under /proc/interrupts for the pci multi-port on db1550
Message-ID: <20050628211559.GA2879@linux-mips.org>
References: <2db32b720506271706201a66fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db32b720506271706201a66fb@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 27, 2005 at 05:06:27PM -0700, rolf liu wrote:

> I am running 2.4.31 on db1550 with a pci multi-port board. the kernel
> starts up ok. but after start-up, I can't find the corresponding
> interrupt number for this board, which is irq 2. I can find the device
> under /proc/devices and /proc/tty/driver, etc. So I am now sure if it
> is working ok. Is there good (simple) method to test this serial port?

Linux will only allocate the interrupt when the interface is actually
opened, just loading the driver doesn't suffice.

  Ralf
