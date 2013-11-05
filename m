Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2013 23:41:22 +0100 (CET)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:43532 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824820Ab3KEWlTy2EJ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Nov 2013 23:41:19 +0100
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1VdpHt-00029i-00; Tue, 05 Nov 2013 22:39:53 +0000
Date:   Tue, 5 Nov 2013 17:39:53 -0500
From:   Rich Felker <dalias@aerifal.cx>
To:     "Joseph S. Myers" <joseph@codesourcery.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Andreas Barth <aba@ayous.org>,
        David Miller <davem@davemloft.net>, aurelien@aurel32.net,
        linux-mips@linux-mips.org, libc-alpha@sourceware.org
Subject: Re: prlimit64: inconsistencies between kernel and userland
Message-ID: <20131105223953.GG24286@brightrain.aerifal.cx>
References: <20130628133835.GA21839@hall.aurel32.net>
 <20131104213756.GD18700@hall.aurel32.net>
 <20131104.194519.1657797548878784116.davem@davemloft.net>
 <Pine.LNX.4.64.1311050058580.9883@digraph.polyomino.org.uk>
 <20131105012203.GA24286@brightrain.aerifal.cx>
 <20131105085859.GE28240@mails.so.argh.org>
 <20131105183732.GB24286@brightrain.aerifal.cx>
 <52793C50.9030300@gmail.com>
 <Pine.LNX.4.64.1311052234420.30260@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1311052234420.30260@digraph.polyomino.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38458
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

On Tue, Nov 05, 2013 at 10:36:24PM +0000, Joseph S. Myers wrote:
> On Tue, 5 Nov 2013, David Daney wrote:
> 
> > Why can't the default version of the functions in question be fixed so that
> > they do the right thing?  That way you wouldn't have to rebuild old binaries.
> > 
> > Do we really need new function versions at all?
> 
> If we change RLIM64_INFINITY to match the kernel, then the right thing for 
> at least getrlimit64 depends on whether it's an old or new binary (for old 
> binaries it should return the old value of RLIM64_INFINITY and for new 
> ones it should return the new value).

BTW, what happens on a distro where -dev packages are separate and the
user compiles with old headers (not having upgraded the dev package)
but new libc.so? :-)

Rich
