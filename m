Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2009 10:34:19 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:44733 "EHLO
	chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492443AbZHEIeM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2009 10:34:12 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
	id 9A8FF8488D; Wed,  5 Aug 2009 09:34:11 +0100 (BST)
Date:	Wed, 5 Aug 2009 09:34:11 +0100
From:	Alexander Clouter <alex@digriz.org.uk>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] ar7: register watchdog driver only if enabled in
	hardware configuration
Message-ID: <20090805083411.GD31078@chipmunk>
References: <200908042309.36721.florian@openwrt.org> <62qmk6-g11.ln1@chipmunk.wormnet.eu> <4A79407B.7070604@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A79407B.7070604@ru.mvista.com>
Organization: diGriz
X-URL:	http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <alex@digriz.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Hi,

* Sergei Shtylyov <sshtylyov@ru.mvista.com> [2009-08-05 12:19:07+0400]:
> 
> Hello.
> 
> Alexander Clouter wrote:
> 
> > I think the 'correct' way to do this is:
> > ---
> > void __iomem *bootcr;
> > u32 val;
> > 
> > ...
> > 
> > bootcr = ioremap_nocache(AR7_REGS_DCL, 4);
> > val = *bootcr;
> >   
> 
> Wait, you can't dereference a pointer to void...
> 
bah,
----
val = __raw_readl(bootcr);
----

Cheers

-- 
Alexander Clouter
.sigmonster says: If you keep anything long enough, you can throw it away.
