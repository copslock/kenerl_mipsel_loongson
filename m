Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2004 06:14:28 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:13054 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224773AbUBNGO2>;
	Sat, 14 Feb 2004 06:14:28 +0000
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i1E6DstS021471;
	Fri, 13 Feb 2004 22:13:54 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i1E6DrcP021469;
	Fri, 13 Feb 2004 22:13:53 -0800
Date: Fri, 13 Feb 2004 22:13:53 -0800
From: Jun Sun <jsun@mvista.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	David Daney <ddaney@avtrex.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
Message-ID: <20040214061353.GA21449@mvista.com>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl> <20040213145316.GA23810@linux-mips.org> <20040213222253.GA20118@rembrandt.csv.ica.uni-stuttgart.de> <402D513F.8080205@avtrex.com> <20040213224959.GB20118@rembrandt.csv.ica.uni-stuttgart.de> <20040214011539.GB31847@linux-mips.org> <20040214012801.GC20118@rembrandt.csv.ica.uni-stuttgart.de> <20040214014520.GA4588@linux-mips.org> <20040214021740.GE20118@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214021740.GE20118@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Sat, Feb 14, 2004 at 03:17:40AM +0100, Thiemo Seufer wrote:
> Ralf Baechle wrote:
> [snip]
> > Anyway, gcc could load next weeks lucky lottery numbers into the
> > s-registers after saving them.  That'd break save_static but not the
> > ABI which only promises to restore the old values in s-registers on
> > return.
> 
> Ok, it could, but adding such insns to the prologue wouldn't make
> sense at all, so this is unlikely to happen.
> 

OS people who have been around long enough know "unlikely" things
always end up happening. :)

See my posting around Oct 2000 below.  Granted - gcc has changed a lot
and perhaps it won't do it again.  But just like a Chinese saying,
"Once bitten by the snake, afraid of the straw rope for three years". :)

I like the safe alternative.

Jun

P.S., the actual fix was done by Ralf

http://www.linux-mips.org/xcvs/linux-mips/patches/001282_001027_MAIN_ralf

------------------------------------------------------------------

Nasty degree - 3 days of tracking.

The symptom was pthread cannot be created.  In the end the caller will
get a BUS error.

What exactly happened has to do with how registers are saved.  Below
attached is the beginning part of sys_sigsuspend() function.  It is easy
to see that s0 is saved into stack frame AFTER its modified.  Next time
when process returns to userland, the s0 reg will be wrong!

So the bug is either

1) that we need to save s0 register in SAVE_SOME and not save it in
save_static; or that

2) we fix compiler so that it does not use s0 register in that case (it
does the same thing for sys_rt_sigsuspend)

I am sure Ralf will have something to say about it.  :-)  In any case, I
attached a patch for 1) fix.

Jun

------------



sys_sigsuspend(struct pt_regs regs)
{
    8008e280:   27bdffc0        addiu   $sp,$sp,-64
    8008e284:   afb00030        sw      $s0,48($sp)
        sigset_t *uset, saveset, newset;

        save_static(&regs);
    8008e288:   27b00040        addiu   $s0,$sp,64
    8008e28c:   afbf003c        sw      $ra,60($sp)
    8008e290:   afb20038        sw      $s2,56($sp)
    8008e294:   afb10034        sw      $s1,52($sp)
    8008e298:   afa40040        sw      $a0,64($sp)
    8008e29c:   afa50044        sw      $a1,68($sp)
    8008e2a0:   afa60048        sw      $a2,72($sp)
    8008e2a4:   afa7004c        sw      $a3,76($sp)
    8008e2a8:   ae100058        sw      $s0,88($s0)
    8008e2ac:   ae11005c        sw      $s1,92($s0)
    .....
