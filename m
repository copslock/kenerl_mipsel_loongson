Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 04:51:39 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:31150 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8226113AbVGADvV>;
	Fri, 1 Jul 2005 04:51:21 +0100
Received: from drow by nevyn.them.org with local (Exim 4.51)
	id 1DoCYT-0002VU-L9; Thu, 30 Jun 2005 23:51:05 -0400
Date:	Thu, 30 Jun 2005 23:51:05 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	'Linux/MIPS Development' <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
Message-ID: <20050701035105.GA9601@nevyn.them.org>
References: <20050630173409Z8226102-3678+735@linux-mips.org> <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org> <42C46D85.9050104@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C46D85.9050104@gentoo.org>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 30, 2005 at 06:09:09PM -0400, Stephen P. Becker wrote:
> 
> > Bryan seems to be using the original Red Hat gnupro 64-bit toolchain. 
> > I don't know how well that works nowadays; but current CVS versions do
> > work, or did when I last tested (a month or two ago).
> > 
> 
> Hmm, well with respect to my problem, I'm using a pretty recent
> toolchain, with gcc 3.4.4, binutils-2.16.1, glibc-2.3.5, and headers
> from a linux-mips 2.6.11 snapshot.  Interestingly, I tried to reproduce
> Bryan's segfault, but could not.  That code ran without error when I
> linked with libpthread.  Any thoughts?

I don't think glibc 2.3.5 worked for mips64.  But I haven't checked it
in a long time.  Try CVS HEAD of glibc instead.

Other than that, you're on your own - building glibc is extremely error
prone.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
