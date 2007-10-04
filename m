Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 15:32:53 +0100 (BST)
Received: from host191-212-dynamic.8-87-r.retail.telecomitalia.it ([87.8.212.191]:52415
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20025722AbXJDOcp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 15:32:45 +0100
Received: from [81.30.2.2] (helo=[192.168.12.252])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IdRkl-0003ez-5a; Thu, 04 Oct 2007 16:32:41 +0200
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
In-Reply-To: <20071004130318.GC28928@linux-mips.org>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org>
	 <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
	 <20071004130318.GC28928@linux-mips.org>
Content-Type: text/plain
Date:	Thu, 04 Oct 2007 16:33:33 +0200
Message-Id: <1191508413.10050.26.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno gio, 04/10/2007 alle 14.03 +0100, Ralf Baechle ha scritto:
[...]
> (of course this all goes far beyond Giuseppe's patch - but the whole
> ops-mace.c file like so much of the other code in arch/mips/pci isn't
> exactly an example to be copied.
> 
> Ah, one final formality - when sending a patch please add a
> Signed-off-by: line.  See Documentation/SubmittingPatches in the kernel
> tree for what this means.

I'll provide a new patch tomorrow, using inline functions instead of
macros. About the maximum number of PCI buses, I used 1 since the ip32
only have 1 slot. If this maximum value should be changed, please let me
know.

Bye,
Giuseppe
