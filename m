Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 20:46:34 +0200 (CEST)
Received: from p508B5F93.dip.t-dialin.net ([80.139.95.147]:35467 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122958AbSIDSqe>; Wed, 4 Sep 2002 20:46:34 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g84IkMq02793;
	Wed, 4 Sep 2002 20:46:22 +0200
Date: Wed, 4 Sep 2002 20:46:22 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020904204622.D32519@linux-mips.org>
References: <20020904163101.C32519@linux-mips.org> <Pine.GSO.3.96.1020904170056.10619H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020904170056.10619H-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Sep 04, 2002 at 05:19:51PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 90
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 04, 2002 at 05:19:51PM +0200, Maciej W. Rozycki wrote:

> > The primary problem is the differnet calling sequence for o32 and N64.
> 
>  But we handle that already.

Well, N32 is yet another case.  Have to look into details again but some
MIPS guy recently pointed out to me that there are a few syscalls which
for N32 cannot be handled by the o32 or N64 syscall entry as they are right
now.

> > The question is if we want to reserve another 1000 entries in our already
> > huge syscall table for N32 or if we got a better solution ...
> 
>  Aaarrgh, no more entries, please...

Understandable reflex :)

Btw, I did just chat with a Redhat guy.  They say they're basically finished
and are just waiting for us.  Which means we need to deciede fast ...

I'll be on the Linux Kongress for the next few days so I'll not be able to
answer as quickly as I'd like to but I'll try to read me email as often
as I can.

  Ralf
