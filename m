Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA63600 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Feb 1999 00:07:19 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA90121
	for linux-list;
	Wed, 10 Feb 1999 00:06:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA94796
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Feb 1999 00:06:21 -0800 (PST)
	mail_from (uchac@pvt.net)
Received: from cbu.pvtnet.cz (cbu.pvtnet.cz [194.149.105.18]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA07050
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Feb 1999 00:06:18 -0800 (PST)
	mail_from (uchac@pvt.net)
Received: from pvt.net (popelka.pvt.net [194.149.101.115])
	by cbu.pvtnet.cz (8.9.2/8.9.1) with ESMTP id JAA30188
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Feb 1999 09:13:06 +0100 (MET)
Message-ID: <36C13DF3.9F9F45AE@pvt.net>
Date: Wed, 10 Feb 1999 09:06:11 +0100
From: Radim Uchac <uchac@pvt.net>
Organization: http://www.pvt.net
X-Mailer: Mozilla 4.5 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: mysql-3.22.16a-gamma
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


hi, 
I'm trying to compile mysql-3.22.16a-gamma but when I run script
./configure
I obtain:

*************************************
checking whether struct tm is in sys/time.h or time.h... time.h
checking size of char... 0
configure: error: No size for char type.
A likely cause for this could be that there isn't any
static libraries installed. You can verify this by checking if you have
libm.a
in /lib, /usr/lib or some other standard place.  If this is the problem,
install the static libraries and try again.  If this isn't the problem,
examine config.log for possible errors.  If you want to report this, use
'scripts/mysqlbug' and include at least the last 20 rows from
config.log!
****************************************

of course libm.a is in /usr/lib :-(

and in config.log is:

**********************************************
configure:4187: checking for size_t
configure:4220: checking for st_rdev in struct stat
configure:4233: gcc -c -O6   -DDBUG_OFF  conftest.c 1>&5
configure:4254: checking whether time.h and sys/time.h may both be
included
configure:4268: gcc -c -O6   -DDBUG_OFF  conftest.c 1>&5
configure:4289: checking whether struct tm is in sys/time.h or time.h
configure:4302: gcc -c -O6   -DDBUG_OFF  conftest.c 1>&5
configure:4325: checking size of char
configure:4344: gcc -o conftest -O6   -DDBUG_OFF   -rdynamic conftest.c
-lnsl -lm   -lcrypt  -lpthread 1>&5
/usr/lib/libpthread.so: undefined reference to `__libc_accept'
/usr/lib/libpthread.so: undefined reference to `__libc_send'
/usr/lib/libpthread.so: undefined reference to `__libc_recvfrom'
/usr/lib/libpthread.so: undefined reference to `__libc_recvmsg'
/usr/lib/libpthread.so: undefined reference to `__libc_sendmsg'
/usr/lib/libpthread.so: undefined reference to `__libc_recv'
/usr/lib/libpthread.so: undefined reference to `__libc_sendto'
/usr/lib/libpthread.so: undefined reference to `__libc_connect'
configure: failed program was:
#line 4333 "configure"
#include "confdefs.h"
#include <stdio.h>
main()
{
  FILE *f=fopen("conftestval", "w");
  if (!f) exit(1);
  fprintf(f, "%d\n", sizeof(char));
  exit(0);
}
**************************************************

could you help me.
thanks
radim


**************************************************************
Radim Uchac                           e-mail:    uchac@pvt.net
PVT a.s.                              tel:     +420-2-66198409
Podvinny mlyn 6, Praha 9              fax:     +420-2-66198622
Czech Republic
**************************************************************
