Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2009 07:55:51 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:53190 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21366534AbZBLHzs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Feb 2009 07:55:48 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 5251B8F849D;
	Thu, 12 Feb 2009 08:55:42 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NRG6L6lSFLII; Thu, 12 Feb 2009 08:55:41 +0100 (CET)
Received: from [10.1.1.26] (unknown [192.168.22.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 71F568F849C;
	Thu, 12 Feb 2009 08:55:40 +0100 (CET)
Subject: Re: Au1200 and NAND Flash - K9F1G08U0A -
From:	Frank Neuber <linux-mips@kernelport.de>
To:	borasah@gmail.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <200705192213.12019.borasah@gmail.com>
References: <200705192213.12019.borasah@gmail.com>
Content-Type: text/plain
Date:	Thu, 12 Feb 2009 08:55:37 +0100
Message-Id: <1234425337.12847.124.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <linux-mips@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@kernelport.de
Precedence: bulk
X-list: linux-mips

Hi Bora,
I have the same problem here.
Did you find a solution for this nand large page device.
I tried to copy nand_command_lp from nand_base.c and added the -CE stuff
including disabling interrupts during read.
The result is that I found just one bad block during scan :-). Also
erasing nand seems to be possible (usinf eraseall /dev/mtdX).
But if I write and read back the data (using dd) I get io errors :-(

I found your posting on this list wihout an answer so I hope you was
able to manage the nand stuff.

Kind Regards,
 Frank   

Am Samstag, den 19.05.2007, 22:13 +0300 schrieb borasah@gmail.com:
> Hi,
> 
> We want to use NAND flash on Alchemy Au1200 and have a custom board along with 
> Db1200; so tried it both on our custom board and Db1200 without success.
> (Because Db1200 has a slot we opened it and replaced the original with our 
> part)
> 
> Kernel -> 2.6.20.1. Error messages:
> 
> NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB 3,3V 
> 8-bit)
> Scanning device for bad blocks
> Bad eraseblock 0 at 0x00000000
> Bad eraseblock 1 at 0x00020000
> ...
> Bad eraseblock 1022 at 0x07fc0000
> Bad eraseblock 1023 at 0x07fe0000
> Creating 2 MTD partitions on "NAND 128MiB 3,3V 8-bit":
> 
> It marks all the eraseblocks as BAD. As far as I understand 
> "au1xxx_nand_command" seems doesnt work correctly. Has someone succeded to 
> work with these large block parts in the Au1200/Au1550?
> 
> Thanks...
> 
> --
> Bora SAHIN
