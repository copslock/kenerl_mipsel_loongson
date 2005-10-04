Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 01:01:16 +0100 (BST)
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:13051 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S3465664AbVJDAAu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Oct 2005 01:00:50 +0100
Received: from buzz (c-67-171-115-157.hsd1.ut.comcast.net[67.171.115.157])
          by comcast.net (rwcrmhc13) with SMTP
          id <2005100400003901500b6fere>; Tue, 4 Oct 2005 00:00:40 +0000
From:	"Kyle Unice" <unixe@comcast.net>
To:	<linux-mips@linux-mips.org>
Subject: Au1550 Serial port - linux-2.6.13.2
Date:	Mon, 3 Oct 2005 18:00:30 -0600
Message-ID: <000f01c5c876$a2b78740$0400a8c0@buzz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <unixe@comcast.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: unixe@comcast.net
Precedence: bulk
X-list: linux-mips

I have configured linux-2.6.13.2 for a db1550_defconfig build.  When I
compile it, I get this error when compiling au1x00_uart.c:
  LD      usr/built-in.o
  HOSTCC  drivers/pci/gen-devlist
  DEVLIST drivers/pci/devlist.h
  CC      drivers/pci/names.o
In file included from include/linux/mm.h:36,
                 from include/asm/pci.h:10,
                 from include/linux/pci.h:919,
                 from drivers/pci/names.c:11:
include/asm/pgtable.h: In function `io_remap_pfn_range':
include/asm/pgtable.h:377: warning: unused variable `phys_addr_high'
  LD      drivers/pci/built-in.o
  CC      drivers/serial/au1x00_uart.o
drivers/serial/au1x00_uart.c:72: error: `AU1000_UART0_INT' undeclared here
(not
in a function)
drivers/serial/au1x00_uart.c:72: error: initializer element is not constant
drivers/serial/au1x00_uart.c:72: error: (near initialization for
`old_serial_por
t[0].irq')
drivers/serial/au1x00_uart.c:75: error: initializer element is not constant
drivers/serial/au1x00_uart.c:75: error: (near initialization for
`old_serial_por
t[0]')
drivers/serial/au1x00_uart.c:78: error: `AU1000_UART1_INT' undeclared here
(not
in a function)
drivers/serial/au1x00_uart.c:78: error: initializer element is not constant
drivers/serial/au1x00_uart.c:78: error: (near initialization for
`old_serial_por
t[1].irq')
drivers/serial/au1x00_uart.c:81: error: initializer element is not constant
drivers/serial/au1x00_uart.c:81: error: (near initialization for
`old_serial_por
t[1]')
drivers/serial/au1x00_uart.c:84: error: `UART2_ADDR' undeclared here (not in
a f
unction)
drivers/serial/au1x00_uart.c:84: error: initializer element is not constant
drivers/serial/au1x00_uart.c:84: error: (near initialization for
`old_serial_por
t[2].iomem_base')
drivers/serial/au1x00_uart.c:85: error: `AU1000_UART2_INT' undeclared here
(not
in a function)
drivers/serial/au1x00_uart.c:85: error: initializer element is not constant
drivers/serial/au1x00_uart.c:85: error: (near initialization for
`old_serial_por
t[2].irq')
drivers/serial/au1x00_uart.c:88: error: initializer element is not constant
drivers/serial/au1x00_uart.c:88: error: (near initialization for
`old_serial_por
t[2]')
drivers/serial/au1x00_uart.c:92: error: `AU1000_UART3_INT' undeclared here
(not
in a function)
drivers/serial/au1x00_uart.c:92: error: initializer element is not constant
drivers/serial/au1x00_uart.c:92: error: (near initialization for
`old_serial_por
t[3].irq')
drivers/serial/au1x00_uart.c:95: error: initializer element is not constant
drivers/serial/au1x00_uart.c:95: error: (near initialization for
`old_serial_por
t[3]')
make[2]: *** [drivers/serial/au1x00_uart.o] Error 1
make[1]: *** [drivers/serial] Error 2
make: *** [drivers] Error 2

Kyle@buzz /usr/src/linux-2.6.13.2
$ 
