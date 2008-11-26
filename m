Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 07:51:19 +0000 (GMT)
Received: from [81.2.74.4] ([81.2.74.4]:41357 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23923077AbYKZHvI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2008 07:51:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mAQ7p5df009951;
	Wed, 26 Nov 2008 07:51:05 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mAQ7p4QJ009949;
	Wed, 26 Nov 2008 07:51:04 GMT
Date:	Wed, 26 Nov 2008 07:51:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	LMO <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] Alchemy: cpu feature override constants.
Message-ID: <20081126075103.GA4232@linux-mips.org>
References: <20081125231230.GA10366@roarinelk.homelinux.net> <492C8904.5040202@caviumnetworks.com> <20081126055053.GA12831@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081126055053.GA12831@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 26, 2008 at 06:50:53AM +0100, Manuel Lauss wrote:

> > The probe routines in cpu-probe.c should get at least some of that correct. 
> >  How about just overriding the things that cpu-probe.c doesn't get right?
> 
> CPU detection gets them all right, it's just that somehow GCC does not use
> the information correctly;  i.e. in the __fls() case it blindly falls back
> on the C version instead of using the asm macro with clz in it.  I scanned
> a few callsites of __fls() and there's not 'clz' to be found anywhere.  With
> this addition the clz is used and the binary is a _lot_ smaller.
> 

You should define all values as constants, as far as known.  GCC will
then be able to use constant propagation and dead code elemination to
optimize the code for a particular target system.

The way fls() is written it will only use of CLZ if the expression
cpu_has_mips_r is a constant, that is if the kernel is being built
exclusivly for MIPS32 / MIPS64 revision 1 or higher.  The reason that
__fls is written this way is that both it's legacy and R1 variants using
CLZ/DCLZ the function body will be compiled into something relativly small.
There is not such much point in adding even more code for a runtime
decission between two variants.

> I believe this is a gcc thing, but this seemed to be the obvious quick
> remedy.

GCC does correct.

  Ralf
