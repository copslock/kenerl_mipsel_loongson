Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 15:44:19 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53201 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28580558AbXAPPoS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 15:44:18 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0GFj9d2007253;
	Tue, 16 Jan 2007 15:45:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0GFj3bF007252;
	Tue, 16 Jan 2007 15:45:03 GMT
Date:	Tue, 16 Jan 2007 15:45:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Questions on new platform submission
Message-ID: <20070116154503.GA6391@linux-mips.org>
References: <5C1FD43E5F1B824E83985A74F396286E03AD7608@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C1FD43E5F1B824E83985A74F396286E03AD7608@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 15, 2007 at 12:21:32PM -0800, Marc St-Jean wrote:

> I am about to submit a new platform and have a few questions to attempt the reduce the number of iterations:
> 
> 1. Should I prepare the patches against the linux.git master?

Yes.

> 2. Form previous posts I'm assuming patches for the serial driver (drivers/serial/8250.c) should not go to this list but the serial maintainer. Is this correct?

Yes - however a cc to the linux-mips list can't harm in case there are
any issues raised.

> 3. Same question for USB driver (mostly drivers/usb/host and gadget), should I send to a usb maintainer?

Dito.

  Ralf
