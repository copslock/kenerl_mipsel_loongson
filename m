Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA17308; Thu, 18 Jul 1996 06:39:14 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA19991 for linux-list; Thu, 18 Jul 1996 13:39:06 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA19979 for <linux@cthulhu.engr.sgi.com>; Thu, 18 Jul 1996 06:39:05 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA17302; Thu, 18 Jul 1996 06:39:05 -0700
Date: Thu, 18 Jul 1996 06:39:05 -0700
Message-Id: <199607181339.GAA17302@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: har har har
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hacking GNU libc is fun, wheee...

gnu-libc/string/string.h:

/* Find the first occurence of NEEDLE in HAYSTACK.
   NEEDLE is NEEDLELEN bytes long;
   HAYSTACK is HAYSTACKLEN bytes long.  */
extern __ptr_t memmem __P ((__const __ptr_t __haystack, size_t __haystacklen,
			    __const __ptr_t __needle, size_t __needlelen));

/* Sautee STRING briskly.  */
extern char *strfry __P ((char *__string));

/* Frobnicate N bytes of S.  */
extern __ptr_t memfrob __P ((__ptr_t __s, size_t __n));

----------------------------------------------////
Yow! 233 microsecond remote host TCP latency ---- beat that
--------------------------------------------////__________  o
David S. Miller, dm@engr.sgi.com           /_____________/ / // /_/ ><
