Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2003 03:02:42 +0100 (BST)
Received: from [IPv6:::ffff:207.215.131.7] ([IPv6:::ffff:207.215.131.7]:53221
	"EHLO mail.pioneer-pdt.com") by linux-mips.org with ESMTP
	id <S8225424AbTJGCCk>; Tue, 7 Oct 2003 03:02:40 +0100
Received: from 127.0.0.1 (localhost.pioneer-pdt.com [127.0.0.1])
	by dummy.domain.name (Postfix) with SMTP
	id C29F49D808; Mon,  6 Oct 2003 19:02:32 -0700 (PDT)
Received: from janelle (unknown [172.30.2.14])
	by mail.pioneer-pdt.com (Postfix) with SMTP
	id 925B19D807; Mon,  6 Oct 2003 19:02:31 -0700 (PDT)
Message-ID: <017601c38c77$6d7225a0$2256fea9@janelle>
From: "Steve Scott" <steve.scott@pioneer-pdt.com>
To: <jsun@mvista.com>
Cc: <linux-mips@linux-mips.org>, <craig.mautner@pioneer-pdt.com>
References: <FJEIIOCBFAIOIDNKLPFJCECODAAA.koji.kawachi@pioneer-pdt.com>
Subject: Re: schedule() BUG
Date: Mon, 6 Oct 2003 19:05:06 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0173_01C38C3C.C0FF7780"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <steve.scott@pioneer-pdt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steve.scott@pioneer-pdt.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0173_01C38C3C.C0FF7780
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

We tried the fault.c patch Jun suggested, but it didn't solve the problem we were
having with the BUG() in schedule(). The patch at the beginning of
except_vec3_generic for the Vr5432 bug had previously been installed.

While chasing the BUG() in schedule(), though, we ran across another BUG() in
alloc_skb() in ...linux/net/core/skbuff.c. :

    alloc_skb called nonatomically from interrupt 80117acc
    kernel BUG at skbuff.c:179!

We changed the way sock_init_data initializes the 'allocation' field and
were able to get past this one (see attached sock.c.patch). We're not sure
if this fix needs to be permanent, or if it's just a temporary workaround.

For the schedule() BUG(), all evidence that we collected pointed to some
interrupt causing us to reenter schedule() (i.e., somehow schedule() was
called during an interrupt handler). We suspected something being run
from the timer interrupt bottom half, but were never able to prove it. We
also thought a remote possibility might be a pipeline hazard in the MIPS
causing the EPC register not to update on a nested exception, but NEC says
that can't happen on the Vr5432 that we're using...

We finally worked around the schedule BUG() by disabling interrupts
during the context switch in schedule(). This workaround required changes
in linux/kernel/sched.c and linux/arch/mips/kernel/r4k_switch.S (see attached
patches).

--steve

