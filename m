Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2007 20:47:59 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:21393 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20021692AbXG0Tr5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2007 20:47:57 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l6RJllGl011329
	for <linux-mips@linux-mips.org>; Fri, 27 Jul 2007 12:47:47 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l6RJll7e005081
	for <linux-mips@linux-mips.org>; Fri, 27 Jul 2007 12:47:48 -0700 (PDT)
Message-ID: <023a01c7d087$02943c20$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	<linux-mips@linux-mips.org>
References: <S20021645AbXG0Sih/20070727183837Z+1462@ftp.linux-mips.org>
Subject: Re: [MIPS] SMTC: smtc_timer_broadcast ignores its arguments, make it void.
Date:	Fri, 27 Jul 2007 21:47:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

The argument to smtc_timer_broadcast() is supposed to be a VPE number.
Somewhere between the earliest prototypes and the current linux-mips.org
tree, it got hacked up to ignore the argument and broadcast to all TCs.
There are still configurations out there, some of which I've worked on 
pretty recently, where the platform code can be configured to either
do global or VPE-local broadcasting of timer interrupts.  While we have
determined that it's pretty important to ensure that, in an SMTC configuration,
having the Count registers of all VPEs in sync is important to avoid timing
glitches, skewing the starting Compare values should help even out the load
and reduce contention for the locks on the scheduler queues. Getting rid
of the argument to smtc_timer_broadcast() makes that impossible.  I'd 
rather see the platform timer code iterate through the configured VPEs 
and keep the argument.

The most recent smtc_timer_broadcast() I've worked on looks like:

void smtc_timer_broadcast(int vpe)
{
        int cpu;
        int myTC = cpu_data[smp_processor_id()].tc_id;

        smtc_cpu_stats[smp_processor_id()].timerints++;

        for_each_online_cpu(cpu) {
                if (cpu_data[cpu].vpe_id == vpe &&
                    cpu_data[cpu].tc_id != myTC)
                        smtc_send_ipi(cpu, SMTC_CLOCK_TICK, 0);
        }
}

        Regards,

        Kevin K.


----- Original Message ----- 
From: <linux-mips@linux-mips.org>
To: <git-commits@linux-mips.org>
Sent: Friday, July 27, 2007 8:38 PM
Subject: [MIPS] SMTC: smtc_timer_broadcast ignores its arguments, make it void.


> Author: Ralf Baechle <ralf@linux-mips.org> Fri Jul 27 18:39:19 2007 +0100
> Commit: c58f4590261e0ad5f7c3e189652a61186403c35c
> Gitweb: http://www.linux-mips.org/g/linux/c58f4590
> Branch: master
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 
>  arch/mips/kernel/smtc.c              |    2 +-
>  arch/mips/mips-boards/generic/time.c |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
