Received:  by oss.sgi.com id <S553850AbQJNSE5>;
	Sat, 14 Oct 2000 11:04:57 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:9735 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553845AbQJNSEn>;
	Sat, 14 Oct 2000 11:04:43 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B369E7F8; Sat, 14 Oct 2000 20:04:41 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 17600900C; Sat, 14 Oct 2000 20:03:37 +0200 (CEST)
Date:   Sat, 14 Oct 2000 20:03:37 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: Re: delo 0.1 / Decstation Boot Loader
Message-ID: <20001014200337.D1598@paradigm.rfc822.org>
References: <20001014133502.A1685@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001014133502.A1685@paradigm.rfc822.org>; from flo@rfc822.org on Sat, Oct 14, 2000 at 01:35:02PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 01:35:02PM +0200, Florian Lohoff wrote:
> Hi,
> i started to hack on a Decstation bootloader - It is currently
> not booting anything but i thought of letting you know.
> 
> I put the stuff i already have at
> 
> ftp://ftp.rfc822.org/pub/local/debian-mipsel/experimental
> 
> And it is called "delo" - The Decstation Loader - It is loosly
> designed like "SILO" the Sparc Loader.

Update

delo 0.2 is up and running

I booted Debian GNU/Linux/Mips/Decstation multiple times on
my 5000/260 - delo is now able to read an ELF kernel from
the first partition on the disk, copy the sections to the
right locations and run it at e_entry.

The TODO list is getting shorter - Biggest problem i right now
see is crashes of the resulting kernel - But only when disabling
DEBUG output - I think there are some alignment issues.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
