Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 15:27:44 +0000 (GMT)
Received: from webmail29.rediffmail.com ([IPv6:::ffff:203.199.83.39]:34470
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8225211AbTBEP1n>; Wed, 5 Feb 2003 15:27:43 +0000
Received: (qmail 1898 invoked by uid 510); 5 Feb 2003 15:33:41 -0000
Date: 5 Feb 2003 15:33:41 -0000
Message-ID: <20030205153341.1897.qmail@webmail29.rediffmail.com>
Received: from unknown (202.88.159.85) by rediffmail.com via HTTP; 05 feb 2003 15:33:41 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: uart 16550 undefined state...
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

A small generic question ..

Have any body experienced undefined state of ns16550A Uart chip , 
especially during REinitialisation..

I get it when i my bootloader uses  uart0 and later after loding 
kernel
through serial link and using in my kernel command line 
console=ttyS0  then in init/main.c ,
  console_init() or open("/dev/console",....) the serial port is 
again
setup via serial_console_setup() or rs_open() like interfaces.
even afer taking care of same baudspeed it just send junk 
characters.

though initialising a uart is extremly simple.only difference 
betwen bootloader and kernel initialization  i can see regarding 
polling/interrupt mode.

if i mask those code in serial.c ..i don't have any problem..
but why it happens, what special sequence of initialisation can 
avoid this problem..

Best Regards,
Atul
