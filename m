Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 20:33:00 +0100 (BST)
Received: from smtp-wifi-out.orange.fr ([80.12.242.163]:4797 "EHLO
	smtp21.orange.fr") by ftp.linux-mips.org with ESMTP
	id S20033172AbYFITc5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 20:32:57 +0100
Received: from [127.0.0.1] (unknown [81.253.22.6])
	by mwinf5909 (SMTP Server) with ESMTP id B76B2A5F8;
	Mon,  9 Jun 2008 21:32:48 +0200 (CEST)
X-ME-UUID: 20080609193248751.B76B2A5F8@mwinf5909
Message-ID: <484D856B.5030306@paralogos.com>
Date:	Mon, 09 Jun 2008 21:32:59 +0200
From:	"Kevin D. Kissell" <KevinK@paralogos.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	Brian Foster <brian.foster@innova-card.com>
Cc:	linux-mips@linux-mips.org, Andrew Dyer <adyer@righthandtech.com>
Subject: Re: Adding(?) XI support to MIPS-Linux?
References: <200806091658.10937.brian.foster@innova-card.com> <a537dd660806090837i5ef6c1e2k167aeb97785a136d@mail.gmail.com>
In-Reply-To: <a537dd660806090837i5ef6c1e2k167aeb97785a136d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <KevinK@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KevinK@paralogos.com
Precedence: bulk
X-list: linux-mips

Brian Foster wrote:
> Andrew,
>
>  As far as I am aware, XI is part of the SMARTMIPS extension,
>  and I _think_ SMARTMIPS is only implemented by the 4KS cores?
>   
That is correct, though there has long been interest in having XI/RI as 
an option
for non-SmartMIPS cores and I would not be surprised if sooner or later it
became more generally available.
>  Whilst other companies have licensed that core from MIPS, to
>  the best of my knowledge the SoC I'm concerned with (Innova
>  Card's USIP Pro) is the only one running Linux.  So I suspect
>  you're quite correct:  Nothing's been done.
>   
I believe that there is at least one other 4KS-family customer working with
Linux, but they haven't been nearly as active as InnovaCard.  I had some
email exchanges with someone who was working on their kernel a couple
of years back about this very topic.  Indeed, I thought that they submitted
some patches for basic RI/XI support at one point.  Scan the linux-mips.org
archives, if they survived the rehosting.
>  I've been in contact with the PaX people, and they inform me
>  "the experimental NX tweaks [ for MIPS ] didn't get anywhere
>  due to lack of time/interest of the guy who started it."
>
>  The "market segment" USIP is aimed at is sufficiently touchy
>  about security I currently believe it's plausible (assuming
>  it's technologically possible) to simply forbid (not support)
>  concurrently executable-and-writable memory.  As such, certain
>  programs won't work.  Tough.  There's no call to support the
>  (broken) JVM's et al. that "require" it, and I'm hoping that
>  nested C/C++ functions are rare (ideally non-existent in the
>  code which normally runs on USIP).  It'd be nice if such code
>  either fails to compile and/or fails to link/load, but that's
>  some (highly useful) porcelain.
>
>  Broadly, what I'm trying to say is I don't want to touch gcc
>  (and/or binutils) and am unconvinced I have to.  But I'm very
>  much open to correction here!
>
>  The x86 (including amd64) and, AFAIK, SuperH (sh) Linux kernels
>  now support NX or equivalent; indeed, a test on my 2.6.22(-ish)
>  amd64 workstation (Kubuntu 7.10) has a non-executable stack.
>  As such, those could be a model worth studying/following, but
>  I understand they have support for specially-marked binaries to
>  have executable stacks (i.e., binutils/gcc mods, which I want to
>  avoid).
Well, strictly speaking, you wouldn't actually *need* to modify binutils
to make specially tagged binaries.  You could borrow an unused bit in
the ELF header somewhere, have the kernel recognize it, and write your
own little tool that only turns that bit on/off in an ELF file.  In the 
longer
term, I'd argue that if there's support for appropriate binary tagging in
the x86 tools, that support should simply be enabled for MIPS targets
and any other non-x86 archiectures with such support (e.g. Alpha, if
anyone still uses them).

          Regards,

          Kevin K.
