Received:  by oss.sgi.com id <S553661AbQK2Flj>;
	Tue, 28 Nov 2000 21:41:39 -0800
Received: from c461218-a.frmt1.sfba.home.com ([24.1.69.78]:30217 "EHLO
        gateway.junsun.net") by oss.sgi.com with ESMTP id <S553653AbQK2FlM>;
	Tue, 28 Nov 2000 21:41:12 -0800
Received: (from jsun@localhost)
	by gateway.junsun.net (8.9.3/8.9.3) id VAA09889;
	Tue, 28 Nov 2000 21:41:11 -0800
Date:   Tue, 28 Nov 2000 21:41:11 -0800
From:   Jun Sun <jsun@junsun.net>
To:     linux-mips@oss.sgi.com
Subject: cross-compile tools made easy ...
Message-ID: <20001128214111.B9875@gateway.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I found myself building cross-compile toolchains a lot recently.  So I 
spent sometime and wrote a script to do the whole darn thing in one shot.  

If you want to build your own cross-compile tools, you can save some
effort by just getting the tar balls and then typing "build".

It is not too much different from what is in Ralf's "Linux MIPS HOW-TO" 
cross-compile section.  But the tarball offers some convenience by having 
all the sources and patches put together and all configurations, options 
lumped in one file.

You can find two tar balls at linux.junsun.net:

mips-xtool-1.1.tar.gz
	binutils 2.8.1 + egcs 1.1.2 + glibc 2.0.6
	(Thanks to Keith Wesolows for the glibc fix with egcs 1.1.2)

mips-xtool-0.1.tar.gz
	binutils 2.8.1 + egcs 1.0.3a + glibc 2.0.6


I did some minimal tests with kernel and building a couple of packages,
and would very much like to know if you have any problems (Yes, that is
the purpose. :-0)
 
Enjoy!

Jun 
