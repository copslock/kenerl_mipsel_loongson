Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 11:11:23 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:14746 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133624AbWEDKLN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 11:11:13 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1Fbang-0001gm-00
	for <linux-mips@linux-mips.org>; Thu, 04 May 2006 12:11:12 +0200
Date:	Thu, 4 May 2006 12:11:12 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Physical addresses fix for au1x00 serial driver
Message-ID: <20060504101112.GC19913@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

here:

   http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-au1x00-serial-phys-addr

a little patch (against «linux-2.6.16-stable» branch and tested on
au1100 based board) to fix the addresses specification for the serial
driver. With this patch at boot time we get:

   Serial: 8250/16550 driver $Revision: 1.90 $ 3 ports, IRQ sharing disabled       
   serial8250.7: ttyS0 at MMIO 0x11100000 (irq = 0) is a 16550A                    
   serial8250.7: ttyS1 at MMIO 0x11200000 (irq = 1) is a 16550A                    
   serial8250.7: ttyS2 at MMIO 0x11400000 (irq = 3) is a 16550A                    

and into procfs we read:

   wwpc:~# cat /proc/iomem                                                         
   10100000-10200000 : au1xxx-ohci.0                                               
   10500000-1050ffff : eth-base                                                    
   10520000-10520003 : eth-mac                                                     
   11100000-1110001f : serial                                                      
   11200000-1120001f : serial                                                      
   11400000-1140001f : serial                                                      
   wwpc:~# cat /proc/tty/driver/serial                                             
   serinfo:1.0 driver revision:                                                    
   0: uart:16550A port:11100000 irq:0 tx:3905 rx:39 RTS|CTS|DTR|DSR|CD|RI          
   1: uart:16550A port:11200000 irq:1 tx:0 rx:0 CTS|DSR|CD|RI                      
   2: uart:16550A port:11400000 irq:3 tx:0 rx:0 CTS|DSR|CD|RI                      

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
