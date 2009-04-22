Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2009 07:19:58 +0100 (BST)
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:22438 "EHLO
	stout.engsoc.carleton.ca") by ftp.linux-mips.org with ESMTP
	id S20029044AbZDVGTv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 07:19:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id 314A55840B0;
	Wed, 22 Apr 2009 02:19:42 -0400 (EDT)
Received: from stout.engsoc.carleton.ca ([127.0.0.1])
	by localhost (stout.engsoc.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b-qhWvWATANB; Wed, 22 Apr 2009 02:19:42 -0400 (EDT)
Received: from mobius.cowpig.ca (cowpig.ca [134.117.69.79])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id 103885840AF;
	Wed, 22 Apr 2009 02:19:42 -0400 (EDT)
Received: by mobius.cowpig.ca (Postfix, from userid 1000)
	id 67B1B16018B; Wed, 22 Apr 2009 02:19:39 -0400 (EDT)
Date:	Wed, 22 Apr 2009 02:19:39 -0400
From:	Philippe Vachon <philippe@cowpig.ca>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Clean up Lemote Loongson 2E Support
Message-ID: <20090422061939.GA1837@cowpig.ca>
References: <20090422055809.GA1821@cowpig.ca> <20090422060951.GA12850@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090422060951.GA12850@linux-mips.org>
User-Agent: Mutt/1.5.9i
Return-Path: <philippe@cowpig.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippe@cowpig.ca
Precedence: bulk
X-list: linux-mips

On Wed, Apr 22, 2009 at 08:09:51AM +0200, Ralf Baechle wrote:
> > +static inline void ls2e_writeb(uint8_t value, phys_addr_t addr)
> > +{
> > +	*(volatile uint8_t *)addr = value;
> 
> So is addr a physical addres or a virtual one?  In the first case you
> can't dereference it, in the latter the type is wrong.
> 
Aha, you caught me. That should be 'unsigned long' as opposed to
phys_addr_t, as the address is a virtual address.

P.
