Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 14:42:28 +0100 (BST)
Received: from admin.voldemort.codesourcery.com ([IPv6:::ffff:65.74.133.9]:65223
	"EHLO mail.codesourcery.com") by linux-mips.org with ESMTP
	id <S8226361AbVGHNmK>; Fri, 8 Jul 2005 14:42:10 +0100
Received: (qmail 20726 invoked by uid 1010); 8 Jul 2005 13:42:42 -0000
From:	Richard Sandiford <richard@codesourcery.com>
To:	Ralf Baechle DL5RB <ralf@linux-mips.org>
Mail-Followup-To: Ralf Baechle DL5RB <ralf@linux-mips.org>,"Maciej W. Rozycki" <macro@linux-mips.org>,  Thiemo Seufer <ths@networkno.de>,  linux-mips@linux-mips.org, richard@codesourcery.com
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
References: <20050707091937Z8226163-3678+1737@linux-mips.org>
	<Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl>
	<20050707121235.GV1645@hattusa.textio>
	<Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl>
	<20050707122226.GW1645@hattusa.textio>
	<Pine.LNX.4.61L.0507071356450.3205@blysk.ds.pg.gda.pl>
	<20050707162959.GQ2822@linux-mips.org>
Date:	Fri, 08 Jul 2005 14:42:38 +0100
In-Reply-To: <20050707162959.GQ2822@linux-mips.org> (Ralf Baechle DL5RB's
	message of "Thu, 7 Jul 2005 17:29:59 +0100")
Message-ID: <87zmsx4do1.fsf@talisman.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <richard@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@codesourcery.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle DL5RB <ralf@linux-mips.org> writes:
> -EB / -EL are traditionally the options that all MIPS compilers including
> non-gcc compilers, seem to support.

Right.  I've always thought of them as the canonical options for gcc
as well.  I think the only reason internal compilers like cc1 have
-mel and -meb is because gcc's target options system has traditionally
required every target option to begin with "-m".  (That's no longer
a restriction in 4.1 FWIW.)

So contrary to what was said upthread, I've always treated
the omission of these options from invoke.texi as deliberate.
They're really internal compiler flags rather than user flags.
You should use -EL and -EB instead.

Richard
