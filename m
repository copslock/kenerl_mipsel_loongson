Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 20:19:10 +0200 (CEST)
Received: from place.org ([65.163.18.18]:26772 "EHLO zachs.place.org")
	by linux-mips.org with ESMTP id <S1122958AbSIDSTJ>;
	Wed, 4 Sep 2002 20:19:09 +0200
Received: by zachs.place.org (Postfix, from userid 1002)
	id BA443181F4; Wed,  4 Sep 2002 13:19:00 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by zachs.place.org (Postfix) with ESMTP
	id B87F8180FD; Wed,  4 Sep 2002 13:19:00 -0500 (CDT)
Date: Wed, 4 Sep 2002 13:19:00 -0500 (CDT)
From: Jay Carlson <nop@nop.com>
X-X-Sender: nop@zachs.place.org
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@linux-mips.org
Subject: Re: soft-float defines in mips-linux gcc config
In-Reply-To: <20020903191536.GA28999@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209041310310.19597-100000@zachs.place.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <nop@nop.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 87
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nop@nop.com
Precedence: bulk
X-list: linux-mips

On Tue, 3 Sep 2002, Daniel Jacobowitz wrote:

> On Tue, Sep 03, 2002 at 08:26:37AM -0400, Jay Carlson wrote:
> > Right now there is a small bug in how mips-linux configures gcc for
> > softfloat.
> >
> > In gcc/config/mips/t-linux, we set up libgcc to include the soft
> > floating point code, using the GNU names, like __addsi3.  But because
> > mips/linux.h includes mips/ecoff.h, gcc produces calls to the GOFAST
> > style names (like dpmul, very namespace-contaminating.)
> >
> > mips/netbsd.h cleans up after mips/elf.h by doing:
> >
> > #undef US_SOFTWARE_GOFAST
> > #undef INIT_SUBTARGET_OPTABS
> > #define INIT_SUBTARGET_OPTABS
> >
> > which would fix the problem for mips/linux.h as well.
>
> When commenting on GCC issues, please say which version you're talking
> about -

It was 3.2; was in a hurry to get this written down before I commuted
and forgot about it.

> I'm pretty sure this is fixed in 3.2,

Scene: Jay, the cartoon character, chasing cartoon bug.  Bug runs off
cliff, disappears from thin air.  Jay keeps on running, until he
notices the bug's gone, and he's standing on thin air.  Oops.

After I actually peered at the output of cc1 from 3.2, I agree, you're
right, the bug is fixed.  I was so used to forward-porting this patch
from revision to revision that I applied this without even checking
whether it was necessary.

What I don't understand is *how* the bug got fixed.  It looks like the
OPTABS should still set us up for the GOFAST library.  Oh well, can't
argue with working code.

I wish the "-fdata-sections doesn't apply to C++ .bss" bug would get
fixed while I'm not looking too...although that one might take some
arguing about for people who are stuck on truly ancient binutils.

Jay
