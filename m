Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6QGqARw032068
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 26 Jul 2002 09:52:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6QGq98b032067
	for linux-mips-outgoing; Fri, 26 Jul 2002 09:52:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6QGpxRw032056
	for <linux-mips@oss.sgi.com>; Fri, 26 Jul 2002 09:51:59 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Fri, 26 Jul 2002 09:53:02 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id JAA05354; Fri, 26 Jul 2002 09:53:03 -0700 (PDT)
Received: from dt-sj3-118.sj.broadcom.com (dt-sj3-118 [10.21.64.118]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g6QGr2ER020436; Fri, 26 Jul 2002 09:53:02 -0700 (PDT)
Received: (from cgd@localhost) by dt-sj3-118.sj.broadcom.com (
 8.9.1/SJ8.9.1) id JAA14534; Fri, 26 Jul 2002 09:53:00 -0700 (PDT)
To: hjl@lucon.org
cc: "Carsten Langgaard" <carstenl@mips.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com, binutils@sources.redhat.com
Subject: Re: PATCH: Update E_MIP_ARCH_XXX (Re: [patch] linux: RFC:
 elf_check_arch() rework)
References: <Pine.GSO.3.96.1020725125830.27463H-100000@delta.ds2.pg.gda.pl>
 <3D3FFD21.8DA26337@mips.com> <20020725082610.A21614@lucon.org>
 <mailpost.1027610779.9546@news-sj1-1>
From: cgd@broadcom.com
Date: 26 Jul 2002 09:53:00 -0700
In-Reply-To: hjl@lucon.org's message of
 "Thu, 25 Jul 2002 15:26:19 +0000 (UTC)"
Message-ID: <yov54remph1v.fsf@broadcom.com>
X-Mailer: Gnus v5.7/Emacs 20.4
MIME-Version: 1.0
X-WSS-ID: 115FA1E4581143-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-3.7 required=5.0 tests=IN_REP_TO,NO_REAL_NAME,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At Thu, 25 Jul 2002 15:26:19 +0000 (UTC), "H. J. Lu" wrote:
> I'd like to fix binutils ASAP. Here is a patch.

OK, so, I've seen no response so far that indicates that binutils
should actually be changed.


to recap:

* Binutils has deployed these values in several releases now, and I
  know for a fact that people are using binaries with these values.

* SGI has followed binutils' lead in selecting values.

* Algorithmics did something else, though it's not clear what the
  difference between "ARCH_ALGOR_32" and "ARCH_32" really is.


It seems obvious that the simplest solution that causes the least pain
all around is to go with the numbering binutils currently uses.  This
will probably cause a little bit of pain for Algorithmics, but, well,
they could have sent something to binutils to indicate use of that
number, and i'm quite sure that most of the rest of us have had to put
temporary backward-compat hacks in our own codebases for incompatible
changes made by others in the past.  It's not that hard and doesn't
cause long-term pain.


I could understand that MIPS or Algorithmics might like that, but I
think there're a bunch of morals to this story: if you want to lead on
ABI issues, get out in front of them (you can't lead from the back
8-); interact with the tool development and use communities about such
issues _before_ solutions are needed and agreed upon in those
communities; and, you're hacking open source code like binutils,
contribute your changes back as soon as you possibly can.

I'd also like to point out that saying "mips will be defining this
ABI, so you should all change your code to work with it" without,
AFAIK, even providing a draft of said ABI... is unlikely to produce
positive results even _if_ there's no precedent that would go against
the requested change.  (if somebody has a ptr, i'd be glad to be
corrected 8-)

(I wonder what other incompatibilities may exist between this new ABI
and the current binutils MIPS ELF headers...)



cgd
-- 
Chris Demetriou                                            Broadcom Corporation
Senior Staff Design Engineer                  Broadband Processor Business Unit
  Any opinions expressed in this message are mine, not necessarily Broadcom's.
