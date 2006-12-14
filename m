Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Dec 2006 22:51:37 +0000 (GMT)
Received: from mail.engel-kg.com ([212.6.249.86]:33264 "EHLO
	centauri.engel-kg.com") by ftp.linux-mips.org with ESMTP
	id S20039828AbWLNWvd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Dec 2006 22:51:33 +0000
Received: from pogo.engel-kg.com (sirius.engel-kg.com [192.168.3.112])
	by centauri.engel-kg.com (Postfix) with ESMTP id 22A8BB860;
	Thu, 14 Dec 2006 23:51:27 +0100 (CET)
Date:	Thu, 14 Dec 2006 23:47:10 +0100 (CET)
From:	elmar gerdes <elmar.gerdes@engel-kg.com>
To:	linux-usb-devel@lists.sourceforge.net
cc:	linux-mips@linux-mips.org
Subject: Question on UDC driver for the Alchemy Au1550
Message-ID: <20061214234250.Q13369@pogo.engel-kg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <elmar.gerdes@engel-kg.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elmar.gerdes@engel-kg.com
Precedence: bulk
X-list: linux-mips


Hi folks,


to make this short:

   Is anybody working on a UDC driver for the Alchemy Au1550
   (MIPS-based)?

If you are interested in details, please read on:




I'm working with an Au1550-based board and would like to run it as a USB
device.  There have been a few drivers around for Au1xxx-based boards,
but none of them seems to be adequate for this processor (or else I
missed something...):

  a) in the kernel tree: arch/mips/au1000/common/usbdev.c

     This one was for Au1000, Au1100, and Au1500 IIRC.  But it didn't
     even compile for quite some kernel versions and now it has been
     removed from the tree.

  b1) drivers/usb/gadget/au1200udc.c

     This driver hasn't made it (yet) into the kernel tree.  I grabbed it
     from some postings to linux-usb-devel, but it's for the Au1200 (and
     Geode LX companion chip).

  b2) drivers/usb/gadget/amd5536udc.c

     from RMI.  This looks very similar to the au1200udc.c driver.  I
     would consider it a predecessor.


The first driver (usbdev.c) cannot work this way, but the access to
registers and endpoints is like that for the Au1500 which should be
correct for the Au1500, too.  But the Au1550's DMA differs.

The second driver (au1200udc.c / amd5536udc.c) has the same DMA, but the
registers and endpoint stuff are different, and it supports USB 2.0
whereas the Au1550 only supports USB 1.1.

It looks like the Au1550 needs a driver merged from the 2 (or 3) above
drivers.

Is anybody working on that?  Can anybody point me to some projects,
people or other source code that could help me?

Regards,

 	Elmar
