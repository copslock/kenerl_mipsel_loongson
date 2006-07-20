Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 16:33:08 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:57511 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133847AbWGTPcz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Jul 2006 16:32:55 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 3071C4654D; Thu, 20 Jul 2006 17:32:54 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G3aVU-00005g-8g; Thu, 20 Jul 2006 16:32:08 +0100
Date:	Thu, 20 Jul 2006 16:32:08 +0100
To:	Gary Smith <gary.smith@3phoenix.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: IDE on Swarm
Message-ID: <20060720153208.GC4350@networkno.de>
References: <000601c6ac09$0c262f30$6dacaac0@3PiGAS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601c6ac09$0c262f30$6dacaac0@3PiGAS>
User-Agent: Mutt/1.5.12-2006-07-14
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Gary Smith wrote:
[snip]
> I am using a BCM91250A evaluation board with a compactflash device connected
> to the onboard IDE controller.  When booting with a Linux 2.4.20 kernel, the
> IDE interface is recognized and the compactflash device is hda.  When
> booting with a Linux 2.6.16.25 kernel, the IDE interface is recognized, but
> no device information is echoed to the console.  I've included output below.
> The message post above mentions that there were problems with the IDE driver
> in Linux 2.6 during the late 2004 time-frame.  I'd like to inquire about the
> current availability of the IDE driver in the kernel.

The SWARM onboard IDE works for me with the appended patch. (Originally from
Peter Horton <pdh@colonel-panic.org>.)


Thiemo

--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -127,6 +127,7 @@ static int __devinit swarm_ide_probe(str
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 	hwif->irq = hwif->hw.irq;
 
+	probe_hwif_init(hwif);
 	dev_set_drvdata(dev, hwif);
 
 	return 0;
