Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 20:40:53 +0200 (CEST)
Received: from p508B5F93.dip.t-dialin.net ([80.139.95.147]:31115 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122958AbSIDSkw>; Wed, 4 Sep 2002 20:40:52 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g84Iec602714;
	Wed, 4 Sep 2002 20:40:38 +0200
Date: Wed, 4 Sep 2002 20:40:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020904204038.D1121@linux-mips.org>
References: <20020904155645.A31893@linux-mips.org> <Pine.GSO.3.96.1020904160219.10619G-100000@delta.ds2.pg.gda.pl> <20020904163101.C32519@linux-mips.org> <3D7643BA.6090807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D7643BA.6090807@mvista.com>; from jsun@mvista.com on Wed, Sep 04, 2002 at 10:32:42AM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 89
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 04, 2002 at 10:32:42AM -0700, Jun Sun wrote:

> > The primary problem is the differnet calling sequence for o32 and N64.
> > As it looks we'll be able to use either the o32 function or the native
> > syscall to implement all of the necessary N32 syscalls.
> 
> For 64bit kernel, do we intend to have one syscall table that support o32,
> n32 and n64 altogether?  Or we will have multiple tables for them?

Several approach to solve that problem.  Adding another 1000 entries - which
will cost 8000 bytes of memory that will be mostly zeros.  Having wrappers
for each function that do the appropriate argument and result convertion
is another.  etc.

> > The question is if we want to reserve another 1000 entries in our already
> > huge syscall table for N32 or if we got a better solution ...
> 
> It seems n32 can be naturally implemented through n64 syscalls, although I am 
> sure there are some nasty details to work out.

Unfortunately there are ...

> Where can I find n32/n64 spec?

mipsabi.org which is no longer online.  Anyway, I don't think there is a
formal published N32 spec.  And this whole thread is about the syscall
interface.  That isn't part of any ABI spec.

  Ralf
