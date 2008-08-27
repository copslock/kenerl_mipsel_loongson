Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2008 22:40:36 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:35213 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20032451AbYH0Vke (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2008 22:40:34 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KYSki-0007rN-00; Wed, 27 Aug 2008 23:40:32 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 1E60CDE390; Wed, 27 Aug 2008 23:40:21 +0200 (CEST)
Date:	Wed, 27 Aug 2008 23:40:21 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove never used pci_probe variable
Message-ID: <20080827214021.GA12542@alpha.franken.de>
References: <20080419.003435.26096353.anemo@mba.ocn.ne.jp> <20080708.011426.08077033.anemo@mba.ocn.ne.jp> <20080827091935.GA28714@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080827091935.GA28714@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Aug 27, 2008 at 10:19:35AM +0100, Ralf Baechle wrote:
> I think real problem here is that we have two variables which both serve the
> same purpose, pci_probe_only and pci_probe, no?  Not entirely sure here
> because the alpha defines:
> 
> arch/alpha/include/asm/pci.h:#define pcibios_assign_all_busses()        1
> 
> yet it has pci_probe_only ...

as I found no code overwriting pci_probe under arch/mips, we could
remove pci_probe and use the same #define as alpha does.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
