Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jun 2009 19:06:22 +0200 (CEST)
Received: from mail01d.mail.t-online.hu ([84.2.42.6]:50196 "EHLO
	mail01d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492881AbZFWRGP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Jun 2009 19:06:15 +0200
Received: from [192.168.1.151] (dsl4E5CE34E.pool.t-online.hu [78.92.227.78])
	by mail01d.mail.t-online.hu (Postfix) with ESMTPA id F2F36758B21
	for <linux-mips@linux-mips.org>; Tue, 23 Jun 2009 19:01:04 +0200 (CEST)
Message-ID: <4A410AC7.9070804@sch.bme.hu>
Date:	Tue, 23 Jun 2009 19:03:03 +0200
From:	Robert Hodaszi <mouse1@sch.bme.hu>
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: U-Boot and ramdisk problem
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-mail.t-online.hu-Metrics:	mail01d.mail.t-online.hu 32710; Body=1 Fuz1=1
	Fuz2=1
Return-Path: <mouse1@sch.bme.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mouse1@sch.bme.hu
Precedence: bulk
X-list: linux-mips

Hi,

I'm working on a custom developed Au1200 based board. I'm using the 
U-Boot as bootloader, and the latest 2.6.30 Linux kernel.

To try my setup, I burned the U-Boot into the flash, and it gets the 
kernel (to 0x81000000) and ramdisk image (to 0x81FFFFC0, its header is 
0x40 bytes long) from a TFTP server. I'm using the:

root=/dev/ram

as boot argument. When I call the U-Boot's

bootm 81000000 81FFFFC0

command to load the kernel, the bootloader successfully recognizes both 
images, then starts the kernel. The kernel starts, but it can't find the 
ramdisk image:

Initrd not found or empty

If I call the U-Boot as:

bootm 81000000

and manually set the command line parameters as:

root=/dev/ram rd_start=0x82000000 rd_size=0x191160

it runs perfectly.

As I saw, in the first case, the U-Boot pass the ramdisk parameters to 
the kernel through environment variables (initrd_start and initrd_size). 
But I couldn't find any code in the kernel side, which could process it. 
It knows the memsize and ethaddr environment parameters (the U-Boot sets 
them), but nor the initrd_start and initrd_size, and nor the flash_start 
and flash_size. Is it true, or I'm blind?

Best regards,
Robert Hodaszi
