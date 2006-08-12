Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 01:27:41 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:19339 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20045189AbWHLA1h (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2006 01:27:37 +0100
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 628A5E404D;
	Fri, 11 Aug 2006 17:44:16 -0700 (PDT)
Subject: Re: IDE routines for the ENCM3 in 2.6
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1155292164.24077.35.camel@localhost.localdomain>
References: <1155252440.7684.20.camel@sandbar.kenati.com>
	 <1155292164.24077.35.camel@localhost.localdomain>
Content-Type: text/plain
Date:	Fri, 11 Aug 2006 17:33:42 -0700
Message-Id: <1155342822.7759.2.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

On Fri, 2006-08-11 at 11:29 +0100, Alan Cox wrote:
> Ar Iau, 2006-08-10 am 16:27 -0700, ysgrifennodd Ashlesha Shintre:
> > Also, it says that probing for the device is taken care of during the
> > execution of the pci_register_driver function.  Am I confusing two
> > things? 
> 
> The existing VIA ide/pci/via82cxxx driver should support any of the
> standard IDE components found on VIA southbridges up to and including
> the 8237 (8237A should make 2.6.18)
> 
> Depending on your MIPS board arrangement you may need your early boot up
> code to kick the chip into the right mode and allocate the PCI
> resources. You may need the VIA BIOS programmers guide for the relevant
> chip but if I remember rightly its all pretty trivial for the VIA.
> 

Thanks for your inputs Alan.  I m still a bit confused though as to why
its only the IDE routines which need to be written in a separate ide.c
file.  My point is that there are other devices such as serial ports and
floppy disk drives on the Southbridge too, for which there dont seem to
be separate routines in the arch/mips/encm3 directory.

> Alan
> 
> 
