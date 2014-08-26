Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 12:42:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58745 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006860AbaHZKma5tpgT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 12:42:30 +0200
Date:   Tue, 26 Aug 2014 11:42:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: 16k or 64k PAGE_SIZE and "illegal instruction" (signal -4)
 errors
In-Reply-To: <20140826102004.GA22221@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1408261126000.18483@eddie.linux-mips.org>
References: <53FC5300.4070902@gentoo.org> <20140826102004.GA22221@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 26 Aug 2014, Ralf Baechle wrote:

> > I cannot reproduce it on demand, so I'm not really sure what the cause could
> > be.  PAGE_SIZE should be largely transparent to userland these days, so I am
> > wondering if this might be more oddities w/ an R14000 CPU.
> 
> This sound very unlikely as the CPU was primarily designed to run IRIX and
> SGI's systems were using 16k or even 64k page size.
> 
> What userland are you running and how old is it?  Are you seeing different
> results for 16k and 64k?

 FWIW, I've been always using the 16k page size exclusively with my 64-bit 
userland and my SWARM board using the SB-1/BCM1250 processor (with either 
endianness) and never had issues even with stuff as intensive as native 
GCC bootstrapping (with all the languages enabled such as Ada and Java) or 
glibc builds.  It's been like 8 years now and quite recent kernels like 
from two months ago gave me no trouble either.  So it must be something 
specific to the configuration, my first candidates to look at would be the 
generated TLB and cache handlers, that are system-specific.

  Maciej
