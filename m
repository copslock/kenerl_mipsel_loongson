Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2004 05:05:59 +0000 (GMT)
Received: from mail007.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.55]:23528
	"EHLO mail007.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8224945AbUAJFF6>; Sat, 10 Jan 2004 05:05:58 +0000
Received: from korath.adamsrealm.net.au (c210-49-87-133.rochd3.qld.optusnet.com.au [210.49.87.133])
	by mail007.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i0A55rH14308
	for <linux-mips@linux-mips.org>; Sat, 10 Jan 2004 16:05:53 +1100
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: linux-mips@linux-mips.org
Subject: Running Linux on an NCD HMX X-Terminal
Date: Sat, 10 Jan 2004 15:05:04 +1000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101505.04453@korath>
Return-Path: <a.nielsen@optushome.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@optushome.com.au
Precedence: bulk
X-list: linux-mips

Hi,

I've got a few old NCD HMX X-Terminals and I'd like to see if I could get 
Linux running on them.  The reason I ask is that the units boot an ELF image 
over the network, and when running readelf on the image it appears than the 
terminals have an R3000 processor:

$ readelf -h Xncdhmx 
ELF Header:
  Magic:   7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, big endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x40020000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          2625644 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         1
  Size of section headers:           40 (bytes)
  Number of section headers:         7
  Section header string table index: 6

Does anyone know what my chances would be of getting a Linux kernel on it?  I 
found a couple of precompiled MIPS kernel images (one was ELF32 but the other 
was ELF64), however when I tried to boot them the terminal simply said "Load 
address out of range" and aborted.  I was using the precompiled images 
because I really want to know whether it'll work before I go to the trouble 
of installing all the cross-compilation tools.

Any info would be greatly appreciated!

Thanks,
Adam.
