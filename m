Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7PAK1F07432
	for linux-mips-outgoing; Sat, 25 Aug 2001 03:20:01 -0700
Received: from ns1.connectfree.co.uk (ns1.connectfree.co.uk [212.1.130.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7PAJvd07427
	for <linux-mips@oss.sgi.com>; Sat, 25 Aug 2001 03:19:57 -0700
Received: from [212.1.137.100] (helo=linux)
	by ns1.connectfree.co.uk with smtp (Exim 3.22 #1)
	id 15aabV-0008QC-00
	for linux-mips@oss.sgi.com; Sat, 25 Aug 2001 11:23:49 +0100
Content-Type: text/plain;
  charset="iso-8859-15"
From: Ben Hague <benhague@btinternet.com>
To: linux-mips@oss.sgi.com
Subject: Kernel compilation problem
Date: Sat, 25 Aug 2001 12:18:59 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0108251218590B.00738@linux>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
  I'm trying to compile the latest CVS kernel for a Philips Nino 300, and I 
keep getting the error;
make[3]: Entering directory `/home/ben/pdalinux/linux/drivers/char'
mipsel-linux-gcc -I /home/ben/pdalinux/linux/include/asm/gcc -D__KERNEL__ 
-I/home/ben/pdalinux/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls 
-fno-pic -mcpu=r3000 -mips1 -pipe    -c -o serial_tx3912.o serial_tx3912.c
In file included from serial_tx3912.h:14,
                 from serial_tx3912.c:32:
/home/ben/pdalinux/linux/include/linux/serialP.h:50: field `icount' has 
incomplete type
In file included from serial_tx3912.h:15,
                 from serial_tx3912.c:32:
/home/ben/pdalinux/linux/include/linux/generic_serial.h:29: warning: `struct 
serial_struct' declared inside parameter list
/home/ben/pdalinux/linux/include/linux/generic_serial.h:29: warning: its 
scope is only this definition or declaration,
/home/ben/pdalinux/linux/include/linux/generic_serial.h:29: warning: which is 
probably not what you want.
/home/ben/pdalinux/linux/include/linux/generic_serial.h:100: warning: `struct 
serial_struct' declared inside parameter list
/home/ben/pdalinux/linux/include/linux/generic_serial.h:101: warning: `struct 
serial_struct' declared inside parameter list
In file included from serial_tx3912.c:32:
serial_tx3912.h:88: field `icount' has incomplete type
serial_tx3912.c: In function `transmit_char_pio':
serial_tx3912.c:189: `SERIAL_XMIT_SIZE' undeclared (first use in this 
function)
serial_tx3912.c:189: (Each undeclared identifier is reported only once
serial_tx3912.c:189: for each function it appears in.)
serial_tx3912.c: In function `rs_open':
serial_tx3912.c:605: `ASYNC_SPLIT_TERMIOS' undeclared (first use in this 
function)
serial_tx3912.c: In function `rs_ioctl':
serial_tx3912.c:675: sizeof applied to an incomplete type
serial_tx3912.c:676: warning: passing arg 2 of `gs_getserial' from 
incompatible pointer type
serial_tx3912.c:680: sizeof applied to an incomplete type
serial_tx3912.c:681: warning: passing arg 2 of `gs_setserial' from 
incompatible pointer type
make[3]: *** [serial_tx3912.o] Error 1
make[3]: Leaving directory `/home/ben/pdalinux/linux/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/ben/pdalinux/linux/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/home/ben/pdalinux/linux/drivers'
make: *** [_dir_drivers] Error 2

Am I doing something wrong, or is there a bug in the CVS sources?
Thanks
Ben Hague
