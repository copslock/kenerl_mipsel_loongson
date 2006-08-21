Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 16:26:42 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:35048 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20037562AbWHUP0k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 16:26:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7LFQv1L020156;
	Mon, 21 Aug 2006 16:26:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7LFQv1J020155;
	Mon, 21 Aug 2006 16:26:57 +0100
Date:	Mon, 21 Aug 2006 16:26:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] qemu does not have dcache aliases
Message-ID: <20060821152657.GB19600@linux-mips.org>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl> <20060821.225910.108307053.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211612090.17504@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0608211612090.17504@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 21, 2006 at 04:16:21PM +0100, Maciej W. Rozycki wrote:

> > Well, the QEMU cpu has 2-way 2kB dcache... does not have aliasing
> > anyway. :-)
> 
>  I don't think emulating a bigger cache so that we can add aliases should 
> be *that* difficult.  Adding aliases themselves might be a bit trickier, 
> but the gain would certainly justify the hassle, wouldn't it?

The cache lookup for every access would have serious impact on performance.
The question is, is it worth the price?  Would such patches be acceptable
by the upstream qemu maintainers?

  Ralf
