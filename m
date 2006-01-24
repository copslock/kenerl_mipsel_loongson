Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 13:47:55 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:43794 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133479AbWAXNra (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 13:47:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0ODp10R024803;
	Tue, 24 Jan 2006 13:51:01 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0ODp1Pa024793;
	Tue, 24 Jan 2006 13:51:01 GMT
Date:	Tue, 24 Jan 2006 13:51:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Add R14K Support (generic)
Message-ID: <20060124135101.GD3459@linux-mips.org>
References: <20060123230424.GA31197@toucan.gentoo.org> <20060124131741.GA3459@linux-mips.org> <43D62D06.8040602@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D62D06.8040602@gentoo.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 24, 2006 at 08:35:02AM -0500, Kumba wrote:

> >Afaik it's not as trivial as this.  The R14000 has some changes to the FPU
> >which seem to require handling.  I unfortunately know no details.
> 
> My guess is a lot of the R14K and R16K details are still protected.  I 
> can't find any processor manuals on them.  Hopefully, I'll be able to get a 
> hold of an R14K eventually to figure out just how well this patch works 
> (maybe it'll reveal enough to see what the FPU does differently).  If only 
> the prices on eVay drop...

R10000 and R12000 were available on the market.  R14000 was probably more
of a custom chip even though it was also being used in HP systems, I think
that series was called Himalaya.  Probably just nobody bother going through
the necessary documentation etc. process to make it a "real" product.

  Ralf
