Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 11:45:42 +0100 (BST)
Received: from host51-186.pool80204.interbusiness.it ([IPv6:::ffff:80.204.186.51]:55189
	"EHLO gate.exadron.com") by linux-mips.org with ESMTP
	id <S8225530AbVDRKp2>; Mon, 18 Apr 2005 11:45:28 +0100
Received: from 10.0.10.210 ([10.0.10.210])
	by gate.exadron.com (8.12.7/8.12.7) with ESMTP id j3IAgQjG027120
	for <linux-mips@linux-mips.org>; Mon, 18 Apr 2005 12:42:54 +0200
Subject: Bug detection and correction on Alchemy au1x00_uart.c serial driver
From:	"d.piccolo" <d.piccolo@exadron.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Mon, 18 Apr 2005 13:02:08 +0200
Message-Id: <1113822129.3261.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Return-Path: <d.piccolo@exadron.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: d.piccolo@exadron.com
Precedence: bulk
X-list: linux-mips

Hi Everybody

I've found a bug in the  au1x00_uart.c file in the drivers/serial/
directory of the 2.6.10 linux kernel. There is only possible to change
the speed of the communication but not to update other parameters of the
serial link, like the number of bits involved, stop bits and parity.
  Comparing the code of this source file with the code of the standard
8250 driver (8250.c also present in the same directory) I've found the
problem:  au1x00_uart.c never updates the LCR register  (Line Control
Register) of the serial controller at runtime, it happens only at first
setup. The problem is solved by adding the line

	serial_out(up, UART_LCR, cval);

just before the line 
 
	up->lcr = cval;	  /* Save LCR */

(there is only one position in all the source code where is written
"Save LCR")

I hope it could be useful.
                              David Piccolo


    
