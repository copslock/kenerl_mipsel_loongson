Received:  by oss.sgi.com id <S553765AbQJNK6a>;
	Sat, 14 Oct 2000 03:58:30 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:59664 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553721AbQJNK6Y>;
	Sat, 14 Oct 2000 03:58:24 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1A0087FA; Sat, 14 Oct 2000 12:58:20 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id DC1FE900C; Sat, 14 Oct 2000 12:57:10 +0200 (CEST)
Date:   Sat, 14 Oct 2000 12:57:10 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Jun Sun <jsun@mvista.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001014125710.B1536@paradigm.rfc822.org>
References: <39E7EB73.9206D0DB@mvista.com> <20001014055550.B3816@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001014055550.B3816@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Oct 14, 2000 at 05:55:50AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 05:55:50AM +0200, Ralf Baechle wrote:
> On Fri, Oct 13, 2000 at 10:13:23PM -0700, Jun Sun wrote:
> > c) What about those patches at the same ftp sites (v2.8.x)?
> > 
> > ftp://oss.sgi.com/pub/linux/mips/binutils/
> 
> Still recommended because we can't yet be sure that binutils-cvs are
> kosher yet.  For example it's suspect that I can't build Emacs.  Might
> be something else but in case of doubt binutils are the suspect ...

If its only emacs - I am happy :)

> > d) Andreas said the current development version 2.96 worked - with the
> > later binutils and gcc.
> 
> Plus above mentioned constructor patch.
> 
> Seems to work reasonably well.

For everything non glibc 2.2

> > ftp://ftp.place.org/pub/nop/linuxce/
> > ftp://ftp.place.org/pub/nop/linuxce/rpms/glibc-2.0.7-20.src.rpm
> 
> 2.0.7 has resulted in so many bug reports that I consider to plain dump any
> related reports in the future.

Ack

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
