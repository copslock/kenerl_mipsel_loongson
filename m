Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3AEDWx05528
	for linux-mips-outgoing; Tue, 10 Apr 2001 07:13:32 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3AEAEM05463
	for <linux-mips@oss.sgi.com>; Tue, 10 Apr 2001 07:10:16 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA03298;
	Tue, 10 Apr 2001 16:08:26 +0200 (MET DST)
Date: Tue, 10 Apr 2001 16:08:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: linux-mips@oss.sgi.com
Subject: Re: glibc 2.2.2 include problems
In-Reply-To: <20010410151449.A14014@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010410155641.19129E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 10 Apr 2001, Florian Lohoff wrote:

> i am seeing problems on the glibc 2.2.2 headers - Anyone sees the same ?
> 
> gcc -c -DLOCALEDIR=\"/usr/share/locale\" -DGNULOCALEDIR=\"/usr/share/locale\" -DLOCALE_ALIAS_PATH=\"/usr/share/locale:.\" -DHAVE_CONFIG_H -I.. -I. -I../intl -I../lib -DNSL_FORK -O2 -DLINUX -D_GNU_SOURCE   loadmsgcat.c
> In file included from /usr/include/fcntl.h:37,
>                  from loadmsgcat.c:22:
> /usr/include/sys/stat.h:352: redefinition of `stat'
> /usr/include/sys/stat.h:345: `stat' previously defined here
> 
> This is while compiling lynx - The lines in the header are these:
[...]
> I dont really see the problem.

 Replace "-c" with "-E -dD" in the above gcc invocation and check if lynx
doesn't do anything weird (such as defining lstat to stat or so).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
