Received:  by oss.sgi.com id <S553752AbRCDWRE>;
	Sun, 4 Mar 2001 14:17:04 -0800
Received: from u-155-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.155]:4612
        "EHLO u-155-18.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553747AbRCDWQg>; Sun, 4 Mar 2001 14:16:36 -0800
Received: from dea ([193.98.169.28]:21376 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S867055AbRCDWQX>;
	Sun, 4 Mar 2001 23:16:23 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f24MFYY18180;
	Sun, 4 Mar 2001 23:15:34 +0100
Date:	Sun, 4 Mar 2001 23:15:34 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Karsten Merker <karsten@excalibur.cologne.de>
Cc:	linux-mips@oss.sgi.com
Subject: Re: build-problems: GNU fileutils 4.01 on mipsel with glibc 2.2.2
Message-ID: <20010304231534.B17775@bacchus.dhis.org>
References: <20010304213609.B25825@linuxtag.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010304213609.B25825@linuxtag.org>; from karsten@excalibur.cologne.de on Sun, Mar 04, 2001 at 09:36:09PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Mar 04, 2001 at 09:36:09PM +0100, Karsten Merker wrote:

> I am trying to get the components for a Debian mipsel-base.tgz built,
> based on glibc-2.2.2. I am working in a chroot()-environment, where I have
> installed glibc 2.2.2, binutils 2.10.91 and gcc 2.95.3 as precompiled
> binaries, all from Maciej's packages (glibc-2.2.2-2.mipsel.rpm,
> gcc-2.95.3-14.mipsel.rpm, binutils-2.10.91-1.mipsel.rpm plus devel and
> dependency packages). Gawk and perl are self-compiled inside the
> chroot()-environment. When trying to compile fileutils, the ./configure
> starts ok, but when coming to "checking for working mktime..." the script
> just hangs forever, and according to top there is nothing consuming CPU
> time (except for top itself). Compiling the fileutils on the "host
> system", i.e. outside the chroot()-environment using egcs-1.0.3a and
> glibc-2.0.6 the problem does not appear. Can anybody confirm this on
> another system? Any ideas what can be the reason for this?

Does you chroot environment have a mounted /proc filesystem?  In the past
we had obscure libc bugs which were triggered when /proc were not
mounted.

  Ralf
