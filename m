Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6T8YkW10679
	for linux-mips-outgoing; Sun, 29 Jul 2001 01:34:46 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6T8YiV10674
	for <linux-mips@oss.sgi.com>; Sun, 29 Jul 2001 01:34:44 -0700
Received: from scotty.mgnet.de (pD90247AA.dip.t-dialin.net [217.2.71.170])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id KAA00479
	for <linux-mips@oss.sgi.com>; Sun, 29 Jul 2001 10:34:42 +0200 (MET DST)
Received: (qmail 19169 invoked from network); 29 Jul 2001 08:34:41 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 29 Jul 2001 08:34:41 -0000
Date: Sun, 29 Jul 2001 10:34:41 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Erich Schubert <erich.schubert@mucl.de>,
   Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Sound on SGI Indy?
In-Reply-To: <20010728230132.B13030@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.21.0107291031490.397-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 28 Jul 2001, Ralf Baechle wrote:

> On Wed, Jul 25, 2001 at 11:59:24PM +0200, Erich Schubert wrote:
> 
> > did anyone get sound to run on a Indy?
> > As far as i've read, alsa does contain drivers which should play sound
> > correctly.
> > 
> > So i checked out current cvs kernel, compiled it, compiled alsa and
> > tried to load the modules - and got a kernel oops.
> 
> You made sure you have latest binutils and modutils?

Don't waste the time ... current cvs will _never_ support the old
alsa modules.
I'm working on getting the ALSA stuff to work, but it's not too easy
and currently the Power Supply Fan of my workstation is broken so
I need to get a new one first and then we'll see ...
Also one of the problems is finding a working current cvs kernel ;)

> > Can someone point me to some recent information about sound on sgi indy?
> Ulf said the ALSA driver is entirely out of date.

I think I once got it to work a bit under 2.2.10 or something like that.
Everything newer, like 2.4 is a big no no.

Hmmm, my Power Supply smells again ... cu later guys

		Bye, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
