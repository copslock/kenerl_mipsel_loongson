Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 11:04:10 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49463 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022560AbZFCKEC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Jun 2009 11:04:02 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n53A3ZnY013806;
	Wed, 3 Jun 2009 11:03:35 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n53A3ZlK013805;
	Wed, 3 Jun 2009 11:03:35 +0100
Date:	Wed, 3 Jun 2009 11:03:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Herbert Xu <herbert@gondor.apana.org.au>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TXx9: Add TX4939 RNG support (v2)
Message-ID: <20090603100335.GB13250@linux-mips.org>
References: <1243954462-18149-2-git-send-email-anemo@mba.ocn.ne.jp> <20090603094454.GB11356@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090603094454.GB11356@gondor.apana.org.au>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 03, 2009 at 07:44:54PM +1000, Herbert Xu wrote:
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Date: Wed, 3 Jun 2009 19:44:54 +1000
> To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, mpm@selenic.com,
> 	linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] TXx9: Add TX4939 RNG support (v2)
> Content-Type: text/plain; charset=us-ascii
> 
> On Tue, Jun 02, 2009 at 11:54:22PM +0900, Atsushi Nemoto wrote:
> > Add platform support for RNG of TX4939 SoC.
> > 
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> Aha, I knew I should have left Ralf take the patch, and this is
> the reason :)
> 
> Rather than having the patches split between the two of us, I'll
> back out the RNG patch from my tree so both of them can go through
> Ralf's MIPS tree.

Ah, got this email just in time before actually dropping the patch as I
said in the other mail so I won't drop it.

Confusion`R`Us ;-)

  Ralf
