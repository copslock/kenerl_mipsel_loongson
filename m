Received:  by oss.sgi.com id <S305167AbQBTTXg>;
	Sun, 20 Feb 2000 11:23:36 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:12135 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305162AbQBTTXV>;
	Sun, 20 Feb 2000 11:23:21 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA26229; Sun, 20 Feb 2000 11:18:50 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA54276; Sun, 20 Feb 2000 11:22:51 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA36296
	for linux-list;
	Sun, 20 Feb 2000 11:11:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA97253
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 20 Feb 2000 11:11:26 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from pop01.chello.be (phoenix.chello.be [195.162.196.23]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA06859
	for <linux@cthulhu.engr.sgi.com>; Sun, 20 Feb 2000 11:11:26 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from callisto.of.borg ([195.162.216.83]) by pop01.chello.be
          (InterMail vK.4.02.00.00 201-232-116 license f891beffebad5da1b2ebd034a97f2710)
          with ESMTP id <20000220191120.MFSQ15382.pop01@callisto.of.borg>;
          Sun, 20 Feb 2000 20:11:20 +0100
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian/GNU) with ESMTP id UAA03014;
	Sun, 20 Feb 2000 20:11:20 +0100
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Sun, 20 Feb 2000 20:11:19 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Marc Esipovich <marc@mucom.co.il>, brett <brett@madhouse.org>,
        Bruce Leggett <bleggett@sofamordanek.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Linux on O2?
In-Reply-To: <20000220001445.B23993@uni-koblenz.de>
Message-ID: <Pine.LNX.4.05.10002202009380.786-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, 20 Feb 2000, Ralf Baechle wrote:
> On Sat, Feb 19, 2000 at 06:30:22AM -0200, Marc Esipovich wrote:
> 
> > > > Im still wainting to hear anything about the indigo i hear alot of talk
> > > > about the indigo2 but nothing about the original blue boxes
> > > 
> > > The problem is that the origin docs are gone by now and SGI can't
> > > just go and ship the IRIX source to hackers ...
> > 
> > Wow, what do you mean gone by now?  are you saying there's no chance in
> > hell to obtain the documentation?  it can't be gone.
> 
> Remember that SGI is a company that designs a large fraction of a system.
> So the designers of some piece of hardware and it's direct users, the
> kernel programmers have close to each other.  For a lot of chips
> documentation never is written or at least never the same way so it would
> be the case for chips that would be marketed as such.  It's obvious that
> this isn't good at all for Free Software where the access to high
> quality documentation is crucial.
> 
> So now imagine what has happened to all the knowledge about a machine
> during the decade after it was developed?  The product's development
> finishes, it get's marketed, the OS for gets some final bugfixes and
> even later it gets phased out.  Silence.  Meanwhile the brains behind
> the machine leave the company, tapes and paper go to some dark room
> where nobody still remembers them and the machine gets forgotten.
> 
> Slow death of a computer ...

Unrelated, but similar: I'd like to port Linux/m68k to the Tektronix XP21
X-terminal I have. It has a 68030, TMS34020 and NE2000 Ethernet, but where do
you find docs? Tektronix has sold their X-terminal division to NCD.

If a machine is older than the web, AltaVista won't help you neither.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
