Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2003 00:47:51 +0000 (GMT)
Received: from [IPv6:::ffff:24.34.109.122] ([IPv6:::ffff:24.34.109.122]:19976
	"EHLO compaq.parker.boston.ma.us") by linux-mips.org with ESMTP
	id <S8225203AbTKQArT>; Mon, 17 Nov 2003 00:47:19 +0000
Received: from p2.parker.boston.ma.us (p2 [192.245.5.16])
	by compaq.parker.boston.ma.us (8.11.6/8.11.6) with ESMTP id hAH0kZ426174;
	Sun, 16 Nov 2003 19:46:36 -0500
Received: from p2 (brad@localhost)
	by p2.parker.boston.ma.us (8.11.6/8.11.6) with ESMTP id hAH0kZX16327;
	Sun, 16 Nov 2003 19:46:35 -0500
Message-Id: <200311170046.hAH0kZX16327@p2.parker.boston.ma.us>
To: Ralf Baechle <ralf@linux-mips.org>
cc: durai <durai@isofttech.com>, linux-mips@linux-mips.org
Subject: Re: file handling in kernel mode 
In-Reply-To: Message from Ralf Baechle <ralf@linux-mips.org> 
   of "Sun, 16 Nov 2003 23:51:33 +0100." <20031116225133.GA7808@linux-mips.org> 
X-Mailer: MH-E 7.2; nmh 1.0.4; GNU Emacs 20.7.1
Date: Sun, 16 Nov 2003 19:46:35 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Return-Path: <brad@parker.boston.ma.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@parker.boston.ma.us
Precedence: bulk
X-list: linux-mips


>On Sun, Nov 16, 2003 at 02:30:05PM +0530, durai wrote:
>
>> Hello,
>> I need to read a file from a device driver and i wrote a sample driver
>> like this
>> 
>> This kernel mode code which try to read the file until end of file is
>> reached. This code had been is working without any problems in RedHat
>> linux and uClinux.
>> But the same code causes a General Protection Fault in my mips linux.
>> I tested the same code in mips running on uClinux which runs well.
>> what is wrong with mips linux?

Shouldn't someone point out that having a driver read a file is 
very, very wrong and a classic FAQ question?

Perhaps I'm mistaken but this seems to come up once a year on every port
list I'm on.

The "unix way" is to have something in userland feed the data to the
driver.  Things in the kernel should never reach back up into the file
system. It's just not done.

Drivers are passive objects which do the bidding of "managers" which
live in userland.  Add an ioctl to the driver which allows a userland
daemon to feed the microcode/firmware/fpga-data/whatever to the driver
in pieces.

Resist the temptation to put code in the driver to access the file
system.

ps: isn't hotplug already setup to notice when a device comes up and to
have a shell script run?  it's bad enough that the hotplug code runs a
shell script from the kernel.  I can't believe that got through...

(and if you have time, go read the plan 9 design docs.  then ask yourself
what those guys would do :-)

-brad
