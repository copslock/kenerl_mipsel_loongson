Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3ADF9n04169
	for linux-mips-outgoing; Tue, 10 Apr 2001 06:15:09 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3ADF7M04162
	for <linux-mips@oss.sgi.com>; Tue, 10 Apr 2001 06:15:07 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5D43D7F8; Tue, 10 Apr 2001 15:15:05 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5DE01F385; Tue, 10 Apr 2001 15:14:49 +0200 (CEST)
Date: Tue, 10 Apr 2001 15:14:49 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: glibc 2.2.2 include problems
Message-ID: <20010410151449.A14014@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,
i am seeing problems on the glibc 2.2.2 headers - Anyone sees the same ?

gcc -c -DLOCALEDIR=\"/usr/share/locale\" -DGNULOCALEDIR=\"/usr/share/locale\" -DLOCALE_ALIAS_PATH=\"/usr/share/locale:.\" -DHAVE_CONFIG_H -I.. -I. -I../intl -I../lib -DNSL_FORK -O2 -DLINUX -D_GNU_SOURCE   loadmsgcat.c
In file included from /usr/include/fcntl.h:37,
                 from loadmsgcat.c:22:
/usr/include/sys/stat.h:352: redefinition of `stat'
/usr/include/sys/stat.h:345: `stat' previously defined here

This is while compiling lynx - The lines in the header are these:

/usr/include/sys/stat.h
    340 #if defined __GNUC__ && __GNUC__ >= 2
    341 /* Inlined versions of the real stat and mknod functions.  */
    342
    343 extern __inline__ int stat (__const char *__path,
    344                             struct stat *__statbuf) __THROW
    345 { 
    346   return __xstat (_STAT_VER, __path, __statbuf);
    347 }
    348
    349 # if defined __USE_BSD || defined __USE_XOPEN_EXTENDED
    350 extern __inline__ int lstat (__const char *__path,
    351                              struct stat *__statbuf) __THROW
    352 { 
    353   return __lxstat (_STAT_VER, __path, __statbuf);
    354 }
    355 # endif

I dont really see the problem.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
