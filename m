Received:  by oss.sgi.com id <S553839AbQJ3DYl>;
	Sun, 29 Oct 2000 19:24:41 -0800
Received: from u-4.karlsruhe.ipdial.viaginterkom.de ([62.180.19.4]:32522 "EHLO
        u-4.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S553783AbQJ3DYS>; Sun, 29 Oct 2000 19:24:18 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869077AbQJ3DXr>;
        Mon, 30 Oct 2000 04:23:47 +0100
Date:   Mon, 30 Oct 2000 04:23:46 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: [ANNOUNCE] glibc 2.2 (2.1.95) debian packages available
Message-ID: <20001030042346.A21748@bacchus.dhis.org>
References: <20001027121802.B3541@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001027121802.B3541@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Oct 27, 2000 at 12:18:02PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 27, 2000 at 12:18:02PM +0200, Florian Lohoff wrote:

> It seems that the incompatibility problems i had with previous versions
> concerning bash are gone. I am able to compile a 2.2 bash in the chroot
> populated with the glibc 2.2 and 2.0 binarys ( And it also works ).

There was a bug in the generic code of 2.2 which I recently fixed.  Since
then I have at least 99% compatibility with old binaries.

> It seems there is a bug in bash concerning non-existance of /proc 
> which will cause my bash to segfault but mounting proc in the chroot
> solves this.

Upgrade your libc or fix it yourself, it's trivial.  <sys/syscalls.h> needs
to include <asm/unistd.h>.  This will also fix mysterious compile problems
of the adjtime package.

  Ralf
