Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2012 11:35:02 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41425 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903711Ab2BUKe6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Feb 2012 11:34:58 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id q1LAYuCM016140;
        Tue, 21 Feb 2012 11:34:56 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id q1LAYtNe016139;
        Tue, 21 Feb 2012 11:34:55 +0100
Date:   Tue, 21 Feb 2012 11:34:55 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mikael Starvik <mikael.starvik@axis.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: SMP MIPS and Linux 3.2
Message-ID: <20120221103455.GA13347@linux-mips.org>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D055C769FECBC@xmail3.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4BEA3FF3CAA35E408EA55C7BE2E61D055C769FECBC@xmail3.se.axis.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Feb 20, 2012 at 10:34:20AM +0100, Mikael Starvik wrote:

> I'm running Linux 3.2 on a MIPS 34K with two VPEs (in MT_SMP configuration). It works fine in UP but with SMP it deadlocks during bootup (both CPUs gets idle). Typically like this:
> 
> [    0.090000] CPU revision is: 01019550 (MIPS 34Kc)
> [    0.090000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
> [    0.090000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
> [    0.170000] Brought up 2 CPUs
> <No more output>
> 
> I have tried to enable __ARCH_WANT_INTERRUPTS_ON_CTXSW but that didn't
> improve anything. Anyone else got this running or have any thoughts about
> what the problem may be?

It used to work ...  Are you testing this on Malta?  In my experience if a
CPU hangs at this stage it often is because it does not receive a timer
tick, so all changes to the timer code are candidates to be reviewed.
Git bisect may be the way of least resistance here.  

  Ralf
