Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 13:03:22 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.157]:43639 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28578432AbYFLMDU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2008 13:03:20 +0100
Received: by fg-out-1718.google.com with SMTP id d23so2462965fga.32
        for <linux-mips@linux-mips.org>; Thu, 12 Jun 2008 05:03:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=kccwkkXCQVK4PaEtjDzgJnZdQIc7ajthrp6s/BqtHrQ=;
        b=tcv1p138GORs2WtR9sOdD69BxPnhm2QopMCruKbTdYVnJ0CIPe9DjmFgr+3CDgkeo9
         caUs9DzmitnAbofoNjZlp7ekhsnqjTo6EZZtc6nB1tyi6ChIVzPBVzx7dLuvjcgGkzvh
         W61eiz3Ql802eulCeMrW125iKG3w/kIJxRXfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=Sy5PrbABGJ14f9UKmtkZhiR8CWtHhmA8eqTsgSixH/O95ncmZ3T7fqDWII3r12Jt4l
         ili1TmVDl+LYcnz1Nvp+zM+xjfuqRNsGNH3C7mR40jkTDDXGmRnzrztqjH/aF9fPrXA7
         +JIDcV3gxBD75zmSXy10xfM09W1dlcm79RfeI=
Received: by 10.86.78.4 with SMTP id a4mr2111499fgb.29.1213272198525;
        Thu, 12 Jun 2008 05:03:18 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id 4sm2398547fge.5.2008.06.12.05.03.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 05:03:16 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Adding(?) XI support to MIPS-Linux?
Date:	Thu, 12 Jun 2008 14:03:13 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	David Daney <ddaney@avtrex.com>, Thiemo Seufer <ths@networkno.de>,
	"Kevin D. Kissell" <KevinK@paralogos.com>,
	Andrew Dyer <adyer@righthandtech.com>
References: <200806091658.10937.brian.foster@innova-card.com> <200806111516.57406.brian.foster@innova-card.com> <48501E9E.1040202@mips.com>
In-Reply-To: <48501E9E.1040202@mips.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200806121403.14181.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Wednesday 11 June 2008 Kevin D. Kissell wrote:
> Brian Foster wrote:
> >[ ...  the FPU emulation ] trampoline, which is pushed on
> >  the user-land stack is, unlike sigreturn, not fixed code.
> >  It varies on a per-instance per-thread basis.  Hence the
> >  simple ‘vsyscall’ mechanism ((to be?) used for sigreturn)
> >  is inappropriate.
> >
> >  The trampoline is only used to execute a non-FP instruction
> >  (<instr>) in the delay slot of an FP-instruction  [ ... ]
> >
> >  Belch! ;-\  Whilst I can think of a few things that may work
> >  (temporarily change page permissions;  or go ahead and use
> >  the ‘vsyscall’ page with some interlocking magic;  or a new
> >  new dedicated per-thread page;  or ...?) none seem appealing.
>[ ... ]
> As the jerk who originally bolted the FP emulator into the MIPS kernel
> and came up with the stack trampoline hack, I can explain why it seemed
> sane at the time.  If an FP branch is emulated and to be taken, we have to
> find a way for the instruction in the delay slot to be executed prior to the
> transfer of control to the branch target.  It has to execute with the user's
> permissions.  Putting it on the user's stack and building a trampoline was
> the fairly classical way of doing it, but note that it's architecturally
> illegal to put a branch in a branch delay slot (floating point or otherwise),
> so there's no possibility of recursion.  So one only needs 3-4 words (one
> could substitute another means of validation for the cookie) per thread.

Jerk,  ;-)

 Yes, once I worked out what it was doing it all seemed cute
 (albeit I don't quite see what the danger is with recursion?).
 My “Belch!” was referring to the problems it now causes with
 non-executable stacks.

> It just has to be part of the user's address space.  I suppose
> that instead of using a few words just above the stack, one could use
> a few words just below the current "brk()" point, or, better still (but
> far more invasive) pad the text segment, which should always be
> executable, with 4 words that the kernel can find in a hurry.

 First, you need to really careful about multithreaded code
 concurrently doing FPU stuff.  That is, it's possible there
 may be more than one “live” emulated FPU delay slot in the
 same address space.  So stuffing the code into text, or
 near the brk()-point, or similar, all has concurrency issues.

 This is what makes the current on-the-stack approach neat;
 the stack _is_ per-thread so there's no concurrency mess.

 As for putting the trampoline near the brk()-point, besides
 the concurrency problem, there's also the issue that the
 containing page would have to be made user-executable (if
 temporarily).  Unless I'm confused, that page is nominally
 data (heap-ish).  With the addition of XI support, I would
 expect data to nominally also be non-executable.

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
