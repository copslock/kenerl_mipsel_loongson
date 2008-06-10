Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2008 10:32:36 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.250]:43205 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20034734AbYFJJcd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jun 2008 10:32:33 +0100
Received: by rv-out-0708.google.com with SMTP id c5so2251753rvf.24
        for <linux-mips@linux-mips.org>; Tue, 10 Jun 2008 02:32:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=m6hcMqdqR3dYKK3RKtnKC75JxTQKkLLNjByq7dqgCRg=;
        b=rxXS13friYsfQvskLu5syWfFlM5JDVTtDpkTJd+XNZFUTLVqGzh2k9k52JutIhNHrW
         29ZZ/cnwD0zGKgXVEXoP5Z0Zc5TDe6tKkHuyk/kbk40wn5PL50ReRFjGM3ZMzA4Rv9JB
         luknjANcVAHP/667+YjVSnjp48AXUlBoSz8eY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=V2uWoSm5MbHD1+YOwb0x7KY8Rul0DXy9AsabA1/TAL9O3gwQR+tX4UW8mXzis2DnTS
         ugJSZMuCPZetazVFtlx+4HtpDd2QbEAHnvonI3V0r+3pnO5UQ5T2uGzB+KuAsPKqE3lR
         xD1aSZuGykiexgBRnssMD1Z5pKXS4P3ZKL0Jo=
Received: by 10.141.89.13 with SMTP id r13mr2834242rvl.177.1213090349448;
        Tue, 10 Jun 2008 02:32:29 -0700 (PDT)
Received: by 10.141.185.4 with HTTP; Tue, 10 Jun 2008 02:32:29 -0700 (PDT)
Message-ID: <a537dd660806100232v4cbf2cfeo397e94ac5a4d2104@mail.gmail.com>
Date:	Tue, 10 Jun 2008 11:32:29 +0200
From:	"Brian Foster" <brian.foster@innova-card.com>
To:	"Kevin D. Kissell" <KevinK@paralogos.com>,
	"Andrew Dyer" <adyer@righthandtech.com>,
	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: Adding(?) XI support to MIPS-Linux?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <200806101119.06227.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200806091658.10937.brian.foster@innova-card.com>
	 <484D856B.5030306@paralogos.com> <20080609204627.GE11233@networkno.de>
	 <200806101119.06227.brian.foster@innova-card.com>
X-Google-Sender-Auth: c5035d3b1c5fd2c5
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

 1) Date: Mon, 09 Jun 2008 21:32:59 +0200
 1) From: "Kevin D. Kissell" <KevinK@paralogos.com>
 1)
 1) Brian Foster wrote:
 1) >  As far as I am aware, XI is part of the SMARTMIPS extension,
 1) >  and I _think_ SMARTMIPS is only implemented by the 4KS cores?
 1)
 1) That is correct, though there has long been interest in having XI/RI
 1) as an option for non-SmartMIPS cores and I would not be surprised if
 1) sooner or later it became more generally available.

Ok, thanks for the confirmation.
I'll keep this in mind w.r.t. to any proposed patches.

 1) >  Whilst other companies have licensed that core from MIPS, to
 1) >  the best of my knowledge the SoC I'm concerned with (Innova
 1) >  Card's USIP Pro) is the only one running Linux.  [ ... ]
 1)
 1) I believe that there is at least one other 4KS-family customer working
 1) with Linux, but they haven't been nearly as active as InnovaCard.
 1) I had some email exchanges with someone who was working on their kernel
 1) a couple of years back about this very topic.  Indeed, I thought that
 1) they submitted some patches for basic RI/XI support at one point.
 1) Scan the linux-mips.org archives, if they survived the rehosting.

I just spent a fair bit of the morning searching the archives,
and cannot find anything related to 4KS, SmartMIPS, XI, or RI
(except odd mentions here and there, none(?) of substance (on
this subject), and all seeming to involve Innova Card).  I'm
*very* interested in seeing/learning what others have done or
tried, so if you or anyone else has any information/whatever
that you can share, please let me know!  Thanks.

 1)[ ... ]
 1) >  Broadly, what I'm trying to say is I don't want to touch gcc
 1) >  (and/or binutils) and am unconvinced I have to.  But I'm very
 1) >  much open to correction here!
 1) >
 1) >  The x86 (including amd64) and, AFAIK, SuperH (sh) Linux kernels
 1) >  now support NX or equivalent [ ... ].
 1) >  I understand they have support for specially-marked binaries to
 1) >  have executable stacks (i.e., binutils/gcc mods, which I want to
 1) >  avoid).
 1)
 1) Well, strictly speaking, you wouldn't actually *need* to modify
 1) binutils to make specially tagged binaries.  [ ... ]

Agreed.  I was speaking loosely.

 1) In the longer term, I'd argue that if there's support for appropriate
 1) binary tagging in the x86 tools, that support should simply be enabled
 1) for MIPS targets and any other non-x86 archiectures with such support
 1) (e.g. Alpha, if anyone still uses them).

Agreed.  This is all *speculative* ATM.  There seems to be
a rational argument that for the specific situation I'm
concerned with, an absolute imposition of non-executable
stack(+data) would be "better".  In the more general
situation, including the longer term, tagged binaries are
(very probably), perhaps unfortunately, desirable.

 2) Date: Mon, 9 Jun 2008 21:46:27 +0100
 2) From: Thiemo Seufer <ths@networkno.de>
 2)
 2) Kevin D. Kissell wrote:
 2)[ ... ]
 2) > Well, strictly speaking, you wouldn't actually *need* to modify
 2) > binutils to make specially tagged binaries.  [ ... ]
 2)
 2) This exists already in ld's -z execstack/noexecstack feature.

Good point.  Thanks for the reminder.

 2) It is not used by default because too many things depend on executable
 2) stacks on MIPS.

Ah!  Can you be more specific please?  At the present time
I'm only aware of three situations where executable stacks
are magically used ("magic" meaning it's being done without
the programmer explicitly coding it):

  1. sigreturn.
  2. something to do with FPU emulation?
  3. pointer to a nested function (gcc extension).

And, significantly, I am do not know of any need for the
kernel-mode stacks to be executable.  Except, perhaps,
for case 3, the above are (should be?) user-land only.

There are also "non-magic" users (JIT in some JVMs is,
I believe, the usual example).  These deliberate users,
and case 3, I want to be able to argue I can blow off
in the specific circumstance I am concerned about.
That is, they simply fail.  Always.  But as said above,
in general and for the longer term, that's presumably
not acceptable (i.e., marked binaries are needed).

cheers!
	-blf-

-- 
"How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools." |      http://www.stopesso.com
