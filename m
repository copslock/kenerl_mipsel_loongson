Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 13:15:17 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.191]:52763 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026334AbXKMNPJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 13:15:09 +0000
Received: by nf-out-0910.google.com with SMTP id c10so1252751nfd
        for <linux-mips@linux-mips.org>; Tue, 13 Nov 2007 05:14:59 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+w9AdHSBgJKRKkkkvy4WN5gQgLxb3qeEz5CVK3LlbF8=;
        b=ZOe6FKJK82IuiVDQzIb2PCpNlWZMSd8tpvp4aomfEferm08fRnq9drt5Gu2s1oPhJf/rus46ghiKBUjPvaryIUV/BUY30+n0xA9MtuZj9bz8h4GwSrUtX0n4yo4o1l8cvMBmYrrNfknzLuqOU72SC/yTDugwlASyjnzkLKd9yGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dm7FUA6NFZ3FrAXNnwxvIsaJooT5u9SYyXVF3CLB6fBfvamTxZFxHzPB/+EtM0cEFC+w7g2h5ThOJDaomJnglAdIdt15DacsjUGx6fDFoV87f1nOIiCIwj14rC4IAxh1USBymXjB6Q9u03nmyTlEC2T7Rtb+lWxW8Lqs3lzvapM=
Received: by 10.78.37.7 with SMTP id k7mr6619008huk.1194959698997;
        Tue, 13 Nov 2007 05:14:58 -0800 (PST)
Received: by 10.78.179.18 with HTTP; Tue, 13 Nov 2007 05:14:58 -0800 (PST)
Message-ID: <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com>
Date:	Tue, 13 Nov 2007 14:14:58 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Cannot unwind through MIPS signal frames with ICACHE_REFILLS_WORKAROUND_WAR
Cc:	"Andrew Haley" <aph-gcc@littlepinkcloud.com>,
	"David Daney" <ddaney@avtrex.com>, linux-mips@linux-mips.org,
	"Richard Sandiford" <rsandifo@nildram.co.uk>, gcc@gcc.gnu.org
In-Reply-To: <20071113121036.GA6582@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <473957B6.3030202@avtrex.com>
	 <18233.36645.232058.964652@zebedee.pink>
	 <20071113121036.GA6582@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On Nov 13, 2007 1:10 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Tue, Nov 13, 2007 at 11:48:53AM +0000, Andrew Haley wrote:
>
> > David Daney writes:
> >  > With the current kernel (2.6.23.1) in my R5000 based O2 it seems
> >  > impossible for GCC's exception unwinding machinery to unwind through
> >  > signal frames.  The cause of the problems is the
> >  > ICACHE_REFILLS_WORKAROUND_WAR which puts the sigcontext at an almost
> >  > impossible to determine offset from the signal return trampoline.  The
> >  > unwinder depends on being able to find the sigcontext given a known
> >  > location of the trampoline.
> >  >
> >  > It seems there are a couple of possible solutions:
> >  >
> >  > 1) The comments in war.h indicate the problem only exists in R7000
> >  > and E9000 processors.  We could turn off the workaround if the
> >  > kernel is configured for R5000.  That would help me, but not those
> >  > with the effected systems.
> >  >
> >  > 2) In the non-workaround case, the siginfo immediately follows the
> >  > trampoline and the first member is the signal number.  For the
> >  > workaround case the first word following the trampoline is zero.
> >  > We could replace this with the offset to the sigcontext which is
> >  > always a small negative value.  The unwinder could then distinguish
> >  > the two cases (signal numbers are positive and the offset
> >  > negative).  If we did this, the change would have to be coordinated
> >  > with GCC's unwinder (in libgcc_s.so.1).
> >  >
> >  > Thoughts?
> >
> > The best solution is to put the unwinder info in the kernel.  Does
> > MIPS use a vDSO ?
>
> No though we should.
>
> Another reason is to get rid of the classic trampoline the kernel installs
> on the stack.  On some multiprocessor systems it requires a cacheflush
> operation to be performed on all processors which is expensive.  Having
> the trampoline in a vDSO would solve that.
>

And the stack wouldn't need to have exec permission anymore.

> I need to look into it, not sure what it would take.
>

I started to add vdso support for MIPS a couple months ago, but
it's in a very early stage and I unfortunately haven't time to finish
it. I can send it to you if you want.

-- 
               Franck
