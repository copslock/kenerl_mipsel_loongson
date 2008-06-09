Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 16:37:18 +0100 (BST)
Received: from hs-out-0708.google.com ([64.233.178.240]:16231 "EHLO
	hs-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20032162AbYFIPhP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 16:37:15 +0100
Received: by hs-out-0708.google.com with SMTP id x43so901313hsb.0
        for <linux-mips@linux-mips.org>; Mon, 09 Jun 2008 08:37:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=cugFjSLA+m0QVRhFuuNJQ+b5wa2s5x8Y6XGj62uecpg=;
        b=b6+2rj7ocokfw1MJ3+Bh4cGYbGrlaDV2BaQenjMe3oG74fGmeN6JvjtgDjYcYn2/pP
         yPdF1uJrKjmOcEoXLCjt/z4DMSHm7Earw67mxxJufIrsnDblTiULvi03bvZgjqS3mq6d
         BVn3FSM3T0m2+QnqUi4pvaDeP72AcEFLCrTCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=mHpbBh1ZJRTxXGF50ITAMGOhOE2+QBmVoi4Zd8J5MEBlm250bX3jfpmuedYzCBzRYe
         5ayKvLfgGsbD/zLJrJErusZC7ZLld5LLn+f1dwbtgbFZ3dn2BQ9aaTYW2FGRvgnDNBOf
         szwZqM+R/CORX3Nw/Da3dg6w+W1p4UwERqCOQ=
Received: by 10.150.49.1 with SMTP id w1mr6543951ybw.24.1213025833748;
        Mon, 09 Jun 2008 08:37:13 -0700 (PDT)
Received: by 10.150.156.11 with HTTP; Mon, 9 Jun 2008 08:37:13 -0700 (PDT)
Message-ID: <a537dd660806090837i5ef6c1e2k167aeb97785a136d@mail.gmail.com>
Date:	Mon, 9 Jun 2008 17:37:13 +0200
From:	"Brian Foster" <brian.foster@innova-card.com>
To:	linux-mips@linux-mips.org, "Andrew Dyer" <adyer@righthandtech.com>
Subject: Re: Re: Adding(?) XI support to MIPS-Linux?
In-Reply-To: <200806091658.10937.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200806091658.10937.brian.foster@innova-card.com>
X-Google-Sender-Auth: f108a826f98cf427
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

> Date: Monday 09 June 2008
> From: Andrew Dyer <adyer@righthandtech.com>
>
> Brian Foster wrote:
>>  The MIPS 4KSd core (at least) implements an XI (eXecute Inhibit)
>>  page protection bit.  XI is similar to the NX (No Execute) bit
>>  in the more recent AMD/Intel x86 families:  Attempts to I-fetch
>>  from a page with XI set cause an exception.
>
> AFAIK this is the only part with this extension, so I doubt that
> much has been done with it.
>
> I know that OpenBSD has done a bunch of work with x86 implementing
> a similar protection scheme, you might do some searching on their
> lists to see if they have any information on GCC mods required.

Andrew,

 As far as I am aware, XI is part of the SMARTMIPS extension,
 and I _think_ SMARTMIPS is only implemented by the 4KS cores?
 Whilst other companies have licensed that core from MIPS, to
 the best of my knowledge the SoC I'm concerned with (Innova
 Card's USIP Pro) is the only one running Linux.  So I suspect
 you're quite correct:  Nothing's been done.

 I've been in contact with the PaX people, and they inform me
 "the experimental NX tweaks [ for MIPS ] didn't get anywhere
 due to lack of time/interest of the guy who started it."

 The "market segment" USIP is aimed at is sufficiently touchy
 about security I currently believe it's plausible (assuming
 it's technologically possible) to simply forbid (not support)
 concurrently executable-and-writable memory.  As such, certain
 programs won't work.  Tough.  There's no call to support the
 (broken) JVM's et al. that "require" it, and I'm hoping that
 nested C/C++ functions are rare (ideally non-existent in the
 code which normally runs on USIP).  It'd be nice if such code
 either fails to compile and/or fails to link/load, but that's
 some (highly useful) porcelain.

 Broadly, what I'm trying to say is I don't want to touch gcc
 (and/or binutils) and am unconvinced I have to.  But I'm very
 much open to correction here!

 The x86 (including amd64) and, AFAIK, SuperH (sh) Linux kernels
 now support NX or equivalent; indeed, a test on my 2.6.22(-ish)
 amd64 workstation (Kubuntu 7.10) has a non-executable stack.
 As such, those could be a model worth studying/following, but
 I understand they have support for specially-marked binaries to
 have executable stacks (i.e., binutils/gcc mods, which I want to
 avoid).  It's probably worth having a look at OpenBSD (thanks
 for the suggestion!).

 Advice, suggestions, pointers, comments, corrections are very
 welcome.

cheers!
	-blf-

-- 
"How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools." |      http://www.stopesso.com
