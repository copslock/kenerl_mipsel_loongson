Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 01:50:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48841 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817546AbaFWXuHMueg5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 01:50:07 +0200
Date:   Tue, 24 Jun 2014 00:50:07 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Rientjes <rientjes@google.com>
cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Eunbong Song <eunb.song@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: GCC version requirement (was: Re: mips: math-emu: Fix compilation
 error ieee754.c)
In-Reply-To: <alpine.DEB.2.02.1406111427170.27885@chino.kir.corp.google.com>
Message-ID: <alpine.LFD.2.11.1406240032450.23403@eddie.linux-mips.org>
References: <2463243.264261402478691777.JavaMail.weblogic@epml26> <20140611171000.GD26335@linux-mips.org> <alpine.DEB.2.02.1406111427170.27885@chino.kir.corp.google.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40695
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

On Wed, 11 Jun 2014, David Rientjes wrote:

> > > ieee754dp has bitfield member in struct without name. And this
> > > cause compilation error. This patch removes struct in ieee754dp
> > > declaration. So compilation error is fixed.
> > > Signed-off-by: Eunbong Song <eunb.song@samsung.com>
> > 
> > What gcc version are you using?
> > 
> 
> make arch/mips/math-emu/ieee754.o for mips defconfig triggers the 
> following on linux-next 30 times:
> 
> arch/mips/math-emu/ieee754.c:45:2: error: unknown field 'sign' specified in initializer
> arch/mips/math-emu/ieee754.c:45:2: warning: missing braces around initializer
> arch/mips/math-emu/ieee754.c:45:2: warning: (near initialization for '__ieee754dp_spcvals[0].<anonymous>')
> arch/mips/math-emu/ieee754.c:45:2: error: unknown field 'bexp' specified in initializer
> arch/mips/math-emu/ieee754.c:45:2: warning: excess elements in union initializer
> arch/mips/math-emu/ieee754.c:45:2: warning: (near initialization for '__ieee754dp_spcvals[0]')
> arch/mips/math-emu/ieee754.c:45:2: error: unknown field 'mant' specified in initializer
> arch/mips/math-emu/ieee754.c:45:2: warning: excess elements in union initializer
> arch/mips/math-emu/ieee754.c:45:2: warning: (near initialization for '__ieee754dp_spcvals[0]')
> 
> I'm using gcc 4.5.1 for mips.  The patch makes all members part of the 
> union so it's probably not what you want to fix it, though.

 There's more recent breakage like this, e.g.:

mm/page_io.c: In function '__swap_writepage':
mm/page_io.c:277: error: unknown field 'bvec' specified in initializer
mm/page_io.c:278: warning: excess elements in struct initializer
mm/page_io.c:278: warning: (near initialization for 'from')

introduced with "bio_vec-backed iov_iter" (GCC 4.1.2 here).  We still in 
principle support GCC versions back to 3.2:

$ grep 'Gnu C' Documentation/Changes
o  Gnu C                  3.2                     # gcc --version
$ 

so either this breakage has to be cleaned up or the requirement for the 
minimum GCC version revisited.

 This is a semi-standard language extension BTW, citing from the GCC 
manual:

--------------------------------------------------------------------------
6 Extensions to the C Language Family
*************************************

GNU C provides several language features not found in ISO standard C.
(The `-pedantic' option directs GCC to print a warning message if any
of these features is used.)  To test for the availability of these
features in conditional compilation, check for a predefined macro
`__GNUC__', which is always defined under GCC.

6.59 Unnamed struct/union fields within structs/unions
======================================================

As permitted by ISO C11 and for compatibility with other compilers, GCC
allows you to define a structure or union that contains, as fields,
structures and unions without names.
--------------------------------------------------------------------------

-- note the term "permitted" rather than "required".

 We do make use of a few GCC language extensions, most notably inline 
assembly, however in this case we merely save a couple of characters here 
and there and this is IMO not worth breaking people's development 
environments.

  Maciej
