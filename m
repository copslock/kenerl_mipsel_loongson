Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49CRvJ22595
	for linux-mips-outgoing; Wed, 9 May 2001 05:27:57 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49CRoF22590;
	Wed, 9 May 2001 05:27:50 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 2E2281E24E; Wed,  9 May 2001 14:27:49 +0200 (MEST)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
Mail-Copies-To: never
To: sjhill@cotw.com
Cc: Florian Lohoff <flo@rfc822.org>, Tom Appermont <tea@sonycom.com>,
   Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
References: <20010505144708.A12575@paradigm.rfc822.org>
	<20010507163210.B2381@bacchus.dhis.org>
	<20010508202518.A13476@paradigm.rfc822.org>
	<20010508214313.A12528@bacchus.dhis.org>
	<20010509095955.A8392@sonycom.com>
	<20010509104635.D12267@paradigm.rfc822.org>
	<3AF934AE.38AB0089@cotw.com>
From: Andreas Jaeger <aj@suse.de>
Date: 09 May 2001 14:27:39 +0200
In-Reply-To: <3AF934AE.38AB0089@cotw.com> ("Steven J. Hill"'s message of "Wed, 09 May 2001 07:14:38 -0500")
Message-ID: <hoeltyemh0.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Steven J. Hill" <sjhill@cotw.com> writes:

> Florian Lohoff wrote:
> > 
> > > > The whole point was to switch from our IRIX ELF flavoured binaries to
> > > > standard ABI ELF.  These two variants are close but not identical which
> > > > for example made modutils missbehave.
> > >
> I will expound a bit more. When I made the changes to fix binutils and switch
> us from the IRIX to ABI ELF flavoured binaries the default target names
> changed from 'elf[32|64][little|big]mips' to 'elf[32|64]trad[little|big]mips'
> in binutils. This has the effect of breaking linker scripts but not a whole
> lot else. These will be the new targets for MIPS/Linux work. Binaries should
> still run just fine if you compile glibc-2.2.2 with the old or new tools.
> Future work though should use the 'elf[32|64]trad[little|big]mips' targets.

Ok, I finally understand.  Can you send a new patch for glibc with an
update for the FAQ?  I'll add it this time.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
