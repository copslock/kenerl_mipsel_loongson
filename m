Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jun 2004 03:42:12 +0100 (BST)
Received: from web16605.mail.tpe.yahoo.com ([IPv6:::ffff:202.1.236.95]:45162
	"HELO web16605.mail.tpe.yahoo.com") by linux-mips.org with SMTP
	id <S8224827AbUFRCmE>; Fri, 18 Jun 2004 03:42:04 +0100
Message-ID: <20040618024155.35970.qmail@web16605.mail.tpe.yahoo.com>
Received: from [61.66.243.2] by web16605.mail.tpe.yahoo.com via HTTP; Fri, 18 Jun 2004 10:41:55 CST
Date: Fri, 18 Jun 2004 10:41:55 +0800 (CST)
From: =?big5?q?jospehchan?= <jospehchan@yahoo.com.tw>
Subject: Re: "No such device" with PCI card
To: linux-mips@linux-mips.org
Cc: jbglaw@lug-owl.de
In-Reply-To: <40CEBB36.1030707@kilimandjaro.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit
Return-Path: <jospehchan@yahoo.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jospehchan@yahoo.com.tw
Precedence: bulk
X-list: linux-mips

Hi Jan-Benedict,
 Thanks. Please refer to the follownig replies. 

- What kind of MIPS system do you use *exactly*? What
board? Which
  kernel version? From where did you get your sources.

>>>The MIPS system is R3000 and uses an ADI Media
Adapter MB.
The kernel is 2.4.16 from the vendor and plus an USB
patch which backported from kernel 2.4.26.


- A USB2.0 card is IMHO driven by the ehci driver, but
I may be wrong.
  I'm not exactly a regular USB user...

>>>Yes, you're right. But the USB2.0 card also can be
driven by usb-uhci if ehci-hcd is not loaded.
In the my problem, I can load the usbcore, but both of
usb-uhci and ehci-hcd can not be loaded. 

- Do you have output of "lspci", "lspci -v", "lspci
-n", "lspci -vn" and
  "lspci -nxxx" at your hand, once from your i386 test
machine, once
  from the MIPS board? Right, those commands mostly
give the same
  output, but each style eases reading for specific
values:)

>>> MIPS
# lspci
00:00.0 Class 0c03: 1106:3038 (rev 61)
# lspci -v
00:00.0 Class 0c03: 1106:3038 (rev 61)
        Subsystem: 1106:3038
        Flags: bus master, medium devsel, latency 22,
IRQ 4
        I/O ports at <ignored>
        Capabilities: [80] Power Management version 2

# lspci -n
00:00.0 Class 0c03: 1106:3038 (rev 61)
# lspci -vn
00:00.0 Class 0c03: 1106:3038 (rev 61)
        Subsystem: 1106:3038
        Flags: bus master, medium devsel, latency 22,
IRQ 4
        I/O ports at <ignored>
        Capabilities: [80] Power Management version 2

# lspci -nxxx
00:00.0 Class 0c03: 1106:3038 (rev 61)
00: 06 11 38 30 47 01 10 02 61 00 03 0c 00 16 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 fc 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 04 01 00 00
40: 40 10 03 00 00 00 00 00 00 08 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 0a 7e 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00


>>> i386 (RH7.2, kernel 2.4.16 plus USB patch from
kernel 2.4.26)
#lspci 
00:14.0 USB Controller: VIA Technologies, Inc. UHCI
USB (rev 61)
00:14.1 USB Controller: VIA Technologies, Inc. UHCI
USB (rev 61)
00:14.2 USB Controller: VIA Technologies, Inc.:
Unknown device 3104 (rev 62)

#lspci -v
00:14.0 USB Controller: VIA Technologies, Inc. UHCI
USB (rev 61) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. UHCI USB
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2

00:14.1 USB Controller: VIA Technologies, Inc. UHCI
USB (rev 61) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. UHCI USB
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at e800 [size=32]
	Capabilities: [80] Power Management version 2

00:14.2 USB Controller: VIA Technologies, Inc.:
Unknown device 3104 (rev 62) (prog-if 20)
	Subsystem: VIA Technologies, Inc.: Unknown device
3104
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at ee003000 (32-bit, non-prefetchable)
[size=256]
	Capabilities: [80] Power Management version 2

#lspci -n 
00:14.0 Class 0c03: 1106:3038 (rev 61)
00:14.1 Class 0c03: 1106:3038 (rev 61)
00:14.2 Class 0c03: 1106:3104 (rev 62)

#lspci -vn
00:14.0 Class 0c03: 1106:3038 (rev 61)
	Subsystem: 1106:3038
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2

00:14.1 Class 0c03: 1106:3038 (rev 61)
	Subsystem: 1106:3038
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at e800 [size=32]
	Capabilities: [80] Power Management version 2

00:14.2 Class 0c03: 1106:3104 (rev 62) (prog-if 20)
	Subsystem: 1106:3104
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at ee003000 (32-bit, non-prefetchable)
[size=256]
	Capabilities: [80] Power Management version 2

#lspci -nxxx
00:14.0 Class 0c03: 1106:3038 (rev 61)
00: 06 11 38 30 07 00 10 02 61 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e4 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 01 00 00
40: 40 10 03 00 00 00 00 00 00 0b 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00

00:14.1 Class 0c03: 1106:3038 (rev 61)
00: 06 11 38 30 07 00 10 02 61 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e8 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00
40: 40 10 03 00 00 00 00 00 00 0b 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00

00:14.2 Class 0c03: 1106:3104 (rev 62)
00: 06 11 04 31 07 00 10 02 62 20 03 0c 08 20 80 00
10: 00 30 00 ee 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 04 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 03 00 00
40: 00 00 03 00 00 00 00 00 a0 20 00 09 00 00 ff ff
50: 00 5a 00 80 00 00 00 00 04 0b 88 88 53 00 00 00
60: 20 20 01 00 00 00 00 00 01 00 00 00 00 00 00 c0
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00


- Does your MOPS board have working on-board PCI
devices? These don't
  neccessarily have a PCI plug as you know them from
add-on cards,
  because they're directly built into the chipset. For
instance, does
  your board have onboard IDE interfaces?
  
  >>>No, the PCI device can not work, such as (Realtek
8139 LAN card, Philips and VIA USB 2.0 card)
  But there is a mini-PCI device seems workable,
because it's driver can be loaded.
  


-----------------------------------------------------------------
Yahoo!奇摩Messenger6.0
信箱搭配即時通, 溝通樂趣無窮! 
http://tw.messenger.yahoo.com/
