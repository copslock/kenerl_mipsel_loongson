Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 13:49:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59412 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006855AbaHZLt00a0-u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Aug 2014 13:49:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7QBnP9F024263;
        Tue, 26 Aug 2014 13:49:25 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7QBnPfO024262;
        Tue, 26 Aug 2014 13:49:25 +0200
Date:   Tue, 26 Aug 2014 13:49:25 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: 16k or 64k PAGE_SIZE and "illegal instruction" (signal -4) errors
Message-ID: <20140826114925.GA24146@linux-mips.org>
References: <53FC5300.4070902@gentoo.org>
 <20140826102004.GA22221@linux-mips.org>
 <alpine.LFD.2.11.1408261126000.18483@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.11.1408261126000.18483@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Aug 26, 2014 at 11:42:30AM +0100, Maciej W. Rozycki wrote:

> > > I cannot reproduce it on demand, so I'm not really sure what the cause could
> > > be.  PAGE_SIZE should be largely transparent to userland these days, so I am
> > > wondering if this might be more oddities w/ an R14000 CPU.
> > 
> > This sound very unlikely as the CPU was primarily designed to run IRIX and
> > SGI's systems were using 16k or even 64k page size.
> > 
> > What userland are you running and how old is it?  Are you seeing different
> > results for 16k and 64k?
> 
>  FWIW, I've been always using the 16k page size exclusively with my 64-bit 
> userland and my SWARM board using the SB-1/BCM1250 processor (with either 
> endianness) and never had issues even with stuff as intensive as native 
> GCC bootstrapping (with all the languages enabled such as Ada and Java) or 
> glibc builds.  It's been like 8 years now and quite recent kernels like 
> from two months ago gave me no trouble either.  So it must be something 
> specific to the configuration, my first candidates to look at would be the 
> generated TLB and cache handlers, that are system-specific.

Generally the R10000 architecture is such that there is much less potencial
for software bugs as well.  The TLB is nice, cleans up conflicting entries
so no TLB shutdown or similar horrors possible.  And the caches while they
suffer from cache aliases, will cleanup those aliases transparently to
software, that is an OS can treat them as non-aliasing.  R10000 systems
with the notable exception of the SGI O2 and Indigo² R10000 have fully
coherent I/O.  Basically the only thing that needs to be done in software
is I-cache coherency.  The I-cache snoops stores by remote CPUs but not
by the local CPU itself so in a sense SMP is a simpler case than UP even.

  Ralf
