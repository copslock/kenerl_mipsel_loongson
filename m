Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 15:50:46 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42662 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S28580643AbXAPPul (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 15:50:41 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.8/8.13.4) with ESMTP id l0GG2Slo007104;
	Tue, 16 Jan 2007 16:02:28 GMT
Date:	Tue, 16 Jan 2007 16:02:27 +0000
From:	Alan <alan@lxorguk.ukuu.org.uk>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Questions on new platform submission
Message-ID: <20070116160227.668f1271@localhost.localdomain>
In-Reply-To: <20070116154503.GA6391@linux-mips.org>
References: <5C1FD43E5F1B824E83985A74F396286E03AD7608@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
	<20070116154503.GA6391@linux-mips.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> > 2. Form previous posts I'm assuming patches for the serial driver (drivers/serial/8250.c) should not go to this list but the serial maintainer. Is this correct?
> 
> Yes - however a cc to the linux-mips list can't harm in case there are
> any issues raised.

There is no serial maintainer, so please send them to linux-kernel and cc
linux-serial to be picked up.

Alan
