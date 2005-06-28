Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 14:48:11 +0100 (BST)
Received: from clock-tower.bc.nu ([IPv6:::ffff:81.2.110.250]:54999 "EHLO
	lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8226047AbVF1Nro>; Tue, 28 Jun 2005 14:47:44 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j5SDifku000534;
	Tue, 28 Jun 2005 14:44:41 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j5SDifcq000533;
	Tue, 28 Jun 2005 14:44:41 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: can't find interrupt number under /proc/interrupts for the pci
	multi-port on db1550
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	rolf liu <rolfliu@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <2db32b720506271706201a66fb@mail.gmail.com>
References: <2db32b720506271706201a66fb@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119966279.32381.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Tue, 28 Jun 2005 14:44:39 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2005-06-28 at 01:06, rolf liu wrote:
> I am running 2.4.31 on db1550 with a pci multi-port board. the kernel
> starts up ok. but after start-up, I can't find the corresponding
> interrupt number for this board, which is irq 2. I can find the device
> under /proc/devices and /proc/tty/driver, etc. So I am now sure if it
> is working ok. Is there good (simple) method to test this serial port?

Do something like

	cat /dev/ttySwhatever

then look at the IRQ list. The interrupt will only be allocated while
the port is in use.
