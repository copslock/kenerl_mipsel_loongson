Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 11:55:57 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.247]:60996 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20030630AbYFIKzq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 11:55:46 +0100
Received: by rv-out-0708.google.com with SMTP id c5so1802838rvf.24
        for <linux-mips@linux-mips.org>; Mon, 09 Jun 2008 03:55:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=XOPG5A/bSu1RJWacPMEuPOJIwb78JOk8i5M1j+y+a5o=;
        b=ZSE6h1O2pNlVqCcGujnxydfjFmxkSo24dJiGGvx+gYS+kxF2ezpaAHv4qyX2Ve6o+A
         EOwSR0X48jQSCvIpIzoIlTs6RHt7AiU6IQGaj36eaxE2htj0TQBVBLXi21Twg/iZVV8O
         ZXml32pTbUFxVOVwmy9K1/1qgeYjXntwABRCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=jXtIupBsYfG1abALmwrQgnie5F+hG0PhqS4Ml6eXMius44875sZ3cx9UvbpxyW1zHM
         GXWlaJoCxnZjd4MUP/d/7tgtuG3wIGMZm+d5N0/shuhjONJUJKDyM+5GcRKiklMtvoxL
         H6q9Kp262F52tcf9hnHOQEHfP2WnpAdmmXte8=
Received: by 10.140.208.17 with SMTP id f17mr1952198rvg.218.1213008943333;
        Mon, 09 Jun 2008 03:55:43 -0700 (PDT)
Received: by 10.141.197.19 with HTTP; Mon, 9 Jun 2008 03:55:43 -0700 (PDT)
Message-ID: <a537dd660806090355g17d470c0i657cd383c439eb0f@mail.gmail.com>
Date:	Mon, 9 Jun 2008 12:55:43 +0200
From:	"Brian Foster" <brian.foster@innova-card.com>
To:	linux-mips@linux-mips.org
Subject: Adding(?) XI support to MIPS-Linux?
In-Reply-To: <200806091050.m59AoUUl014012@smtp02.msg.oleane.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200806091050.m59AoUUl014012@smtp02.msg.oleane.net>
X-Google-Sender-Auth: 9fd0313f4c586b60
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

Hello,

 The MIPS 4KSd core (at least) implements an XI (eXecute Inhibit)
 page protection bit.  XI is similar to the NX (No Execute) bit
 in the more recent AMD/Intel x86 families:  Attempts to I-fetch
 from a page with XI set cause an exception.

 I've been asked to look into the possibility/difficulty of adding
 support for XI to MIPS-Linux (at least for the 4KSd core), for
 both kernel-mode and user-land.  An admittedly very quick check
 of 2.6.25(-ish) suggests there is no support at all, at present,
 for XI for any MIPS core/configuration.  Nor has a search of the
 'Net found much of anything, with the possible exception of the
 PaX and grsecurity projects.

 Of course, I don't want to repeat work which has already been done.
 Has anyone studied adding, or better yet, already (tried to?) added,
 any support for XI?

 *Speculating*, and with the caveat I'm not completely up on MIPS
 TLB/memory-management/caches, I don't see kernel-mode as too much
 of an issue.  There's no (known to me) cases of code-in-data/stack?
 Whilst I know bugger-all about module loading/unloading, I rather
 doubt there's anything too tricky going on there?

 User-land is clearly more difficult due to the `sigreturn' and FPU
 emulation trampolines, which reside in user-land stack.  At the
 moment I am presuming a `vsyscall'-page scheme solves that problem,
 but have not researched the issue (esp. the FPU emulation) closely.
 A `vsyscall' which just contains the trampolines doesn't sound too
 difficult; but if you add to that (which I am NOT proposing!) the
 optimization of volatile time-of-day data (RO to user-land, RW to
 kernel-mode), then there would seem to be issues/gotchas with MIPS
 caching and/or page-protection?

 Does `gcc' for MIPS generate any trampolines in the stack/data?
 I keep seeing hints that `gcc' does in certain unspecified cases
 and/or architectures, but am at a lost just what is being talked
 about.  Wikipedia suggests this only happens in (some?) cases of
 nested functions; as such, for C, they don't seem necessary and
 my initial inclination is say "don't use 'em!".

 I'm hoping to be able to avoid any support at all for executable
 stacks:  I want all user-land code to have XI-set stacks.  This is
 partly for simplicity (I presume), but also because the target is
 the the "secure" embedded world, where simply being able to assert
 you cannot, never, execute code in the stack (or in data) is much
 easier to pass muster with various certification authorities and
 testing laboratories.  (PCI-PED is the area of immediate interest
 here.)  I'm aware mprotect(2), at the least, is an issue, because
 it can be used to set a page to be both writable and executable.
 (Hence, more generally, I want to be able to assert that no memory
 with the exception of kseg0/kseg1, is ever concurrently writable
 and executable.)

 Advice, suggestions, pointers, comments are very welcome.

cheers!
       -blf-

-- 
"How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools." |      http://www.stopesso.com
