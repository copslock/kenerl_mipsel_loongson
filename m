Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5H6HinC011971
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 16 Jun 2002 23:17:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5H6Hijl011970
	for linux-mips-outgoing; Sun, 16 Jun 2002 23:17:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5H6HZnC011962
	for <linux-mips@oss.sgi.com>; Sun, 16 Jun 2002 23:17:35 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id XAA05457;
	Sun, 16 Jun 2002 23:20:07 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA10192;
	Sun, 16 Jun 2002 23:20:09 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5H6K9b13541;
	Mon, 17 Jun 2002 08:20:09 +0200 (MEST)
Message-ID: <3D0D7F98.566B3176@mips.com>
Date: Mon, 17 Jun 2002 08:20:09 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Louis Hamilton <hamilton@redhat.com>
CC: linux-mips@oss.sgi.com, sandcraft-elinux-project@redhat.com
Subject: Re: Bug in Linux?  fcr31 not being saved-restored
References: <3D0BD42E.20602@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is one of the bugs, among others, we have fixed.
I'm not sure, if Ralf have integrated the patches we send him yet.

/Carsten

Louis Hamilton wrote:

> We have a customer here testing a 2.4.16 mips kernel on an embedded
> Linux RM7000/SR71000 based system who has written a test that they
> believe has uncovered a bug in Linux.  The FPU control register appears
> to not get saved and restored.  I've reproduced the problem described
> below and find the results consistent with their description.  The
> problem occurs on both the RM7000 and SR71000 cpus.
>
> It looks like save_fp_context and restore_fp_context are not being
> called since the kernel save-restore logic thinks the process is not
> using floating point math.  If you do some fp math before calling the
> test routine below, it seems to works fine.
>
> Is this a known caveat?  A true bug?  Or a contorted corner case
> unlikely to be seen under typical end-user usage (see customer's
> last paragraph :-) ?   If true bug, recommended remedy?
>
> TIA,
> Louis
>
> Louis Hamilton
> hamilton@redhat.com
>
> ------ customer reports the following: ---------
> We found a bug in Linux.  A ^C (control-C) typed into a shell (or a
> running program, it doesn't matter), causes the FCR (floating-point
> control register) to be corrupted in another, unrelated process.  This
> is repeatable behavior.
>
> This can be reproduced with the following short assembly language
> program that loops forever, waiting for the FCR to change.
>
>         .align 2
>         .globl mips_float_debug_loop
> mips_float_debug_loop:
>         li      $9, 0xF000F02F
>         ctc1    $9, $31         # set FCR to some non-zero value
>         nop
> 1:      cfc1    $8, $31         # get FCR
>         beq     $8, $9, 1b      # spin, waiting for FCR to change
>         nop
>         or      $2, $0, $8
>         jr    $31
>         nop
>
> You can call this function from a short C program and the return value
> is the (corrupted) FCR, which turns out to alwyas be: 0x00000002.
>
> Run the above loop in one window (connected to the board using telnet)
> and then in another window (connected to the same board) type ^C.
>
> I'm surprised this bug hasn't been encountered by other MIPS vendors.
>
> <end>

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
