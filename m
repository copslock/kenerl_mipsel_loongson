Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DB50608342
	for linux-mips-outgoing; Wed, 13 Jun 2001 04:05:00 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DB4uP08326;
	Wed, 13 Jun 2001 04:04:56 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 678AE7D9; Wed, 13 Jun 2001 13:04:54 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 34FA042C5; Wed, 13 Jun 2001 12:56:10 +0200 (CEST)
Date: Wed, 13 Jun 2001 12:56:10 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Raoul Borenius <borenius@shuttle.de>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010613125610.A18235@paradigm.rfc822.org>
References: <20010611000359.A25631@paradigm.rfc822.org> <20010611064249.A15039@bacchus.dhis.org> <20010611165019.A17263@bunny.shuttle.de> <20010612120927.B8798@paradigm.rfc822.org> <20010612135306.A26214@bacchus.dhis.org> <20010613100602.A17124@bunny.shuttle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010613100602.A17124@bunny.shuttle.de>; from borenius@shuttle.de on Wed, Jun 13, 2001 at 10:06:02AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 13, 2001 at 10:06:02AM +0200, Raoul Borenius wrote:
> Hi,
> 
> On Tue, Jun 12, 2001 at 01:53:06PM +0200, Ralf Baechle wrote:
> > On Tue, Jun 12, 2001 at 12:09:27PM +0200, Florian Lohoff wrote:
> > 
> > > I got a hint that it might be the compile to produce this bug - I was
> > > suggested to use some gcc 3.0 prerelease. I now checked again and i am
> > > already using some gcc 3.0
> > 
> > It's not a tool related bug but a genuine kernel bug in our semaphore code.
> > Which - unfortunately is a bit of headache to fix but is more or less the #1
> > on the list of my instabilities right now.
> 
> Thanx for the quick response. Just to confirm that, here is the same crash
> with the kernel from
> 
> ftp://ftp.rfc822.org/pub/local/debian-mips/kernel/kernel-image-2.4.3-ip22-r4k.tgz
> 
> Using ksymoops gave a lot of warnings this time. Don't know why, the
> System.map should be the right one (it's out of
> kernel-image-2.4.3-ip22-r4k.tgz).

This is because the system map has been generated with newer binutils
which always dump the addresses as 64Bit addresses. Load the system
map into an text editor and delete the first ffffffff from the
addresses 1,$ s/^ffffffff//

> Warning (compare_maps): mismatch on symbol EISA_bus  , ksyms_base says 88162b44, System.map says ffffffff88162b44.  Ignoring ksyms_base entry
> Warning (compare_maps): mismatch on symbol ROOT_DEV  , ksyms_base says 881711e8, System.map says ffffffff881711e8.  Ignoring ksyms_base entry
> Warning (compare_maps): mismatch on symbol ___strtok  , ksyms_base says 88194d68, System.map says ffffffff88194d68.  Ignoring ksyms_base entry
> Warning (compare_maps): mismatch on symbol ___wait_on_page  , ksyms_base says 88032a20, System.map says ffffffff88032a20.  Ignoring ksyms_base entry
> Warning (compare_maps): mismatch on symbol __alloc_pages  , ksyms_base says 8803de98, System.map says ffffffff8803de98.  Ignoring ksyms_base entry
> Warning (compare_maps): mismatch on symbol __bforget  , ksyms_base says 880472b8, System.map says ffffffff880472b8.  Ignoring ksyms_base entry

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
