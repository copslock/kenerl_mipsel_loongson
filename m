Received:  by oss.sgi.com id <S42192AbQJHQuH>;
	Sun, 8 Oct 2000 09:50:07 -0700
Received: from u-43.karlsruhe.ipdial.viaginterkom.de ([62.180.18.43]:6404 "EHLO
        u-43.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S42188AbQJHQts>; Sun, 8 Oct 2000 09:49:48 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870070AbQJHPvx>;
        Sun, 8 Oct 2000 17:51:53 +0200
Date:   Sun, 8 Oct 2000 17:51:53 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: ld & glibc
Message-ID: <20001008175153.A1314@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Please don't use a ld >= 2.9.x.  I've tracked down a bug in those linkers
fixing which unless you're lucky breaks binary compatibility with binaries
generated by those linkers; there is no way to guaratee compatibility
with the binaries generated by these linkers so the breakage is
unavoidable.  In short - fingers away.

glibc-2.0.6-6lm was a release made in the erroneous assumption that this
linker bug is actually a bug in 2.8.1.  Now it tourned out to be just the
other way around.

Users of glibc-2.0.6-6lm should rebuild all binaries built with affected
linkers with a fixed linker before they downgrade their libc to
glibc-2.0.6-5lm.

Glibc 2.2 based systems have entirely been built using some broken linker.
In effect this means that they will have to be completly rebuilt with a
fixed linker.

Fix comes later ...

  Ralf
