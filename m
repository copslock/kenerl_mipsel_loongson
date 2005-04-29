Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2005 07:51:29 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:44846
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225576AbVD2GvN>; Fri, 29 Apr 2005 07:51:13 +0100
Received: (qmail 4739 invoked by uid 210); 29 Apr 2005 16:51:03 +1000
Received: from 127.0.0.1 by www (envelope-from <stuartl@longlandclan.hopto.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(127.0.0.1):. 
 Processed in 0.542765 secs); 29 Apr 2005 06:51:03 -0000
Received: from unknown (HELO mail.longlandclan.hopto.org) (127.0.0.1)
  by 127.0.0.1 with SMTP; 29 Apr 2005 16:51:02 +1000
Received: from 131.181.46.15
        (SquirrelMail authenticated user stuartl)
        by mail.longlandclan.hopto.org with HTTP;
        Fri,
      29 Apr 2005 06:51:02 -0000 (Local time zone must be set--see zic 
     manual page)
Message-ID: <57961.131.181.46.15.1114757462.squirrel@mail.longlandclan.hopto.org>
In-Reply-To: <015301c54c01$9b8e4e00$3c67a8c0@netsity.com>
References: <015301c54c01$9b8e4e00$3c67a8c0@netsity.com>
Date:	Fri,
      29 Apr 2005 06:51:02 -0000 (Local time zone must be set--see zic 
     manual page)
Subject: Re: GD Library on MIPS Processor
From:	"Stuart Longland" <stuartl@longlandclan.hopto.org>
To:	"Inpreet Singh" <Singh.Inpreet@netsity.com>
Cc:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3
Importance: Normal
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Okay, before I start... can you please turn off HTML message composition?
Some users here don't take kindly to HTML email. ;-)

> Sir I am using gd library on Linux intel processor sucessfully but now I
> want to do same on MIPS. I don't know to how install, configure and test
> gd library on MIPS. Sir please give me some clue or link to study for
> the same.
>
> I tried to configure gd library compilation using following command from
> linux intel processor:
>
> ./configure --host=mips

Try ./configure --host=mips-unknown-linux-gnu (or mips-unknown-linux-uclibc if
you use µClibc).  Setting --build and --target may help too.

> and it makes Makefile with some differences
> ***************************************************
> host_triplet = mips-unknown-elf
> host = mips-unknown-elf
> host_alias = mips
> host_cpu = mips
> ***************************************************
> Now I tried to build a example using this Makefile "make gddemo". What I
> expect that it will create gddemo binary that will output in correctly
> on MIPS processor. But when I run this binary on MIPS it is showing
> errors.
> **************************************************************
> /launchpad # ./gddemo
> ./gddemo: 1: Syntax error: "(" unexpected
> **************************************************************

I'm not sure what's going on there... but I'd presume it's related to the
wrong `host` option being set.

Also, make sure you run the compiled binaries on the MIPS machine... they
won't work on x86 (you'll get a "cannot execute binary file" error message).

> Also I have downloaded debian packages for gd library on MIPS processor
> but don't know how to install them. I tried dpkg command but it shows no
> such command. So sir please help me out.
> So please help me how should I proceed.

That's odd.  Do you have Debian installed correctly on the MIPS machine?  What
version/distribution did you install?

- --
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCcdkpuarJ1mMmSrkRAlt0AJ97SkR+SDtpVXiU1KzhWvSLFLTJIgCfQyFO
n8aKAVeZBTUPKhHm8NAvxAY=
=1oRI
-----END PGP SIGNATURE-----
