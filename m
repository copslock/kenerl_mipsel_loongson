Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Dec 2004 11:28:31 +0000 (GMT)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:54213 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8225208AbULWL2X> convert rfc822-to-8bit;
	Thu, 23 Dec 2004 11:28:23 +0000
Received: from dlep91.itg.ti.com ([157.170.152.55])
	by go4.ext.ti.com (8.13.1/8.13.1) with ESMTP id iBNBS6Pw016109
	for <linux-mips@linux-mips.org>; Thu, 23 Dec 2004 05:28:07 -0600 (CST)
Received: from dbde2k01.ent.ti.com (localhost [127.0.0.1])
	by dlep91.itg.ti.com (8.12.11/8.12.11) with ESMTP id iBNBS4Zh025014
	for <linux-mips@linux-mips.org>; Thu, 23 Dec 2004 05:28:05 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: do_ri exception in Linux (MIPS 4kec)
Date: Thu, 23 Dec 2004 16:58:03 +0530
Message-ID: <F6B01C6242515443BB6E5DDD63AE935F60FFFF@dbde2k01.itg.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: do_ri exception in Linux (MIPS 4kec)
Thread-Index: AcTo4ndcVQfXylhOSkKELqeOO9LJEg==
From: "Nori, Soma Sekhar" <nsekhar@ti.com>
To: <linux-mips@linux-mips.org>
Cc: "Iyer, Suraj" <ssiyer@ti.com>
Return-Path: <nsekhar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsekhar@ti.com
Precedence: bulk
X-list: linux-mips


Hi all, 

We are facing "Reserved Instruction" exception whenever there is any activity on serial console (typing any command) while there is traffic on network. We do not suspect the network/serial driver as the same software has been working on other mips boards. Here is the dump I obtained by calling show_registers(regs) in do_ri. (the original do_ri implementation did not make a register dump but just printed "kernel BUG at traps.c:627!" ).

If there is no activity on serial console, the network works just fine. Console activity without any activity on the network also works fine.

We are using montavista Linux version 2.4.17, gcc version 2.95.3 running on MIPS 4kec.

Here is the dump:
$0 : 00000000 0044def4 000001ac 0000006b 00000000 7fff7c08 00000001 00000000
$8 : 0000fc00 00000001 00000000 941524d0 00004700 00000000 97fc3ea0 7fff7c08
$16: 100048a4 100029d8 100029d8 10003020 00000000 7fff7dc8 10003b60 2d8e2163
$24: 00000001 2ab7bc30                   10008e70 7fff7bf0 04000000 00439e50
Hi : 00000000
Lo : 00000001
epc  : 00439e84    Not tainted
Status: 0000fc13
Cause : 10800028
Process sh (pid: 18, stackpage=97fc2000)
Stack: 00000001 00000000 2abd0ff0 7fff7c28 10008e70 00000000 10008e6c 00000000
       100049a0 0042f188 00000000 100029d8 00000001 00000001 7fff7f04 10008e70
       00427fe4 00427f00 00000000 00000000 10002764 10008e70 10008e70 00000000
       00000000 00000000 10008e70 00422734 00000001 00000001 7fff7f04 10008e70
       10008e70 00000003 10008e70 004315cc 00000001 00000000 10002764 00000000
       10008e70 ...
Call Trace:
Code: 00000000  2421dd48  00220821 <8c220000> 00000000  005c1021  00400008  0000
0000  8f99802c

The epc is not in kernel space and ksymoops did not provide any info. The epc keeps changing to different locations in user space over multiple runs.

I used copy_from_user in do_ri to get the memory contents at and around the memory pointed to by epc and the memory was intact (all valid instructions) at all times.

Any idea on why I am getting do_ri only on console activity + network activity?

Any help in debugging this is greatly appreciated.

Thanks,
Sekhar Nori
