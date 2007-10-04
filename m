Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 13:49:36 +0100 (BST)
Received: from host191-212-dynamic.8-87-r.retail.telecomitalia.it ([87.8.212.191]:5005
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022483AbXJDMt3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 13:49:29 +0100
Received: from [81.30.2.2] (helo=[192.168.12.252])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IdQ8r-00082W-6M
	for linux-mips@linux-mips.org; Thu, 04 Oct 2007 14:49:27 +0200
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org>
	 <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Date:	Thu, 04 Oct 2007 14:50:19 +0200
Message-Id: <1191502219.10050.16.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Maciej,

Il giorno gio, 04/10/2007 alle 13.27 +0100, Maciej W. Rozycki ha
scritto:
[...]
>  It may be more consistent if you pass just "bus->number".  You may neatly 
> avoid the line wrap above this way too.
> 
>  Have you run your change through `scripts/checkpatch.pl'?

I'll provide a new patch tomorrow.

Thanks,
Giuseppe
