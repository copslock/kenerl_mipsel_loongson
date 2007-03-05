Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 12:42:53 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:31460 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037479AbXCEMmw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Mar 2007 12:42:52 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id BF36F3EC9; Mon,  5 Mar 2007 04:42:12 -0800 (PST)
Message-ID: <45EC101D.8050600@ru.mvista.com>
Date:	Mon, 05 Mar 2007 15:42:05 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marco Braga <marco.braga@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux kernel 2.6.20, PCI and hpt266
References: <d459bb380703040427g4a8cad08kd8e3190f7d109c86@mail.gmail.com>
In-Reply-To: <d459bb380703040427g4a8cad08kd8e3190f7d109c86@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marco Braga wrote:

> Hello, I am trying to run kernel 2.6.20 on an Au1500 based board. Versions
> 2.4.x of the kernel are correctly working.

    How could they work I wonder? :-O

> Problem: on the board there is a HighPoint 371N ATA controller. At the

    There's *no* proper support for HPT371N in 2.4.x.

> moment the kernel 2.6.20 boots and runs, but the ATA controller does not
> recognize the IDE disk.

> Details:
> The driver I use is "drivers/ide/pci/hpt266.c". I've already fixed the

    I guess you mean hpt366.c. :-)

> timing problems and PLL configuration that afflict this controller, and
> removed RESOURCE_64BIT to fix problems with the PCI bus on mips and
> resource_size_t casts.

    Erm, does it indeed fix the problem I wonder?

> I've managed to follow the problem to ide-probe.c, in function
> "actual_try_to_identify". It seems that the values read from the ATA
> registers through IO ports are not correct. As every ATA controller, it
> needs 8 bytes in IO port space for Command Block registers, and 4 bytes for
> the Control Block registers. They are mapped by the kernel at:

> 1400-1407 (8 bytes) Command block channel 0
> 1408-140F (8 bytes) Command block channel 1
> 1410-1413 (4 bytes) Control block channel 0
> 1414-1417 (4 bytes) Control block channel 1

> Notice that Highpoint 371N has registers for 2 channel, but the pinout for
> only 1 channel. In fact the first channel is disabled by the driver, so the
> actual registers are in the range 1408-140F and 1414-1417. The first 
> sign of
> the problem is that INB do not read the correct values for the ALTSTATUS
> register. In fact the kernel reports:

> ... probing with STATUS(...) instead of ALTSTATUS(...)

> [as in ide-probe.c, line 290]

> The values read from the ATA registers are completely wrong. The registers
> are accessed through hwif->INB, that are common "inb" functions. This makes
> me suspect that "inX" functions are not working, but I don't know how to
> test this. Notice that the PCI controller configuration space is correctly
> accessed, as I can confirm reading sys/bus/pci/.../config.

    The PCI config. space accesses use completely different meachanism form 
I/O and memory accesses.

> Can you help or suggest me anything?

    Well, I guess I'll try the current kernel on one of my DBAu1x00 boards...

> Thanx!

WBR, Sergei
