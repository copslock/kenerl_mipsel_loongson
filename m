Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 11:09:36 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54443 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20044619AbWHKKJe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 11:09:34 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.6/8.13.4) with ESMTP id k7BATPZL001123;
	Fri, 11 Aug 2006 11:29:26 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k7BATPgG001122;
	Fri, 11 Aug 2006 11:29:25 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: IDE routines for the ENCM3 in 2.6
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	ashlesha@kenati.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1155252440.7684.20.camel@sandbar.kenati.com>
References: <1155252440.7684.20.camel@sandbar.kenati.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 11 Aug 2006 11:29:24 +0100
Message-Id: <1155292164.24077.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

Ar Iau, 2006-08-10 am 16:27 -0700, ysgrifennodd Ashlesha Shintre:
> Also, it says that probing for the device is taken care of during the
> execution of the pci_register_driver function.  Am I confusing two
> things? 

The existing VIA ide/pci/via82cxxx driver should support any of the
standard IDE components found on VIA southbridges up to and including
the 8237 (8237A should make 2.6.18)

Depending on your MIPS board arrangement you may need your early boot up
code to kick the chip into the right mode and allocate the PCI
resources. You may need the VIA BIOS programmers guide for the relevant
chip but if I remember rightly its all pretty trivial for the VIA.

Alan
