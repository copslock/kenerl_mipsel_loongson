Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QCcc214012
	for linux-mips-outgoing; Tue, 26 Feb 2002 04:38:38 -0800
Received: from hotmail.com (f107.law11.hotmail.com [64.4.17.107])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QCcW914009
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 04:38:32 -0800
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Tue, 26 Feb 2002 03:38:27 -0800
Received: from 203.196.146.27 by lw11fd.law11.hotmail.msn.com with HTTP;
	Tue, 26 Feb 2002 11:38:26 GMT
X-Originating-IP: [203.196.146.27]
From: "Samiran S" <samiran13@hotmail.com>
To: linux-mips@oss.sgi.com
Subject: Help about loading the kernel from host PC to board
Date: Tue, 26 Feb 2002 17:08:26 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F107cS6xopZz8QMeGd100009da8@hotmail.com>
X-OriginalArrivalTime: 26 Feb 2002 11:38:27.0223 (UTC) FILETIME=[1B2D4270:01C1BEBA]
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Hi all ,

I had the whole set up of MIPS Malta board with its linux OS ,

1) how can I start Linux on that board ?

I got that monitor program ( YEMMON)

I set the IP addrs. and related things. For loading the linux kernel I am 
using

load tftp://<ipaddrs of host pc>path of vmlinux

then it is not loading that kernel , it is giving some error it is given 
below


YAMON> load tftp://175.150.125.170/home/mipsel/vmlinux
About to load tftp://175.150.125.170/home/mipsel/vmlinux
Press Ctrl-C to break
Error : TFTP READ-REQ ERROR
Diag  : Host returned: ErrorCode = 1, ErrorMsg = File not found
Hint  : Check TFTP-server: file-existence, directory/file-attributes


if any body can help please reply me

thanks
Simun



**** Info cpu ****

Processor Company ID = 0x01 (MIPS Technologies, Inc.)
ProcessorID/revision = 0x80(MIPS 4Kc) / 0x01
Endianness = Little
CPU/Bus frequency =80 MHz / 4 0 MHz
ICACHE size = 16384bytes
ICACHE linesize = 16 bytes
ICACHE associativity= 4-way
DCACHE size = 16384bytes
DCACHE linesize = 16 bytes
DCACHE associativity = 4-way
TLB entries = 16 ~ ~ ~ ~


_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com