> 
> 
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Jun Sun
> Sent: Wednesday, October 01, 2003 4:50 PM
> To: Craig Mautner
> Cc: linux-mips@linux-mips.org; jsun@mvista.com
> Subject: Re: schedule() BUG
> 
> 
> On Fri, Sep 12, 2003 at 11:04:16AM -0700, Craig Mautner wrote:
> > We are using mips-linux 2.4.17, gcc 3.2.1 (MontaVista) and crashing in
> > schedule():
> >
> > Unable to handle kernel paging request at virtual address 00000000, epc ==
> > 800153c0, ra == 800153c0
> > $0 : 00000000 9001f800 0000001b 00000000 0000001a 83f56000 8298f4a0
> 0000001f
> > $8 : 00000001 ffffe2e0 000022e0 00000000 fffffff9 ffffffff 0000000a
> 00000002
> > $16: 00000000 00000000 82af0000 8298f4a0 83f56000 00000000 80008000
> 00000000
> > $24: 82af1dc2 00000002                   82af0000 82af1ef8 82af1ef8
> 800153c0
> > epc  : 800153c0    Not tainted
> >
> > The code is:
> >
> >     {
> >       struct mm_struct *mm = next->mm;
> >       struct mm_struct *oldmm = prev->active_mm;
> >       if (!mm) {
> >            if (next->active_mm) BUG();   <- this is where we crash
> >            next->active_mm = oldmm;
> >            atomic_inc(&oldmm->mm_count);
> >            enter_lazy_tlb(oldmm, next, this_cpu);
> >       }
> >         .
> >         .
> >         .
> >
> > This seems to happen in our case when 'next' points to 'kswapd' although
> we
> > think it could happen when switching to any kernel task (i.e. those tasks
> > with mm==NULL).
> >
> > We think the culprit is that we are taking an interrupt and rescheduling
> > while at a vulnerable point in 'schedule()'. Interrupts are enabled in
> line
> > 743. If we get an interrupt any time after line 785:
> >
> >            next->active_mm = oldmm;
> >
> > but before line 806
> >
> > __schedule_tail()
> >
> > completes the swap, the interrupt can force 'schedule()' to be reentered
> via
> > 'ret_from_intr()'.
> >
> > If so, 'kswapd's 'active_mm' field will be left non-zero, but 'current'
> will
> > not have been set to point to 'kswapd'. The next time 'schedule()' tries
> to
> > switch to 'kswapd', 'next' points to 'kswapd', and
> >
> >         next->mm == NULL
> >         next->active_mm != NULL
> >
> > which is detected as an invalid state, so we hit the BUG.
> >
> > Some questions:
> > Are we looking at this correctly?
> > Has anyone ever seen this before?
> > Is there a published fix?
> >
> > Thanks,
> >
> > -Craig
> >
> 
> This is an known problem.  Please try the attached patch.
> 
> On R5432 CPU, there is also an hardware bug which can cause the same
> problem.  Please double-check vec3_generic to see if workaround is
> at the beginning of the handler.
> 
> BTW, 2.4.17 is an old kernel. You really need to upgrade.
> 
> Jun
> 
> 
> 
------=_NextPart_000_0173_01C38C3C.C0FF7780
Content-Type: application/octet-stream;
	name="sock.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sock.c.patch"

Index: /home/sscott/work/Software/linux/net/core/sock.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /usr/local/CVS/V4000/Software/linux/net/core/sock.c,v=0A=
retrieving revision 1.1.1.1=0A=
diff -r1.1.1.1 sock.c=0A=
1175c1175=0A=
< 	sk->allocation	=3D	GFP_KERNEL;=0A=
---=0A=
> 	sk->allocation	=3D	GFP_ATOMIC; /*GFP_KERNEL;*/=0A=

------=_NextPart_000_0173_01C38C3C.C0FF7780
Content-Type: application/octet-stream;
	name="r4k_switch.S.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="r4k_switch.S.patch"

Index: /home/sscott/work/Software/linux/arch/mips/kernel/r4k_switch.S=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: =
/usr/local/CVS/V4000/Software/linux/arch/mips/kernel/r4k_switch.S,v=0A=
retrieving revision 1.1.1.1=0A=
diff -r1.1.1.1 r4k_switch.S=0A=
38a39=0A=
> 	ori	t1, 0x1		/* srs - assume ints disabled in schedule(). Reenable =
when task resumes */=0A=
=0A=

------=_NextPart_000_0173_01C38C3C.C0FF7780
Content-Type: application/octet-stream;
	name="sched.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sched.c.patch"

Index: /home/sscott/work/Software/linux/kernel/sched.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /usr/local/CVS/V4000/Software/linux/kernel/sched.c,v=0A=
retrieving revision 1.1.1.1=0A=
diff -r1.1.1.1 sched.c=0A=
743c743=0A=
< 	spin_unlock_irq(&runqueue_lock);=0A=
---=0A=
> /*srs	spin_unlock_irq(&runqueue_lock); */=0A=
747a748=0A=
> /*srs*/	spin_unlock_irq(&runqueue_lock);=0A=

------=_NextPart_000_0173_01C38C3C.C0FF7780--
