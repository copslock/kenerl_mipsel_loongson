Received:  by oss.sgi.com id <S553844AbRBISfr>;
	Fri, 9 Feb 2001 10:35:47 -0800
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.69.0.28]:56330 "HELO MIT.EDU")
	by oss.sgi.com with SMTP id <S553834AbRBISfl>;
	Fri, 9 Feb 2001 10:35:41 -0800
Received: from GRAND-CENTRAL-STATION.MIT.EDU by MIT.EDU with SMTP
	id AA24092; Fri, 9 Feb 01 13:37:35 EST
Received: from melbourne-city-street.MIT.EDU (MELBOURNE-CITY-STREET.MIT.EDU [18.69.0.45])
	by grand-central-station.MIT.EDU (8.9.2/8.9.2) with ESMTP id NAA23282
	for <linux-mips@oss.sgi.com>; Fri, 9 Feb 2001 13:35:24 -0500 (EST)
Received: from ten-thousand-dollar-bill.mit.edu (TEN-THOUSAND-DOLLAR-BILL.MIT.EDU [18.184.0.39])
	by melbourne-city-street.MIT.EDU (8.9.3/8.9.2) with ESMTP id NAA12247
	for <linux-mips@oss.sgi.com>; Fri, 9 Feb 2001 13:35:24 -0500 (EST)
Received: from localhost (kbarr@localhost) by ten-thousand-dollar-bill.mit.edu (8.9.3) with ESMTP
	id NAA09822; Fri, 9 Feb 2001 13:35:24 -0500 (EST)
Date:   Fri, 9 Feb 2001 13:35:24 -0500 (EST)
From:   Kenneth C Barr <kbarr@MIT.EDU>
To:     <linux-mips@oss.sgi.com>
Subject: Re: current cvs broken on sgi 
In-Reply-To: <20010209161521.D13248@paradigm.rfc822.org>
Message-Id: <Pine.GSO.4.30L.0102091239420.209-100000@ten-thousand-dollar-bill.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

In light of list responses to my netbooting questions, I grabbed the src
on 2/6/01, made tweaks so it would link, built a kernel with serial
console support (and no VT support), ran elf2ecoff, booted with
console=ttyS0, and was able to reach a prompt on my Indy.

Here (I think) are the changes since then...

(grossglockner) ~/zips/crossdev/linux % cvs -d
:pserver:cvs@oss.sgi.com:/cvs history -a -D 2001-02-06 -c
M 02/07 02:43 +0000 ralf 1.3  threads.h  linux/include/linux == <remote>
M 02/08 18:10 +0000 xfs  1.20 todos.html xfs-website         == <remote>
M 02/08 20:52 +0000 xfs  1.21 todos.html xfs-website         == <remote>
M 02/08 20:54 +0000 ralf 1.50 setup.c    linux/arch/mips/kernel == <remote>

BTW, thanks to everyone for their help so far!  Now I'm trying to get a
local user filesystem setup...

Ken




P.S.  My changes:

(grossglockner) ~/zips/crossdev/linux/drivers/sgi/char % cvs -d
:pserver:cvs@oss.sgi.com:/cvs diff
cvs server: Diffing .
Index: sgiserial.c
===================================================================
RCS file: /cvs/linux/drivers/sgi/char/sgiserial.c,v
retrieving revision 1.28
diff -r1.28 sgiserial.c
49c49,53
< extern wait_queue_head_t keypress_wait;
---
> //extern wait_queue_head_t keypress_wait;
> /* changed so that kernel will link. -Nathan <npsimons@nmt.edu>
>    extern wait_queue_head_t keypress_wait; */
> DECLARE_WAIT_QUEUE_HEAD(keypress_wait);
>
Index: streamable.c
===================================================================
RCS file: /cvs/linux/drivers/sgi/char/streamable.c,v
retrieving revision 1.13
diff -r1.13 streamable.c
23c23,29
< extern struct kbd_struct kbd_table [MAX_NR_CONSOLES];
---
> //extern struct kbd_struct kbd_table [MAX_NR_CONSOLES];
>
> /* changed so that kernel will link -Nathan <npsimons@nmt.edu>
>  * extern struct kbd_struct kbd_table [MAX_NR_CONSOLES]; */
> struct kbd_struct kbd_table[MAX_NR_CONSOLES];
> int fg_console = 0;
>



On Fri, 9 Feb 2001, Florian Lohoff wrote:

> Hi,
> can someone confirm that the current cvs ONCE AGAIN is broken
> on SGIs (Indy/I2) ?
>
> Even with the "early console init" it simply dies ..
>
> Command Monitor.  Type "exit" to return to the menu.
> >> bootp():vmlinux-ip22 console=ttyS0 root=/dev/sda2
> Setting $netaddr to 195.71.99.220 (from server watchdog)
> Obtaining vmlinux-ip22 from server watchdog
> 1556544+0+152424 entry: 0x880025a8
>
>
> Flo
> --
> Florian Lohoff                  flo@rfc822.org             +49-5201-669912
>      Why is it called "common sense" when nobody seems to have any?
>
>
