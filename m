Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FNpEnC016237
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 16:51:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FNpD6D016236
	for linux-mips-outgoing; Sat, 15 Jun 2002 16:51:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FNp6nC016233
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 16:51:06 -0700
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id g5FNjA919900
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 19:45:10 -0400
Received: from mx.hsv.redhat.com (IDENT:root@spot.hsv.redhat.com [172.16.16.7])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id g5FNrmr21931;
	Sat, 15 Jun 2002 19:53:48 -0400
Received: from redhat.com (slurm.hsv.redhat.com [172.16.16.102])
	by mx.hsv.redhat.com (8.11.6/8.11.0) with ESMTP id g5FNsag23222;
	Sat, 15 Jun 2002 18:54:36 -0500
Message-ID: <3D0BD42E.20602@redhat.com>
Date: Sat, 15 Jun 2002 18:56:30 -0500
From: Louis Hamilton <hamilton@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
CC: sandcraft-elinux-project@redhat.com, hamilton@redhat.com
Subject: Bug in Linux?  fcr31 not being saved-restored
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

We have a customer here testing a 2.4.16 mips kernel on an embedded
Linux RM7000/SR71000 based system who has written a test that they
believe has uncovered a bug in Linux.  The FPU control register appears
to not get saved and restored.  I've reproduced the problem described
below and find the results consistent with their description.  The
problem occurs on both the RM7000 and SR71000 cpus.

It looks like save_fp_context and restore_fp_context are not being
called since the kernel save-restore logic thinks the process is not 
using floating point math.  If you do some fp math before calling the
test routine below, it seems to works fine.

Is this a known caveat?  A true bug?  Or a contorted corner case
unlikely to be seen under typical end-user usage (see customer's
last paragraph :-) ?   If true bug, recommended remedy?

TIA,
Louis

Louis Hamilton
hamilton@redhat.com


------ customer reports the following: ---------
We found a bug in Linux.  A ^C (control-C) typed into a shell (or a
running program, it doesn't matter), causes the FCR (floating-point
control register) to be corrupted in another, unrelated process.  This
is repeatable behavior.

This can be reproduced with the following short assembly language
program that loops forever, waiting for the FCR to change.

	.align 2
	.globl mips_float_debug_loop
mips_float_debug_loop:
	li	$9, 0xF000F02F
	ctc1    $9, $31		# set FCR to some non-zero value
	nop
1:	cfc1	$8, $31		# get FCR
	beq	$8, $9, 1b	# spin, waiting for FCR to change
	nop
	or	$2, $0, $8
	jr    $31
	nop

You can call this function from a short C program and the return value
is the (corrupted) FCR, which turns out to alwyas be: 0x00000002.

Run the above loop in one window (connected to the board using telnet)
and then in another window (connected to the same board) type ^C.

I'm surprised this bug hasn't been encountered by other MIPS vendors.

<end>
