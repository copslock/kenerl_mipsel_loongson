Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 06:20:13 +0100 (BST)
Received: from bay15-f16.bay15.hotmail.com ([IPv6:::ffff:65.54.185.16]:32781
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8224952AbUHTFUG>; Fri, 20 Aug 2004 06:20:06 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 19 Aug 2004 22:19:54 -0700
Received: from 220.247.240.49 by by15fd.bay15.hotmail.msn.com with HTTP;
	Fri, 20 Aug 2004 05:19:53 GMT
X-Originating-IP: [220.247.240.49]
X-Originating-Email: [safiudeen@hotmail.com]
X-Sender: safiudeen@hotmail.com
From: "safiudeen Ts" <safiudeen@hotmail.com>
To: linux-mips@linux-mips.org, ecartis@linux-mips.org
Cc: safiudeen@hotmail.com
Subject: PCMCIA genric sreail or modem support for db1100 bord
Date: Fri, 20 Aug 2004 05:19:53 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY15-F16oYe5yBEwlu0002e857@hotmail.com>
X-OriginalArrivalTime: 20 Aug 2004 05:19:54.0388 (UTC) FILETIME=[53872D40:01C48675]
Return-Path: <safiudeen@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: safiudeen@hotmail.com
Precedence: bulk
X-list: linux-mips

I am trying to make a pcmcia serial card to work with DB 1100 development 
bord mips prcessor mips au1100 runnning on linux 2.4.20
same pcmcia serial card works fine with my laptop running on linux 2.4.20-8

when try with db1100 it look like hanging in close
the test results are as follows

1) when I plug the card, cardmanegr start  it gives thettyS4 at  port 
0xc00703f8 and the irq 34
2) then card manager calls /etc/pcmcia/serial start /dev/ttvS4
   here it try to set the irq with o through the setserial,this give 
"resource busy or unavailable error"
3)I changed /etc/pcmcia/serial so that   setserial in /etc/pcmcia/serial can 
set irq 3
   after this when I remove the card and plug again, same port number and 
irq is set, then
        /etc/pcmcia/serial start /dev/ttvS4 runs , here it wait until press 
enter to return to prompt
4) now I used set seril to see the status out put is this

# setserial -a /dev/ttyS4
/dev/ttyS4, Line 4, UART: 16550, Port: 0xc00703f8, IRQ: 34
        Baud_base: 6188044, close_delay: 50, divisor: 0
        closing_wait: 3000, closing_wait2: infinte
        Flags: spd_normal skip_tes

and I checked /var/run/stab  this is the out put
# cat /var/run/stab
Socket 0: Serial or Modem
0       serial  serial_cs       0       ttyS4   4       68
Socket 1: empty

at this place evry thing look like ok
5) I run a smale serial prot test program it set the boud rate 9600, data 
bit 8 stop bit 1 , no parity
        , open the ttyS4 with the following options O_RDWR | O_NOCTTY | 
O_NONBLOCK
        write teststring of correctors to the ttyS4, and close.
        open and write functions return no error, the write function retunr 
the no. of bit writen correctly
        close function hangs here I connected other side of the serial port 
to a pc and started the minicom here I did'nt get any charecter writen to 
the port

6) I checked there irq usage in /proc/interrupts this is the result
cat /proc/interrupts

# cat /proc/interrupts
           CPU0
  0:      11914    Au1000 Level  serial
  2:          0    Au1000 Level  MMC
  6:          0    Au1000 Level  audio DAC
  7:          0    Au1000 Level  audio ADC
  8:          0    Au1000 Level  EP0 IN WR
  9:          0    Au1000 Level  EP1 IN WR
10:          0    Au1000 Level  EP2 IN WR
22:      22518    Au1000 Level  irda0
23:          0    Au1000 Level  irda0
24:          0  Au1000 Rise Edge  AU1100UDC Req
25:          0  Au1000 Rise Edge  AU1100UDC Sus
26:          0    Au1000 Level  usb-ohci
28:       8155    Au1000 Level  eth0
34:          0    Au1000 Level  serial

ERR:          0

it shows no any interupts happen to 34,
what should be the real problem ? if any one succeded in PCMCIA up with 
db1100 development please can you tell me the way to
configure the kernela and the the importan settings

if anyone succeded in bringing up PCMCIA serial or modem driver serial_cs 
working with this plartform
please help me in this regards

thanx
safiudeen

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail
