Received:  by oss.sgi.com id <S553724AbQLNRzb>;
	Thu, 14 Dec 2000 09:55:31 -0800
Received: from web1.lanscape.net ([64.240.156.194]:31756 "EHLO
        web1.lanscape.net") by oss.sgi.com with ESMTP id <S553695AbQLNRzC>;
	Thu, 14 Dec 2000 09:55:02 -0800
Received: (from tbm@localhost)
	by web1.lanscape.net (8.9.3/8.9.3) id LAA10405
	for linux-mips@oss.sgi.com; Thu, 14 Dec 2000 11:54:51 -0600
Date:   Thu, 14 Dec 2000 11:54:51 -0600
From:   Martin Michlmayr <tbm@lanscape.net>
To:     linux-mips@oss.sgi.com
Subject: Cannot type on DECstation prom
Message-ID: <20001214115451.A10322@web1.lanscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I recently got a DECstation 5000/125 and I'm trying to get Linux to run.
I'm using minicom and while I get output from the machine, I can not
type anything on the prom.  When I power the machine on, I get:

KN02-BA V5.7e
?TFL: #0 PMAGB-BA PATT: 5:  Red screen Test
3/misc/kbd
?STF (4: Ln#0 Kbd self test)

3/misc/mouse
?STF (4: Ln#1 Pntr self test)

>>

When I type anything, nothing happens at all.  When I press the
reset button (or whatever it's called), the machine boots NetBSD:

V5.7e    (PC: 0xbfc00cbc, SP: 0xa000feb4)
>> NetBSD/pmax Secondary Boot, Revision 1.0
>> (root@vlad, Sat Mar  4 14:34:30 EST 2000)
Boot: 3/rz2/netbsd

The funny thing is that I _can_ type when NetBSD is being started.  But
nothing happens on the prom.

What can I do?

FWIW, dmesg on NetBSD says:

DECstation 5000/125 (3MIN)
real mem  = 33554432
avail mem = 27136000
using 819 buffers containing 3354624 bytes of memory
mainbus0 (root)
cpu0 at mainbus0: cpu0: MIPS R3000 CPU Rev. 3.0 with MIPS R3010 FPC Rev. 3.0

-- 
Martin Michlmayr
tbm@cyrius.com
