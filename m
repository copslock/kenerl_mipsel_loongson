Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 16:36:13 +0200 (CEST)
Received: from p508B5F93.dip.t-dialin.net ([80.139.95.147]:46984 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122958AbSIDOgM>; Wed, 4 Sep 2002 16:36:12 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g84EV1932767;
	Wed, 4 Sep 2002 16:31:01 +0200
Date: Wed, 4 Sep 2002 16:31:01 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020904163101.C32519@linux-mips.org>
References: <20020904155645.A31893@linux-mips.org> <Pine.GSO.3.96.1020904160219.10619G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020904160219.10619G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Sep 04, 2002 at 04:14:13PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 77
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 04, 2002 at 04:14:13PM +0200, Maciej W. Rozycki wrote:

> > I probably missed a few.  The primary purpose of this posting is to get a
> > discussion about the 64-bit syscall interface started.  It's still not
> > cast into stone so we can modify it as we see fit.  The entire syscall
> > interface is still open for changes, this includes all structures etc.
> > Along with a 64-bit ABI we'll also have to deciede about a N32 ABI.
> 
>  It would be nice if we could keep a single set of syscalls for both (n)64
> and n32.  The address crop for n32 may be handled the Alpha way.  I will
> investigate the topic soon.

Can you describe how this is handled on the  Alpha?

The primary problem is the differnet calling sequence for o32 and N64.
As it looks we'll be able to use either the o32 function or the native
syscall to implement all of the necessary N32 syscalls.

The question is if we want to reserve another 1000 entries in our already
huge syscall table for N32 or if we got a better solution ...

  Ralf
