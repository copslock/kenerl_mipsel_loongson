Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7EMIsd23000
	for linux-mips-outgoing; Tue, 14 Aug 2001 15:18:54 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7EMInj22994
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 15:18:49 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09500
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 15:18:35 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15WmNI-0005AK-00; Tue, 14 Aug 2001 15:09:24 -0700
Date: Tue, 14 Aug 2001 15:09:24 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: linux-mips@oss.sgi.com, gcc-bugs@gcc.gnu.org
Cc: Simon Gee <simong@oz.agile.tv>
Subject: MIPS, profiling, and not working
Message-ID: <20010814150924.A19477@nevyn.them.org>
Mail-Followup-To: linux-mips@oss.sgi.com, gcc-bugs@gcc.gnu.org,
	Simon Gee <simong@oz.agile.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm having some interesting problems with getting _mcount() to work on
mips*-*-linux.  Most of them are easily correctable within _mcount itself,
but one deals with how it's called.  The sequence looks like this:

        .set    noreorder
        .set    noat
        move    $1,$31          # save current return address
        jal     _mcount
        subu    $sp,$sp,8               # _mcount pops 2 words from  stack
        .set    reorder
        .set    at

Suppose we have a function with no frame pointer, though - one which would
otherwise be a leaf.  We have a small problem based on the fact that
GCC considers it to be a leaf despite calling _mcount.  If it uses $sp for
its frame register, then when the jal expands:

0x404550 <__libc_start_main+16>:        sw      $gp,16($sp)

...

0x404574 <__libc_start_main+52>:        move    $at,$ra
0x404578 <__libc_start_main+56>:        lw      $t9,-32584($gp)
0x40457c <__libc_start_main+60>:        nop
0x404580 <__libc_start_main+64>:        jalr    $t9
0x404584 <__libc_start_main+68>:        nop
0x404588 <__libc_start_main+72>:        lw      $gp,16($sp)
0x40458c <__libc_start_main+76>:        addiu   $sp,$sp,-8


Note that we saved $gp at 16($sp), then tried to restore it before we fixed
$sp up again.

Does anyone have a good idea?  The best I can think of is to emit the jalr
from GCC directly, so that we can restore the GP after restoring the stack
pointer properly.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
