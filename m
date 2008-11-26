Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 08:34:47 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:51655 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23924381AbYKZIeh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2008 08:34:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mAQ8YZq5010820;
	Wed, 26 Nov 2008 08:34:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mAQ8YZ2u010818;
	Wed, 26 Nov 2008 08:34:35 GMT
Date:	Wed, 26 Nov 2008 08:34:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	LMO <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] Alchemy: cpu feature override constants.
Message-ID: <20081126083435.GA10716@linux-mips.org>
References: <20081125231230.GA10366@roarinelk.homelinux.net> <492C8904.5040202@caviumnetworks.com> <20081126055053.GA12831@roarinelk.homelinux.net> <20081126075103.GA4232@linux-mips.org> <20081126080808.GA13230@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081126080808.GA13230@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 26, 2008 at 09:08:08AM +0100, Manuel Lauss wrote:

> > then be able to use constant propagation and dead code elemination to
> > optimize the code for a particular target system.
> > 
> > The way fls() is written it will only use of CLZ if the expression
> > cpu_has_mips_r is a constant, that is if the kernel is being built
> > exclusivly for MIPS32 / MIPS64 revision 1 or higher.  The reason that
> 
> Ah, so the __builtin_constat_p() is a compiletime check as to whether a
> given symbol is a constant or needs to be evaluated at runtime?  That
> explains a lot.

Yes.  See GCC documentation.  It's used all over place in the kernel for
optimizations.  In some occasions gcc is not able to determine the
constness of an expression, so the code should better prepared to handle
a 0 return value.  Another interesting property of __buitin_const_p() is
that side effects don't matter, that is for example

  __buitin_const_p(expr) && (expr)

will only execute any sideeffects the expression expr may have once which
is extremly handy in macro.

  Ralf
