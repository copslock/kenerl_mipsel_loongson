Received:  by oss.sgi.com id <S553752AbQJQO3E>;
	Tue, 17 Oct 2000 07:29:04 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:38672 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553709AbQJQO2z>;
	Tue, 17 Oct 2000 07:28:55 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 551E094A; Tue, 17 Oct 2000 16:28:52 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C9ACF900C; Tue, 17 Oct 2000 16:27:24 +0200 (CEST)
Date:   Tue, 17 Oct 2000 16:27:24 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Re: base.tgz
Message-ID: <20001017162724.H4890@paradigm.rfc822.org>
References: <20001016043346.A6656@lug-owl.de> <20001017041449.A17546@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001017041449.A17546@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Oct 17, 2000 at 04:14:50AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 17, 2000 at 04:14:50AM +0200, Jan-Benedict Glaw wrote:

> Packages which seem to be not used/useable. They'll not be included:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Package: console-tools-libs
> Package: fbset
> Package: fdflush
> Package: fdutils
> Package: isapnptools
> Package: lilo
> Package: mbr
> Package: pciutils
> Package: pump
> Package: syslinux
> Package: xviddetect
> Package: pcmcia-cs

We should include them without syslinux, lilo, mbr which
are i386 specific. All others might need some special
hacking ...

> Packages which are broken in some way right now:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Package: debconf-tiny (not found)
> Package: bsdutils (not found)
  from util-linux

> Package: libc6 (will use converted 206-5 rpm)
> Package: libnewt0 (not found, will use newt-0.40-9.rpm)
> Package: libstdc++2.10 (not found)

> Package: locales (not found)
 This is glibc ...

> Package: mount (not found, will take mount-2.9o-1.rpm)
  from util-linux
> Package: util-linux (not found, will take util-linux-2.7-19.rpm)
  from util-linux

The util-linux stuff is tricky - I have made a debian-mips package
from it using wesolows patches - The packages are at
ftp://ftp.rfc822.org/pub/local/debian-mips/temp-packages

One could easily build these for mipsel ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
