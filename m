Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA19934 for <linux-archive@neteng.engr.sgi.com>; Fri, 21 May 1999 15:08:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA56569
	for linux-list;
	Fri, 21 May 1999 15:06:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA36193
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 21 May 1999 15:06:45 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from vera.dpo.uab.edu (Vera.dpo.uab.edu [138.26.1.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00558
	for <linux@cthulhu.engr.sgi.com>; Fri, 21 May 1999 15:06:44 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu by vera.dpo.uab.edu (LSMTP for Windows NT v1.1a) with SMTP id <0.4CECC3C0@vera.dpo.uab.edu>; Fri, 21 May 1999 17:06:43 -0500
Date: Fri, 21 May 1999 17:16:07 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Anyone have an idea on this oops?
Message-ID: <Pine.LNX.3.96.990521171408.257A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I am currently at a loss as to where to look, but it could just be lack of
sleep.  So if anyone has any pointers on fixing this.  BTW, this is from
an Indigo2, not an Indy...

Thanks, 

Andrew



Options used: -v ./vmlinux (specified)
              -O (specified)
              -K (specified)
              -L (specified)
              -m ./System.map (specified)
              -c 1 (default)

Oops: 0000
$0 : 00000000 3004fc00 00000001 880f565c
$4 : 00000000 00000000 887b7d40 3004fc01
$8 : 3004fc00 1000001f 0000003e 20202020
$12: 2020622e 887b7e10 3004fc01 887b7e10
$16: 8811d548 00000050 00000029 8ff44000
$20: 00000000 880e1020 10013228 880e1020
$24: 00000000 2ab30ff0
$28: 887b6000 887b7d28 880abaa4 880ca238
epc   : 880c9b70
Status: 3004fc02
Cause : 00000008
Process cat (pid: 6, stackpage=887b6000)
Stack: 880e28d9 887b7e2c 00000000 000008bd 10000400 880ca238 00000000 706f7274
       2070726f 887b7e10 3004fc01 880e28bd 00000000 3004fc00 0000008a 00000b61
       00000080 bfbd9830 8811d140 3004fc01 0000fc00 ffff00ff 0000003e 20202020
       2020622e 887b7e10 3004fc01 887b7e10 8ff44000 00000050 00000029 8ff44000
       00000000 880e1020 10013228 880e1020 00000000 2ab30ff0 10013228 880e1020
       887b6000 ...
Call Trace: [<880ca238>] [<880abaa4>] [<880a994c>] [<880c2afc>] [<880a9964>] [<880abc1c>] [<880a6b94>] [<880a69b4>] [<8803fad0>] [<8801935c>] [<88046cf8>] [<88011fe4>] [<88011724>]
Code: 8c620000  24420001  ac620000 <8ca20000> 0040f809  8ca50010  8e020000  2442ffff  ae020000 

>>EIP: 880c9b70 <indy_local0_irqdispatch+ac/d4>
Trace: 880ca238 <indyIRQ+118/180>
Trace: 880abaa4 <write_chan+0/2d8>
Trace: 880a994c <opost_block+204/234>
Trace: 880c2afc <rs_flush_chars+204/210>
Trace: 880a9964 <opost_block+21c/234>
Trace: 880abc1c <write_chan+178/2d8>
Trace: 880a6b94 <tty_write+1e0/2c4>
Trace: 880a69b4 <tty_write+0/2c4>
Trace: 8803fad0 <sys_write+154/1b4>
Trace: 8801935c <__gnu_compiled_c+17c/280>
Trace: 88046cf8 <sys_newfstat+b4/d4>
Trace: 88011fe4 <stack_done+18/34>
Trace: 88011724 <nopage_tlbl+f4/110>

Aiee, killing interrupt handler

1 error issued.  Results may not be reliable.
