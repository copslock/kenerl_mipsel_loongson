Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6SL2BZ30886
	for linux-mips-outgoing; Sat, 28 Jul 2001 14:02:11 -0700
Received: from dea.waldorf-gmbh.de (u-135-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.135])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6SL22V30853
	for <linux-mips@oss.sgi.com>; Sat, 28 Jul 2001 14:02:03 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6SL1WS18790;
	Sat, 28 Jul 2001 23:01:32 +0200
Date: Sat, 28 Jul 2001 23:01:32 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Erich Schubert <erich.schubert@mucl.de>
Cc: Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Sound on SGI Indy?
Message-ID: <20010728230132.B13030@bacchus.dhis.org>
References: <20010725235924.A2124@erich.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010725235924.A2124@erich.xmldesign.de>; from erich.schubert@mucl.de on Wed, Jul 25, 2001 at 11:59:24PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 25, 2001 at 11:59:24PM +0200, Erich Schubert wrote:

> did anyone get sound to run on a Indy?
> As far as i've read, alsa does contain drivers which should play sound
> correctly.
> 
> So i checked out current cvs kernel, compiled it, compiled alsa and
> tried to load the modules - and got a kernel oops.

You made sure you have latest binutils and modutils?

> Can someone point me to some recent information about sound on sgi indy?

Ulf said the ALSA driver is entirely out of date.

  Ralf
