Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 17:21:13 +0000 (GMT)
Received: from host-65-122-203-2.quicklogic.com ([IPv6:::ffff:65.122.203.2]:12429
	"EHLO mail.Quicklogic.com") by linux-mips.org with ESMTP
	id <S8225256AbUAMRVK>; Tue, 13 Jan 2004 17:21:10 +0000
Received: from quicklogic.com
	([192.168.1.153])
	by mail.Quicklogic.com; Tue, 13 Jan 2004 09:23:47 -0800
Message-ID: <4004295F.9060104@quicklogic.com>
Date: Tue, 13 Jan 2004 12:22:39 -0500
From: Dan Aizenstros <dan@quicklogic.com>
Organization: QuickLogic Canada
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
References: <20040113080926Z8225270-16706+2387@linux-mips.org>
In-Reply-To: <20040113080926Z8225270-16706+2387@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@quicklogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@quicklogic.com
Precedence: bulk
X-list: linux-mips

Hello,

You broke any build that does not define CONFIG_SERIAL_AU1X00
by adding an #error in the include/asm-mips/serial.h file.

-- Dan A.

ppopov@linux-mips.org wrote:

> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ppopov@ftp.linux-mips.org	04/01/13 08:09:22
> 
> Modified files:
> 	arch/mips      : Kconfig Makefile 
> 	arch/mips/au1000/common: clocks.c dbg_io.c dma.c irq.c pci.c 
> 	                         power.c puts.c reset.c setup.c time.c 
> 	arch/mips/au1000/pb1500: board_setup.c irqmap.c 
> 	arch/mips/configs: pb1500_defconfig 
> 	drivers/net    : au1000_eth.c 
> 	drivers/serial : au1x00_uart.c 
> 	include/asm-mips: serial.h 
> Added files:
> 	include/asm-mips/mach-au1x00: au1000.h au1000_dma.h 
> 	                              au1000_gpio.h au1000_pcmcia.h 
> 	                              au1000_usbdev.h 
> 	include/asm-mips/mach-db1x00: db1x00.h 
> 	include/asm-mips/mach-pb1x00: pb1000.h pb1100.h pb1500.h 
> Removed files:
> 	include/asm-mips: au1000.h au1000_dma.h au1000_gpio.h 
> 	                  au1000_pcmcia.h au1000_usbdev.h db1x00.h 
> 	                  pb1000.h pb1100.h pb1500.h 
> 
> Log message:
> 	- moved .h files to appropriate include/asm-mips/mach-xxxx directories
> 	- fixed .c files to pick up new .h path name
> 	- fixed the serial console
> 
> 
