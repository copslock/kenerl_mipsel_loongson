Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6SI1aRw011951
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 28 Jul 2002 11:01:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6SI1TP0011950
	for linux-mips-outgoing; Sun, 28 Jul 2002 11:01:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from columba.www.eur.3com.com (ip-161-71-171-238.corp-eur.3com.com [161.71.171.238])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6SI16Rw011933
	for <linux-mips@oss.sgi.com>; Sun, 28 Jul 2002 11:01:22 -0700
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g6SI3hDw017918;
	Sun, 28 Jul 2002 19:03:44 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g6SI2YR23003;
	Sun, 28 Jul 2002 19:02:39 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256C04.0063793F ; Sun, 28 Jul 2002 19:06:31 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Rob Lembree <lembree@metrolink.com>
cc: linux-mips@oss.sgi.com
Message-ID: <80256C04.0063783A.00@notesmta.eur.3com.com>
Date: Sun, 28 Jul 2002 19:01:35 +0100
Subject: Re: Xilleon port from 2.4.5 to top of tree, asm("$28") problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



>During boot-up, 'current' (which eventually evaluates to
>an offset of register struct thread_info *__current_thread_info
>__asm__("$28");) is null plus the offset, in sock_alloc,
>obviously making the kernel take a big dive.
>
>    Are there any obvious reasons why this would evaluate
>to null?

I've seen similar things when investigating a kernel locking hard during boot.
The two causes I found were:

- Interrupts being enabled before the interrupt handlers are installed and
working.

- CP0 register being corrupted, leaving the CP0_STATUS CU0 bit unset. This leads
the exception routines (normally the interrupt handler) to think the exception
occured in usermode code and trying to derefence the 'current' pointer, but it
still NULL during the early kernel initialisation. I think this situation causes
a nested stream of TLB faults.

One way to diagnose 1 is to force the CP0_BEV to be left on during the early
kernel initialisation. This should force any exceptions such as an interrupt to
go to your boot rom exception handlers, which will probably dump out the cause
and location of the exception.

I eventually traced problem (2) back to a hardware problem hitting the
blast_icache() routine. See my post with the subject 'mips32_flush_cache routine
corrupts CP0_STATUS with gcc-2.96' on this mailing list for further details.

      Jon Burgess
