Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 12:50:13 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:44437 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIDKuM>; Wed, 4 Sep 2002 12:50:12 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA10803;
	Wed, 4 Sep 2002 12:50:26 +0200 (MET DST)
Date: Wed, 4 Sep 2002 12:50:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Matthew Dharm <mdharm@momenco.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: time.c CP0_COMPARE (and SMP IPI rambling) 
In-Reply-To: <3D74EA66.6020906@mvista.com>
Message-ID: <Pine.GSO.3.96.1020904124439.10619B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 73
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 3 Sep 2002, Jun Sun wrote:

> Right now setting per-cpu timers is totally left to the board-dependent code. 
>   Once we see more SMP boxes using this approach, I think it starts to be 
> interesting to make some abstraction and support it in a systematic way, 
> including support for using CPU counter as the per-cpu timer interrupt.
> 
> Using local_timer_emulation sounds like an attractive alternative to me, as we 
> only need to set up one system-wide timer interrupt.  Conceptually it probably 
> takes a little longer to run through timer_interrupt (due to IPI calls).  But 
> if the hit on performance is very negligible, the simplicity might make it 
> worthwile.

 Well, the i386 approach (with a grain of salt, of course, but it's about
the most mature, anyway) seems reasonable.  A per-CPU local timer for
scheduling (no need to stability or high precision) and an external timer
interrupt for timekeeping (this one precise) that's delivered to a single
CPU at a time.  I hope there are no MIPS SMP systems that lack an external
timer IRQ source. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
