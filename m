Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2013 19:37:57 +0100 (CET)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:43512 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824283Ab3KEShyzmF09 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Nov 2013 19:37:54 +0100
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1VdlVM-0001DQ-00; Tue, 05 Nov 2013 18:37:32 +0000
Date:   Tue, 5 Nov 2013 13:37:32 -0500
From:   Rich Felker <dalias@aerifal.cx>
To:     Andreas Barth <aba@ayous.org>
Cc:     "Joseph S. Myers" <joseph@codesourcery.com>,
        David Miller <davem@davemloft.net>, aurelien@aurel32.net,
        linux-mips@linux-mips.org, libc-alpha@sourceware.org
Subject: Re: prlimit64: inconsistencies between kernel and userland
Message-ID: <20131105183732.GB24286@brightrain.aerifal.cx>
References: <20130628133835.GA21839@hall.aurel32.net>
 <20131104213756.GD18700@hall.aurel32.net>
 <20131104.194519.1657797548878784116.davem@davemloft.net>
 <Pine.LNX.4.64.1311050058580.9883@digraph.polyomino.org.uk>
 <20131105012203.GA24286@brightrain.aerifal.cx>
 <20131105085859.GE28240@mails.so.argh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131105085859.GE28240@mails.so.argh.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@aerifal.cx
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

On Tue, Nov 05, 2013 at 09:58:59AM +0100, Andreas Barth wrote:
> * Rich Felker (dalias@aerifal.cx) [131105 02:22]:
> > On Tue, Nov 05, 2013 at 01:04:45AM +0000, Joseph S. Myers wrote:
> > > On Mon, 4 Nov 2013, David Miller wrote:
> > > 
> > > > From: Aurelien Jarno <aurelien@aurel32.net>
> > > > Date: Mon, 4 Nov 2013 22:37:56 +0100
> > > > 
> > > > > Any news about this issue? It really starts to causes a lot of issues in
> > > > > Debian. I have added a Cc: to libc people so that we can also hear their
> > > > > opinion.
> > > > 
> > > > I had the same exact problem on sparc several years ago, I simply fixed
> > > > the glibc header value, it's the only way to fix this.
> > > > 
> > > > Yes, that means you then have to recompile applications and libraries
> > > > that reference this value.
> > > 
> > > Surely you can create new symbol versions for getrlimit64 and setrlimit64, 
> > > with the old versions just using the 32-bit syscalls (or otherwise 
> > > translating between conventions, but using the 32-bit syscalls is the 
> > > simplest approach)?  I see no need to break compatibility with existing 
> > > binaries.
> > > 
> > > As I noted in 
> > > <https://sourceware.org/ml/libc-ports/2006-05/msg00020.html>, at that time 
> > > the value of RLIM64_INFINITY for o32/n32 was purely a glibc convention the 
> > > kernel didn't see at all.  It's only with the use of newer syscalls that 
> > > this glibc convention is any sort of problem.
> > 
> > Why not just make them convert any value >= 0x7fffffffffffffff to
> > infinity before making the syscall? There's certainly no meaningful
> > use for finite values in that range...
> 
> Or just replace 0x7fffffffffffffff by kernels infinity - and still
> fixing glibc, because the same value as the kernel should be the right
> answer long term.

Oh, I agree that change should be made too. I just suggested an
additional fix that could be made to avoid the need for recompiling
and replacing old binaries.

Rich
