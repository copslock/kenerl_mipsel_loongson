Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2003 19:05:18 +0100 (BST)
Received: from orngca-mls01.socal.rr.com ([IPv6:::ffff:66.75.160.16]:22210
	"EHLO orngca-mls01.socal.rr.com") by linux-mips.org with ESMTP
	id <S8225392AbTILSFQ>; Fri, 12 Sep 2003 19:05:16 +0100
Received: from PEPELEPEW (66-75-23-214.san.rr.com [66.75.23.214])
	by orngca-mls01.socal.rr.com (8.11.4/8.11.3) with SMTP id h8CI1b406738
	for <linux-mips@linux-mips.org>; Fri, 12 Sep 2003 11:01:37 -0700 (PDT)
From: "Craig Mautner" <craig.mautner@alumni.ucsd.edu>
To: <linux-mips@linux-mips.org>
Subject: schedule() BUG
Date: Fri, 12 Sep 2003 11:04:16 -0700
Message-ID: <JKEMLDJFFLGLICKLLEFJMEEOCOAA.craig.mautner@alumni.ucsd.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Return-Path: <craig.mautner@alumni.ucsd.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: craig.mautner@alumni.ucsd.edu
Precedence: bulk
X-list: linux-mips

We are using mips-linux 2.4.17, gcc 3.2.1 (MontaVista) and crashing in
schedule():

kernel BUG at sched.c:784!
Unable to handle kernel paging request at virtual address 00000000, epc ==
800153c0, ra == 800153c0
$0 : 00000000 9001f800 0000001b 00000000 0000001a 83f56000 8298f4a0 0000001f
$8 : 00000001 ffffe2e0 000022e0 00000000 fffffff9 ffffffff 0000000a 00000002
$16: 00000000 00000000 82af0000 8298f4a0 83f56000 00000000 80008000 00000000
$24: 82af1dc2 00000002                   82af0000 82af1ef8 82af1ef8 800153c0
epc  : 800153c0    Not tainted

The code is:

    {
      struct mm_struct *mm = next->mm;
      struct mm_struct *oldmm = prev->active_mm;
      if (!mm) {
           if (next->active_mm) BUG();   <- this is where we crash
           next->active_mm = oldmm;
           atomic_inc(&oldmm->mm_count);
           enter_lazy_tlb(oldmm, next, this_cpu);
      }
        .
        .
        .

This seems to happen in our case when 'next' points to 'kswapd' although we
think it could happen when switching to any kernel task (i.e. those tasks
with mm==NULL).

We think the culprit is that we are taking an interrupt and rescheduling
while at a vulnerable point in 'schedule()'. Interrupts are enabled in line
743. If we get an interrupt any time after line 785:

           next->active_mm = oldmm;

but before line 806

	__schedule_tail()

completes the swap, the interrupt can force 'schedule()' to be reentered via
'ret_from_intr()'.

If so, 'kswapd's 'active_mm' field will be left non-zero, but 'current' will
not have been set to point to 'kswapd'. The next time 'schedule()' tries to
switch to 'kswapd', 'next' points to 'kswapd', and

        next->mm == NULL
        next->active_mm != NULL

which is detected as an invalid state, so we hit the BUG.

Some questions:
	Are we looking at this correctly?
	Has anyone ever seen this before?
	Is there a published fix?

Thanks,

-Craig

-.     .-.     .-_     Craig Mautner
  \   /   \   / / `    Coastal Sr. Consulting, Inc.
   `-'     `-'  `---   (858)361-2683
                       (858)581-0542 (fax)
5580 La Jolla Blvd. #308 La Jolla, CA 92037
mailto:craig.mautner@alumni.ucsd.edu
http://home.san.rr.com/cmautner/csc/craig/
