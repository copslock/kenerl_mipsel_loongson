Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id JAA521197; Sat, 23 Aug 1997 09:04:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA15138 for linux-list; Sat, 23 Aug 1997 09:04:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA15044 for <linux@cthulhu.engr.sgi.com>; Sat, 23 Aug 1997 09:03:38 -0700
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA21540
	for <linux@cthulhu.engr.sgi.com>; Sat, 23 Aug 1997 09:03:35 -0700
	env-from (oliver@aec.at)
Received: (from oliver@localhost) by aec.at (8.8.3/8.7) id SAA18891; Sat, 23 Aug 1997 18:02:10 +0200
Date: Sat, 23 Aug 1997 18:02:10 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: "unable to handle kernel paging request" at boot
In-Reply-To: <199708211605.LAA08758@athena.nuclecu.unam.mx>
Message-ID: <Pine.LNX.3.91.970823175207.18779A-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

hello,

now i put r4k_show_regs() right after  printk(KERN_ALERT "Unable to handle.."
into fault.c and get the following output (using kernel linux-970704, btw :)

$0 : 00000000 1004fc00 00000010 00000000
$1 : 00000010 00000000 1fffffff 00000000
$2 : 89f772b8 00000000 00000000 00000000
$12: 00000008 00000282 88368038 1004fc01
$16: 89f77000 8811d2f8 00000005 8810317c
$20: bfb34000 bfbd4000 00000003 00000000
$24: 00000000 0000000f
$28: 566a6ead 89f91da0 00000001 880d8f04
epc   : 880d8f24
Status: 1004fc03
Cause : 1000000c

my System.map shows this:
880d8d74 t sgiseeq_set_multicast
880d8d7c T sgiseeq_init
880d9084 T sgiseeq_probe

gdb disas this:
0x880d8f18 <sgiseeq_init+412>:  move $v1,$a3
0x880d8f1c <sgiseeq_init+416>:  addu $v0,$a3,$a0
0x880d8f20 <sgiseeq_init+420>:  and $v0,$v0,$a2
0x880d8f24 <sgiseeq_init+424>:  sw $v0,8($v1)


dunno if that helps :)

o.
