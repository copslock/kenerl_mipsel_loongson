Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 13:50:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59524 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006854AbaHZLufqyKlc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 13:50:35 +0200
Date:   Tue, 26 Aug 2014 12:50:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     linux-mips@linux-mips.org
Subject: Re: 16k or 64k PAGE_SIZE and "illegal instruction" (signal -4)
 errors
In-Reply-To: <53FC6A50.9090709@gentoo.org>
Message-ID: <alpine.LFD.2.11.1408261240070.18483@eddie.linux-mips.org>
References: <53FC5300.4070902@gentoo.org> <20140826102004.GA22221@linux-mips.org> <53FC6A50.9090709@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42255
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

On Tue, 26 Aug 2014, Joshua Kinard wrote:

> > This sound very unlikely as the CPU was primarily designed to run IRIX and
> > SGI's systems were using 16k or even 64k page size.
> > 
> > What userland are you running and how old is it?  Are you seeing different
> > results for 16k and 64k?
> 
> o32 userland is the primary on both systems.  However, the last SIGILL was
> under the 64k PAGE_SIZE kernel inside of an n32 chroot compiling the 'boost'
> package on the Octane, which I restarted that and it's not complained since.
>  Also got SIGILL on the 16k PAGE_SIZE kernel when I booted 16k PAGE_SIZE the
> first time and ran 'ps'.  Subsequent runs of 'ps' didn't reproduce the
> error.  Also saw SIGILLs in the bootlog of the 16k PAGE_SIZE kernel when
> "rm" was ran once (couldn't reproduce) and when mdadm tried to put one of
> the arrays back together.  Subsequent runs using similar argument lines
> don't reproduce once I got to a root shell.

 Such intermittent failures look to me remarkably like cache coherency 
problems e.g. D$ vs I$.  You can try making cache invalidation harder, 
e.g. tweak all the writeback calls and invalidation calls so that they 
perform their operation on the whole cache rather than the requested range 
only and see if that makes things better.  You may instead tweak the 
suspected calling site too, of course.

  Maciej
