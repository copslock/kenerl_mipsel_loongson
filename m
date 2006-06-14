Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2006 19:14:48 +0100 (BST)
Received: from web31506.mail.mud.yahoo.com ([68.142.198.135]:48523 "HELO
	web31506.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133627AbWFNSOi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Jun 2006 19:14:38 +0100
Received: (qmail 38316 invoked by uid 60001); 14 Jun 2006 18:14:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nP+ddtses2oi5wlM31DtmT3MEYqWCPCsTJ4SoEkAIP9Dw44wBUUHErZhhK+ntDgkRAxRaV6sV9NuekW/M0cIrm7nNAO0Z4LTHS0JCkQJ1x7bqqvZPDvmFBgp0Uqb1O2FAj26tP9nuEWdrao5TrZmiot+1BscNY7NNp1PEFznCs0=  ;
Message-ID: <20060614181431.38314.qmail@web31506.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31506.mail.mud.yahoo.com via HTTP; Wed, 14 Jun 2006 11:14:31 PDT
Date:	Wed, 14 Jun 2006 11:14:31 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: Performance counters and profiling on MIPS
To:	Nigel Stephens <nigel@mips.com>,
	Prasad Boddupalli <bprasad@cs.arizona.edu>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <448F42D7.5060401@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Ok, the kernel version number listed is current to
2.6.17-rc6, and the MIPS patches -almost- go in
cleanly.

In the syscalls in arch/mips/kernel, there is a new
syscall (sys_tee) that throws the patches off as it is
not in the context. This is very easy to massage.

The same is true of include/asm-mips/unistd.h, except
there the count of syscalls is also off by one. Again,
a very easy fix.

Other than that, it looks current and looks good. I'm
going to be doing some testing on it, to see whether
it works as well as it looks, or whether it causes the
CPU to leap three feet in the air, discharging the
magic blue smoke.

If other people have had success with it, though, I
would definitely suggest considering it for inclusion
in the linux-mips GIT tree. Those who don't need
performance counters won't be adversely affected, and
those of us who do would likely benefit.

If the linux-mips tree would not be appropriate, then
could someone take up hypnosis and get it included in
the main tree?

Jonathan

--- Nigel Stephens <nigel@mips.com> wrote:

> Prasad Boddupalli wrote:
> > Perfctr
> (http://user.it.uu.se/~mikpe/linux/perfctr/) and
> PAPI
> > (http://icl.cs.utk.edu/papi/) are precisely such
> attempts. Except that
> > MIPS ports of them do not seem to be available.
> 
> There's also perfmon2, for which a MIPS patch is
> available - though no 
> idea how up-to-date it is. See
> http://www.linux-mips.org/wiki/Perfmon2
> 
> Nigel
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
