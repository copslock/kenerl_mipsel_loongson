Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id KAA01205; Sun, 10 Mar 1996 10:48:58 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id KAA24676; Sun, 10 Mar 1996 10:48:50 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id KAA24671; Sun, 10 Mar 1996 10:48:44 -0800
Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id KAA01201; Sun, 10 Mar 1996 10:48:43 -0800
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id WAA28992; Sat, 9 Mar 1996 22:09:31 -0800
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id WAA28536; Sat, 9 Mar 1996 22:09:30 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id BAA06806; Sun, 10 Mar 1996 01:09:29 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id BAA00381; Sun, 10 Mar 1996 01:09:24 -0500
Date: Sun, 10 Mar 1996 01:09:24 -0500
Message-Id: <199603100609.BAA00381@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: adrian@remus.rutgers.edu
CC: lmlinux@neteng.engr.sgi.com
Subject: [tridge@cs.anu.edu.au: Linux on the AP+ - progress!]
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Is this fucking cool or what?  Adrian, and the lmlinux people, please
keep this to yourself as I don't know if he is allowed to publicize
his work or not.  Thanks. ;-)

------- Start of forwarded message -------
Date: Sun, 10 Mar 1996 17:00:15 +1100
From: Andrew Tridgell <tridge@cs.anu.edu.au>
To: davem@caip.rutgers.edu
Subject: Linux on the AP+ - progress!
Reply-to: Andrew.Tridgell@anu.edu.au

David,

I've managed to get Linux on our AP1000+ booting up to the stage where
it detects a Viking MMU and dies.

The main problem was that the machine has no prom at all, so all the
calls to the prom routines needed amputation to get it to
work. Instead of a prom the hardware has a mechanism for loading a
image from the front end at 0xF0000000 and launching it. I wrote a
small boot loader that runs at this address then pulls a vmlinux from
the front end then jumps to it. I finally got this working today.

I've also written an ap_printk() routine that uses lda/sta to write to
the front end, and wired both prom_printf() and printk() to that.

I'll let you know as I make more progress, meanwhile here are the
first signs of life from Linux/AP+:

@load aout vmlinux
  488k
load finished
@jumping to 0xf0004000
@Hello from Linux!
@got to line 0198
@got to line 0206
@ARCH: @SUN4M
@Uh oh, IDPROM had bogus id_machtype value <0>
@Ethernet address: 0:0:0:0:0:0
@Loading srmmu MMU routines
@Viking MMU detected.

The '@' symbols and from my monitor program - they helped debugging
the protocol.

Cheers, Andrew

PS: In case you can't remember a AP1000+ is a SuperSparc based
distributed memory multicomputer made by Fujitsu. Ours has 16 cpus
each with 16MB of ram. We will soon be upgrading it to 32 cpus with
64MB of ram in each and 128GB of disk.


------- End of forwarded message -------
