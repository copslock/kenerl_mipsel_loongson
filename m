Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jul 2006 12:17:07 +0100 (BST)
Received: from ip-217-204-115-127.easynet.co.uk ([217.204.115.127]:31498 "EHLO
	apollo.linkchoose.co.uk") by ftp.linux-mips.org with ESMTP
	id S8133531AbWGQLQ6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Jul 2006 12:16:58 +0100
Received: from [10.98.1.127] (helo=galaxy.dga.co.uk)
	by apollo.linkchoose.co.uk with esmtp (Exim 4.60)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1G2R9T-0004QE-9o
	for linux-mips@linux-mips.org; Mon, 17 Jul 2006 12:20:39 +0100
Received: from [10.0.1.63]
	by galaxy.dga.co.uk with esmtp (Exim 4.62)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1G2R5q-0004dH-4T
	for linux-mips@linux-mips.org; Mon, 17 Jul 2006 12:16:54 +0100
From:	David Goodenough <david.goodenough@linkchoose.co.uk>
To:	linux-mips@linux-mips.org
Subject: Looking for help with an IDT RC32434 processor and Chip Select lines
Date:	Mon, 17 Jul 2006 12:16:53 +0100
User-Agent: KMail/1.9.1
Organization: Linkchoose Ltd
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607171216.54317.david.goodenough@linkchoose.co.uk>
Return-Path: <david.goodenough@linkchoose.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.goodenough@linkchoose.co.uk
Precedence: bulk
X-list: linux-mips

I am new to the MIPS world in general and the IDT chips in particular and
I wonder if someone who is familiar with them might be able to spare a few
minutes to help with understanding how this is supposed to work.

I have a board (a RouterBoard 532) which has one of these chips at its
heart and also has a Hynix 64Mb NAND flash chip on it.  I have a patch
which patches things all over the place which adds support for the chip
to a 2.6.17-rc5 kernel, but I want to separate out just the support for
the NAND chip as a patch on its own.  This patch successfully detects
the NAND chip when I load it onto the board. 

When I take just the mods to the drivers/mtd/nand code and add them to
2.6.17 it is as though the NAND chip is never being selected, the manufacturer
and device id for the NAND chip come back as 0xff where with the rc5 patch
they come back as the correct values 0xad and 0x76 respectively.

Having read the IDT documentation I think that all this is controlled by
the Device Control Registers.  The driver seems to expect that the chips is
accessed through DEV2, and in both cases when I boot the system up the values
in these registers are identical, and according to the IDT docs should cause
the chip select line to be raised.  

I can not find anything else that controls the chip select lines, and I do 
not have any hardware monitoring available to me (no oscilloscopes etc) to 
try to see what is happening at the hardware level.

So my first question is whether my assumption that I only have to bother
myself with the DEV2 register is right, or is there another set of switches
that control the chip select lines?

Thanks in advance

David
