Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Apr 2005 12:34:31 +0100 (BST)
Received: from chrom.openbsd-geek.de ([IPv6:::ffff:217.160.135.112]:30506 "EHLO
	chrom.openbsd-geek.de") by linux-mips.org with ESMTP
	id <S8225801AbVDXLeN>; Sun, 24 Apr 2005 12:34:13 +0100
Received: by chrom.openbsd-geek.de (Postfix, from userid 1000)
	id EE26B32561; Sun, 24 Apr 2005 13:34:11 +0200 (CEST)
Date:	Sun, 24 Apr 2005 13:34:11 +0200
From:	Waldemar Brodkorb <wbx@openbsd-geek.de>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: broadcom wireless driver 
Message-ID: <20050424113411.GA18904@openbsd-geek.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Editor: VIM
X-Operating-System: OpenBSD 3.6 i386
User-Agent: Mutt/1.5.6i
Return-Path: <wbx@openbsd-geek.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wbx@openbsd-geek.de
Precedence: bulk
X-list: linux-mips

Hi MIPS-Hackers,

I have a question regarding the binary only driver from linksys for
the wireless lan chip Broadcom BCM4320. (Linksys WRT54G router)

Linksys source code is based on linux kernel 2.4.20. Some time ago I
ported the stuff over to 2.4.29, which actually works, but has some bugs.

The binary driver wl.o use two structures from the kernel source. 
include/linux/skbuff.h: struct sk_buff{}
include/linux/netdevice.h: struct net_device{}

Both have changed his fields from 2.4.20 to 2.4.30.

Last time i backported both changes and changed some stuff in
net/sched to handle the changes. Now I am searching for a better
solution, because I think I broke traffic shaping.

I can move the new field "struct net_device       *real_dev" in
include/linux/skbuff.h to the end of the defintion and wl.o is happy
with the change. 

But in include/linux/netdevice.h there are two changes, one new
field "struct ethtool_ops *ethtool_ops;" and a type change:
"struct Qdisc            *qdisc_list;" changed to 
"struct list_head        qdisc_list;". 

What is the best way to handle this change, so that wl.o, the
wireless driver and the rest of the kernel is happy?

Thanks for any advice.

bye
    Waldemar
