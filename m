Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 23:10:26 +0100 (BST)
Received: from c175189.adsl.hansenet.de ([IPv6:::ffff:213.39.175.189]:46348
	"EHLO gruft.cubic.org") by linux-mips.org with ESMTP
	id <S8226290AbVGEWKL>; Tue, 5 Jul 2005 23:10:11 +0100
Received: from cubic.org (starbase [192.168.10.1])
	by gruft.cubic.org (8.12.2/8.12.2) with ESMTP id j65MATm9024571
	for <linux-mips@linux-mips.org>; Wed, 6 Jul 2005 00:10:30 +0200
Message-ID: <42CAFFC4.9070807@cubic.org>
Date:	Tue, 05 Jul 2005 23:46:44 +0200
From:	Michael Stickel <michael@cubic.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: possible serial driver fixup for au1x00 in 2.6?
References: <2db32b720507011756247735d6@mail.gmail.com>	 <1120266383.5987.46.camel@localhost.localdomain> <2db32b72050705124078a48aed@mail.gmail.com>
In-Reply-To: <2db32b72050705124078a48aed@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <michael@cubic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@cubic.org
Precedence: bulk
X-list: linux-mips

rolf liu wrote:

>Pete,
>To try if 8250.c can work under db1550/linux 2.6.12, I turn off the
>au1x00_uart.c config and just compiled in the 8250 support. When I
>boot the kernel, nothing comes up through the console, which should be
>provided by 8250 support, by 8250_early.c?
>
You can't just enable the serial.c (8250). The UARTs for the Au1x00 are 
memory mapped, but are accessed thru the functions au_readx and 
au_writex. If you take a look at the au1x00_uart.c you can see that the 
functions for serial register access contains access to the au1x00 
registers thru au_readl and au_writel. The serial.c does some more 
things, that does not belong to 8250 (and successors), but to the way 
how the chips are attached to the bus. I see the need to write a more 
modular structure:

One 8250.c that does only the serial chip stuff and one module per 
chip-access-method (serial_io.c, serial_pci.c, serial_mm.c, 
serial_au1x00.c, ...). These modules must know how to access the 
registers, but not what they mean. 8250.c does not know how to access 
the registers, but what to do with it.

Thats teamwork.

That could be adopted to more chips that have a registers to access. I 
think about the i8255 3-port io chip or the i8254-CTC and there are many 
more.

There must be a callback for interrupts like it exists for the parallel 
port stuff.

Could look like that:
struct register_access_s
{
  void (*delete_resource) (struct register_access_s *);
  ...
  int (*writel) (struct register_access_s *bus, long reg, u32 value);
  int (*writew) (struct register_access_s *bus, long reg, u16 value);
  int (*writeb) (struct register_access_s *bus, long reg, u8 value);
  ...
  int (*readl) (struct register_access_s *bus, long reg, u32 *value);
  int (*readw) (struct register_access_s *bus, long reg, u16 *value);
  int (*readb) (struct register_access_s *bus, long reg, u8 *value);
  ...
  void *private;
};

struct register_access_s *create_au1x00_register_access (u32 
au1x00_register_address, size_t size, u32 irq);
struct register_access_s *create_io_register_access (u16 io_address, 
size_t size, u32 irq);
struct register_access_s *create_mm_register_access (void *vaddress, 
size_t size, u32 irq);

struct register_access_s *au1x00_uart0_regs = 
create_au1x00_register_access (UART0_ADDR, 8, AU1000_UART0_INT);
struct register_access_s *uart0_regs = create_io_register_access (0x3E0, 
8, 4);

register_8250 (au1x00_uart0_regs, ...);
register_8250 (uart0_regs, ...);

au1x00_uart0_regs->delete_resource (au1x00_uart0_regs);
...
uart3_regs->delete_resource (uart3_regs);

May be a chip can have more than one interrupts and does not have even one.

Michael
