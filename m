Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 08:08:23 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:50836 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23923373AbYKZIIN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Nov 2008 08:08:13 +0000
Received: (qmail 13687 invoked by uid 1000); 26 Nov 2008 09:08:08 +0100
Date:	Wed, 26 Nov 2008 09:08:08 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	LMO <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] Alchemy: cpu feature override constants.
Message-ID: <20081126080808.GA13230@roarinelk.homelinux.net>
References: <20081125231230.GA10366@roarinelk.homelinux.net> <492C8904.5040202@caviumnetworks.com> <20081126055053.GA12831@roarinelk.homelinux.net> <20081126075103.GA4232@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081126075103.GA4232@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Wed, Nov 26, 2008 at 07:51:04AM +0000, Ralf Baechle wrote:
> On Wed, Nov 26, 2008 at 06:50:53AM +0100, Manuel Lauss wrote:
> 
> > > The probe routines in cpu-probe.c should get at least some of that correct. 
> > >  How about just overriding the things that cpu-probe.c doesn't get right?
> > 
> > CPU detection gets them all right, it's just that somehow GCC does not use
> > the information correctly;  i.e. in the __fls() case it blindly falls back
> > on the C version instead of using the asm macro with clz in it.  I scanned
> > a few callsites of __fls() and there's not 'clz' to be found anywhere.  With
> > this addition the clz is used and the binary is a _lot_ smaller.
> > 
> 
> You should define all values as constants, as far as known.  GCC will
> then be able to use constant propagation and dead code elemination to
> optimize the code for a particular target system.
> 
> The way fls() is written it will only use of CLZ if the expression
> cpu_has_mips_r is a constant, that is if the kernel is being built
> exclusivly for MIPS32 / MIPS64 revision 1 or higher.  The reason that

Ah, so the __builtin_constat_p() is a compiletime check as to whether a
given symbol is a constant or needs to be evaluated at runtime?  That
explains a lot.

Thanks,
	Manuel Lauss
