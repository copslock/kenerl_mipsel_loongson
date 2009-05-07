Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 May 2009 15:53:27 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37463 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023610AbZEGOxU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 May 2009 15:53:20 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n47ErEcF024855;
	Thu, 7 May 2009 15:53:15 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n47ErDck024854;
	Thu, 7 May 2009 15:53:13 +0100
Date:	Thu, 7 May 2009 15:53:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] SIBYTE: fix locking in set_irq_affinity
Message-ID: <20090507145313.GA14368@linux-mips.org>
References: <20090504215155.461B2E31C1@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090504215155.461B2E31C1@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 04, 2009 at 11:51:54PM +0200, Thomas Bogendoerfer wrote:

> Locking of irq_desc is now done in irq_set_affinity; Don't lock it
> again in chip specific set_affinity function.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Funny locking code, indeed.  I've applied your patch to master and all
-stable branches but I'm holding back on pushing for the moment so
somebody else has a chance to comment.

Thanks,

  Ralf
