Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Dec 2004 07:01:21 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:36810
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8225204AbULRHBH>; Sat, 18 Dec 2004 07:01:07 +0000
Received: from gren.infostations.net (gren.infostations.net [71.4.40.32])
	by mail-relay.infostations.net (Postfix) with ESMTP id E31E9A2CD0
	for <linux-mips@linux-mips.org>; Sat, 18 Dec 2004 07:00:16 +0000 (Local time zone must be set--see zic manual page)
Received: from host-66-81-129-154.rev.o1.com ([66.81.129.154])
	by gren.infostations.net with esmtp (Exim 4.42 #1 (Gentoo))
	id 1CfYbn-0006ZK-QH
	for <linux-mips@linux-mips.org>; Fri, 17 Dec 2004 23:02:34 -0800
Subject: Build problem with drivers/net/au1000_eth.c
From: Josh Green <jgreen@users.sourceforge.net>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Date: Fri, 17 Dec 2004 23:00:40 -0800
Message-Id: <1103353240.24434.10.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips

I'm using latest linux-mips CVS kernel (2.6.10rc3) and GCC 3.4.2 on a
AMD Alchemy DBau1100 development board (mipsel/MIPS32).  I wasn't able
to find any other location to post bugs, so please let me know if there
is a bug system or more appropriate place to post this.  The kernel
build dies with:

  CC      drivers/net/au1000_eth.o
drivers/net/au1000_eth.c: In function `au1000_init_module':
drivers/net/au1000_eth.c:100: sorry, unimplemented: inlining failed in
call to 'str2eaddr': function body not available
drivers/net/au1000_eth.c:1506: sorry, unimplemented: called from here
drivers/net/au1000_eth.c: At top level:
drivers/net/au1000_eth.c:152: warning: 'phy_link' defined but not used
make[2]: *** [drivers/net/au1000_eth.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2


I was able to get things to build with the following patch, although I'm
sure this is not the proper way to do things:
$ cvs diff drivers/net/au1000_eth.c

Index: drivers/net/au1000_eth.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/au1000_eth.c,v
retrieving revision 1.39
diff -r1.39 au1000_eth.c
100c100
< extern inline void str2eaddr(unsigned char *ea, unsigned char *str);
---
> extern void str2eaddr(unsigned char *ea, unsigned char *str);


Best regards,
	Josh Green
