Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2003 17:03:13 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:30458 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225316AbTLORDN>;
	Mon, 15 Dec 2003 17:03:13 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA26188;
	Mon, 15 Dec 2003 09:03:05 -0800
Subject: Re: PCMCIA on AMD Alchemy Au1100 boards
From: Pete Popov <ppopov@mvista.com>
To: James Cope <jcope@mpc-data.co.uk>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <E3E525EC-2A4C-11D8-AC44-000A959E1510@mpc-data.co.uk>
References: <E3E525EC-2A4C-11D8-AC44-000A959E1510@mpc-data.co.uk>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1071507785.25858.55.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Dec 2003 09:03:05 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-12-09 at 05:37, James Cope wrote:
> Hello,
> 
> I was wondering if anyone here can help. I am trying to get PCMCIA 
> support working on a board that is very much like the AMD DB1100. Can 
> anyone confirm if PCMCIA works on the DB1100? I do not have access to 
> one at the moment.
> 
> I am using the linux_2_4 tagged kernel from CVS with the
> pcmcia-cs-3.1.22 card services package. I have applied the 64bit_pcmcia 
> patch to both the kernel and card services code and I have part of the 
> PCMCIA system running. I can use the `cardctl' utility to detect the 
> presence of PCMCIA cards successfully, however the `cardmgr' daemon 
> fails to bind to a socket.
> 
> I have a SanDisk Compact Flash card that I'm trying to access. cardmgr 
> correctly detects this as an ATA/IDE Fixed Disk and calls `modprobe 
> ide_cs.o' which is loading okay. 

If you get the latest 2.4 kernel, the driver is in drivers/ide/legacy
and it's called "ide-cs", not "ide_cs". What version of 2.4 are you
running?

> cardmgr then reports the error ``get 
> dev info on socket 0 failed: Transport endpoint is not connected'' 
> (ENOTCONN).

Sounds familiar, I think. Sounds like mismatch in the driver name and
the pcmcia config file. If your driver is named ide_cs, the "devinfo"
inside the driver is set to "ide_cs" and that string won't match an
"ide-cs", which is probably what your pcmcia config file has... I'm
guessing.

Pete

> I can supply more detailed logging and status information if needed, 
> but for now I'm wondering if this path has been trodden before? I have 
> searched through the linux-mips mail archive, but I have only been able 
> to confirm the state of Au1500 PCMCIA support.
> 
> Regards,
> 
> James Cope
> 
> 
> 
