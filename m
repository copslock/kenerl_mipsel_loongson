Received:  by oss.sgi.com id <S553785AbQJ0KTj>;
	Fri, 27 Oct 2000 03:19:39 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:15 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553761AbQJ0KTR>;
	Fri, 27 Oct 2000 03:19:17 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 15A4292A; Fri, 27 Oct 2000 12:19:11 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id DDDB7900C; Fri, 27 Oct 2000 12:18:02 +0200 (CEST)
Date:   Fri, 27 Oct 2000 12:18:02 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: [ANNOUNCE] glibc 2.2 (2.1.95) debian packages available
Message-ID: <20001027121802.B3541@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
yesterday i managed to get glibc 2.2 debian source packages to compile
under mips - I used cvs gcc 20001007 and binutils of the same date
including 2 patches for gcc. 

For glibc i used the default debian source package 2.1.95 + 2 patches
concerning dl-machine.h - One from the cvs and one from oss.sgi.com.

Packages are available at 

ftp://ftp.rfc822.org/pub/local/debian-mips/glibc

It seems that the incompatibility problems i had with previous versions
concerning bash are gone. I am able to compile a 2.2 bash in the chroot
populated with the glibc 2.2 and 2.0 binarys ( And it also works ).

It seems there is a bug in bash concerning non-existance of /proc 
which will cause my bash to segfault but mounting proc in the chroot
solves this.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
