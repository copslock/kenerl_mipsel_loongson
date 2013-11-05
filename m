Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2013 01:03:47 +0100 (CET)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:43548 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823083Ab3KFADoploXA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Nov 2013 01:03:44 +0100
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1VdqSf-0002Ly-00; Tue, 05 Nov 2013 23:55:05 +0000
Date:   Tue, 5 Nov 2013 18:55:05 -0500
From:   Rich Felker <dalias@aerifal.cx>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     "Joseph S. Myers" <joseph@codesourcery.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Andreas Barth <aba@ayous.org>,
        David Miller <davem@davemloft.net>, aurelien@aurel32.net,
        linux-mips@linux-mips.org, libc-alpha@sourceware.org
Subject: Re: prlimit64: inconsistencies between kernel and userland
Message-ID: <20131105235505.GK24286@brightrain.aerifal.cx>
References: <20131104213756.GD18700@hall.aurel32.net>
 <20131104.194519.1657797548878784116.davem@davemloft.net>
 <Pine.LNX.4.64.1311050058580.9883@digraph.polyomino.org.uk>
 <20131105012203.GA24286@brightrain.aerifal.cx>
 <20131105085859.GE28240@mails.so.argh.org>
 <20131105183732.GB24286@brightrain.aerifal.cx>
 <52793C50.9030300@gmail.com>
 <Pine.LNX.4.64.1311052234420.30260@digraph.polyomino.org.uk>
 <20131105223953.GG24286@brightrain.aerifal.cx>
 <87ppqez9sh.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ppqez9sh.fsf@igel.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38462
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

On Wed, Nov 06, 2013 at 12:52:14AM +0100, Andreas Schwab wrote:
> Rich Felker <dalias@aerifal.cx> writes:
> 
> > BTW, what happens on a distro where -dev packages are separate and the
> > user compiles with old headers (not having upgraded the dev package)
> > but new libc.so? :-)
> 
> The devel package must either be self-contained or require the matching
> non-devel package.

That doesn't help. The problem is that the non-devel package gets
upgraded and ldconfig re-links the .so to the .so.X.Y.Z for the new
version. Really, the problem is ldconfig. If the .so link were
correctly created by the devel package, rather than by ldconfig, then
the headers and link-time library version would always match.

So, in short, ldconfig considered harmful.

Rich
