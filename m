Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2004 04:12:28 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:26381 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224839AbUJPDMU>; Sat, 16 Oct 2004 04:12:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4D412E1D46; Sat, 16 Oct 2004 05:12:14 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17660-09; Sat, 16 Oct 2004 05:12:14 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 00569E1CC8; Sat, 16 Oct 2004 05:12:14 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9G3CDZE025626;
	Sat, 16 Oct 2004 05:12:14 +0200
Date: Sat, 16 Oct 2004 04:12:13 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Manish Lachwani <mlachwani@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Broadcom SWARM IDE driver
In-Reply-To: <41708A0F.6080504@mvista.com>
Message-ID: <Pine.LNX.4.58L.0410160355270.7266@blysk.ds.pg.gda.pl>
References: <41708A0F.6080504@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 15 Oct 2004, Manish Lachwani wrote:

> +       if (!request_region(0x1f0, 0x2ff, "sibyte-ide"))
> +               printk("could not reserve for the Broadcom SWARM IDE 
> port \n");

 This makes no sense, sorry -- the SWARM IDE interface is not I/O-mapped.  
In fact it's not on PCI at all -- it just occupies the 4th slot of the
BCM1250A's generic bus.  You should reserve the iomem area covering the
slot instead.

 The rest appears sane enough for the current excuse for a driver. ;-)

  Maciej
