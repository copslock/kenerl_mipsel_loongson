Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 14:25:07 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.153]:1253 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20041705AbYFKNRF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2008 14:17:05 +0100
Received: by fg-out-1718.google.com with SMTP id d23so2118853fga.32
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2008 06:17:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=aPv/we3u6dvFFUaVPLjSSdNbmJNCJoi8BYnnmdRk/rc=;
        b=i5eofXAmD/hd43iP0USSZyFTf0m/uskW7iTepuW5nppoQheJ5laR8b6Qg0crV0Oqgx
         W9AkmU/S+oUxNTgu+9tNK66HBqW5Bwq8TTJ8gAN80nr+0RH+Xdus8hgFkijWPd7WtGt5
         ApjEUpdLzODvpikFyGukkOlpg+8ABe7Oh7qLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=cn6+rWEclNJhEAgwhBDDV/PK3Dutvrtky5BR0d7DWKOeO7EIJKebPsPnuKS3sjS62A
         CM7dIAKq7m8Ra/liJ0x8E/PaX8UVA1t/PYyE4Oum7PtDgFupLzU0aW3Dc3sK9SgYxlfA
         WFfzv0rP64nQfrJrF1xavDhQvHdbg6lDqM4r8=
Received: by 10.86.78.4 with SMTP id a4mr196186fgb.29.1213190224510;
        Wed, 11 Jun 2008 06:17:04 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id 3sm16296349fge.3.2008.06.11.06.16.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jun 2008 06:17:02 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: Adding(?) XI support to MIPS-Linux?
Date:	Wed, 11 Jun 2008 15:16:56 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Thiemo Seufer <ths@networkno.de>,
	"Kevin D. Kissell" <KevinK@paralogos.com>,
	Andrew Dyer <adyer@righthandtech.com>
References: <200806091658.10937.brian.foster@innova-card.com> <20080610095702.GG11233@networkno.de> <484EAA16.80903@avtrex.com>
In-Reply-To: <484EAA16.80903@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200806111516.57406.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Thiemo Seufer wrote:
> > Brian Foster wrote:
> >>  2) Kevin D. Kissell wrote:
> >>  2)[... ‘ld -z noexecstack’ ] is not used by default because too many
> >>  2) things depend on executable stacks on MIPS.
> >> 
> >> Ah!  Can you be more specific please?  At the present time
> >> I'm only aware of three situations where executable stacks
> >> are magically used ("magic" meaning it's being done without
> >> the programmer explicitly coding it):
> >> 
> >>   1. sigreturn.
> >>   2. something to do with FPU emulation?
> >>   3. pointer to a nested function (gcc extension).
> > 
> > Those, plus manually coded trampolines in e.g. foreign function
> > interfacing (which are typically hidden in some library).  I don't
> > know if you can ignore that completely. :-)
> 
> The trampolines in libffi are user allocated, so there is a choice of
> where to place them.  In libgcj (which uses the libffi trampolines) the
> trampolines are allocated on the heap and care is taken to set the
> execute permissions on the memory in question.  Other users may have
> problems, but by now most code should work as XI support has been
> present on x86 for quite some time now.

 David, thanks for clarifying Thiemo's point; I wasn't
 quite sure what he meant by “foreign functions” albeit
 (as it happens) apparently guessed correctly.  And for
 the specific example of ‘libffi’ (and ‘libgcj’); that's
 a new library (to me).

> As long as there is a mechanism to make user space stacks (and heap)
> executable, there should be no problem.  People running code that
> requires it can switch off the XI support.

 Agreed.  It is (alas?) important for the general case and
 the longer term.  But it's plausible that for the specific
 case I have, it's not important and maybe not even wanted.
 (I'm working in a security paranoid/sensitive area .... .)
 Please note this is rather *speculative* ATM!

 It's case 2 (above), the trampoline that has “something
 to do with FPU emulation”, which has me concerned ATM.
 The 4KSd core does not have an FPU.  That encourages the
 use of ‘-msoft-float’ (at least for performance), but does
 not require it.  (Albeit I wonder if, in the restricted
 world I'm playing in, if it could be “required” (assuming
 it doesn't have an issue?)?  Hum .... .)

 The quick summary (which I'm sure others on this list can
 clarify/correct) is the FP trampoline, which is pushed on
 the user-land stack is, unlike sigreturn, not fixed code.
 It varies on a per-instance per-thread basis.  Hence the
 simple ‘vsyscall’ mechanism ((to be?) used for sigreturn)
 is inappropriate.

 The trampoline is only used to execute a non-FP instruction
 (<instr>) in the delay slot of an FP-instruction:

     <instr>  # Non-FP instruction to execute in user-land
     BADINST  # Bad instruction forcing return to FP emulator
     COOKIE   # Bad instruction (not executed) for verification
     <epc>    # Where to resume execution after <instr>

 Belch! ;-\  Whilst I can think of a few things that may work
 (temporarily change page permissions;  or go ahead and use
 the ‘vsyscall’ page with some interlocking magic;  or a new
 new dedicated per-thread page;  or ...?) none seem appealing.

 Suggestions?  Comments?  Prior art to study?

thanks & cheers!
	-blf-

( I'm experimenting with a new technique for posting to the
 list to save me some hassle.  It *should* work, but .... ! )
-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
