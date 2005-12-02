Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 19:42:29 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18187 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133874AbVLBTmK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Dec 2005 19:42:10 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1EiGqn-0007Up-6j; Fri, 02 Dec 2005 19:45:45 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1EiGqd-00036l-VQ; Fri, 02 Dec 2005 19:45:36 +0000
Date:	Fri, 2 Dec 2005 19:45:35 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Pierre Ossman <drzeus@drzeus.cx>
Cc:	Jordan Crouse <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] ALCHEMY:  Add SD support to AU1200 MMC/SD driver
Message-ID: <20051202194534.GB3780@flint.arm.linux.org.uk>
References: <20051202190108.GF28227@cosmic.amd.com> <4390A38A.1010907@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4390A38A.1010907@drzeus.cx>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, Dec 02, 2005 at 08:42:02PM +0100, Pierre Ossman wrote:
> Jordan Crouse wrote:
> > Add SD support to the AU1200 MMC driver.  This can
> > be added post 2.6.15, I'm just sending them out today so the various
> > maintainers can get them queued up. 
> > 
> > Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> > ---
> > 
> >  drivers/mmc/au1xmmc.c |  124 ++++++++++++++++++++++++++++---------------------
> >  1 files changed, 71 insertions(+), 53 deletions(-)
> > 
> 
> Russell is still the maintainer of the MMC layer. :)

Indeed.  Jordan - please send me a copy of the patch.  Thanks.

Note that I agree with Pierre's comments.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
