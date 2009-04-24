Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 08:22:32 +0100 (BST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:35297 "EHLO
	mail-bw0-f177.google.com") by ftp.linux-mips.org with ESMTP
	id S20022125AbZDXHW0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2009 08:22:26 +0100
Received: by bwz25 with SMTP id 25so994082bwz.0
        for <linux-mips@linux-mips.org>; Fri, 24 Apr 2009 00:22:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=cPIruf4lGlzeUkMU56Qc8Yn+gjV/ydHK/34N1O/4N7g=;
        b=KLSOo7yXsr0Bt9XCrpaWBa6giC74yIGExy+zkrMCbeGFNtmVVEeIMg2d97qeE1Ao0/
         dFTAHU/JGPOxJN37r04sigEoKUEM9pTYHJSMgn8EcMUoOUiAjxVNW1yo45cfvnOLakuv
         Huuvw/0FDelLNcKFHrUFdeiFI90dtGqvNL+5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SZZ7sRyNIthtc+G81MKRdtQpzMa1Y2T33yW0PrzNY8ujs7FOnffurDBRD6IhVIpWzR
         LCJS2IDUxY4wBqs0jGIAezDGSw356+nD0zq5lrpsQoBN1Ad8ncoKoK1v6bYGmJy40KQ8
         KpOG1mzm1cH07WCgbfIukitJjBm962luIKr9g=
Received: by 10.204.31.230 with SMTP id z38mr1740447bkc.85.1240557737839;
        Fri, 24 Apr 2009 00:22:17 -0700 (PDT)
Received: from innova-card.com (LRouen-152-82-23-47.w80-13.abo.wanadoo.fr [80.13.118.47])
        by mx.google.com with ESMTPS id 27sm609378fxm.45.2009.04.24.00.22.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 00:22:16 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	David Daney <ddaney@caviumnetworks.com>,
	"Kevin D. Kissell" <kevink@paralogos.com>
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
Date:	Fri, 24 Apr 2009 09:20:02 +0200
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
Cc:	linux-mips@linux-mips.org
References: <49EE3B0F.3040506@caviumnetworks.com> <49EEE4EA.8040100@paralogos.com> <49EF5B88.90004@caviumnetworks.com>
In-Reply-To: <49EF5B88.90004@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200904240920.03343.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Wednesday 22 April 2009 20:01:44 David Daney wrote:
> Kevin D. Kissell wrote:
> > David Daney wrote:
> >> This is a preliminary patch to add a vdso to all user processes.
> >> Still missing are ELF headers and .eh_frame information.  But it is
> >> enough to allow us to move signal trampolines off of the stack.
> >>
> >> We allocate a single page (the vdso) and write all possible signal
> >> trampolines into it.  The stack is moved down by one page and the vdso
> >> is mapped into this space.
> >>
> >> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> > 
> > Note that for FPU-less CPUs, the kernel FP emulator also uses a user
> > stack trampoline to execute instructions in the delay slots of emulated
> > FP branches.  I didn't see any of the math-emu modules being tweaked in
> > either part of your patch.  Presumably, one would want to move that
> > operation into the vdso as well.

Kevin,

   As David says, this is a Very Ugly Problem.  Each FP trampoline
  is effectively per-(runtime-)instance per-thread, i.e., there is
  a unique FP trampoline for every dynamic instance of (non-trivial
  non-FP) instruction in an FP delay slot.  This is essentially the
  complete opposite of the signal-return trampoline, which is fixed
  (constant text) for all instances in all threads.

   As such, David's vdso (assuming it's similar to those on other
  architectures (I've not looked at it closely yet)) may not have
  any obvious role to play in moving the FP trampoline('s code?)
  off the user's stack.

>[ ... ]
> It is an ugly problem.  I am trying to hack something up to fix it.
> 
> David Daney

David,

   Since we are massively interested in what all this is leading
  to (no-execute stacks using the XI bit), I'm very happy to help
  (time permitting — I've got an overflowing list of other stuff).
  We make a 32-bit 4KSd-based SoC (Innova Card (now Maxim) USIP),
  albeit the latest kernel we have running ATM is 2.6.25 (soon, I
  hope, to be 2.6.26(.1 at least?)).  I'll be trying your patches
  (presumably by backporting) as soon as I can (see: overflowing
  list....  ;-\  ).

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
