Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49CNb122319
	for linux-mips-outgoing; Wed, 9 May 2001 05:23:37 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49CNWF22312;
	Wed, 9 May 2001 05:23:32 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id HAA25101;
	Wed, 9 May 2001 07:22:58 -0500
Message-ID: <3AF934AE.38AB0089@cotw.com>
Date: Wed, 09 May 2001 07:14:38 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre17-idepci i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: Tom Appermont <tea@sonycom.com>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
References: <20010505144708.A12575@paradigm.rfc822.org> <20010507163210.B2381@bacchus.dhis.org> <20010508202518.A13476@paradigm.rfc822.org> <20010508214313.A12528@bacchus.dhis.org> <20010509095955.A8392@sonycom.com> <20010509104635.D12267@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Florian Lohoff wrote:
> 
> > > The whole point was to switch from our IRIX ELF flavoured binaries to
> > > standard ABI ELF.  These two variants are close but not identical which
> > > for example made modutils missbehave.
> >
I will expound a bit more. When I made the changes to fix binutils and switch
us from the IRIX to ABI ELF flavoured binaries the default target names
changed from 'elf[32|64][little|big]mips' to 'elf[32|64]trad[little|big]mips'
in binutils. This has the effect of breaking linker scripts but not a whole
lot else. These will be the new targets for MIPS/Linux work. Binaries should
still run just fine if you compile glibc-2.2.2 with the old or new tools.
Future work though should use the 'elf[32|64]trad[little|big]mips' targets.

> > What is the current status on this? The patches for the tools are already
> > integrated in their cvs trees (right?). But I don't think everybody was
> > happy with this in the end, aspecially the people wearing debian hats.
> > Is anybody working on a solution, or are we waiting for the debian people
> > to rebuild all the packages?
> 
You bet your ass they are in CVS. The Debian MIPS people? That would be Flo
and Jason M. I believe. I'm getting ready to start a flame war (well I hope
not, but it has potential) on the debian-mips list right after this email.
You might want to hop up there and read that if you are interested.

> I'll lean back, continue building .debs and wait for others to fix it.
>
And this is the problem Flo. Hop up to debian-mips and lets talk.

-Steve 

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
