Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 08:54:49 +0100 (BST)
Received: from dns0.mips.com ([63.167.95.198]:38550 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20022960AbXI1Hyk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Sep 2007 08:54:40 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l8S7s2Hh006475;
	Fri, 28 Sep 2007 00:54:02 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l8S7sMlf029565;
	Fri, 28 Sep 2007 00:54:23 -0700 (PDT)
Message-ID: <006701c801a4$c9b84460$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Suprasad Mutalik Desai" <suprasad.desai@gmail.com>
Cc:	<linux-mips@linux-mips.org>
References: <52163af60709272223n72212e2bh197c7e622e3ba155@mail.gmail.com> <002801c80196$003f4dd0$10eca8c0@grendel> <52163af60709280006j23c781c7s75ba27b0285ddedc@mail.gmail.com>
Subject: Re: mapping a userspace thread to a kernelspace thread
Date:	Fri, 28 Sep 2007 09:54:22 +0200
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
X-archive-position: 16724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

CPU affinity, which in SMTC is effectively TC affinity, is inherited by child
processes.  There's a program called "taskset" that allows you to control
where a program will run from the shell command line, which is handy if
you don't want to modify the source (or don't have the source) of a program
that you want to explicitly place on a CPU/TC, or otherwise restrict to some 
subset of available "CPUs".  If you want to have a multithreaded application
with different threads running in the same address space but bound to different 
CPUs, you can in theory do this with taskset by feeding taskset the PIDs you 
want to bind, after they've been created, but that is pretty cumbersome, 
and impractical for benchmarks and programs with short lifetimes. Hacking in 
sys_sched_setaffinity() calls would probably be more efficient..

All this stuff works pretty well, but I would remind you that when you
set the CPU affinity mask for a thread, that merely constrains where
the thread is allowed to be scheduled.  It does *not* give that thread
100% monopoly on the CPU(s) selected by the mask.  Affinity does
not affect priority.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Suprasad Mutalik Desai" <suprasad.desai@gmail.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: <linux-mips@linux-mips.org>
Sent: Friday, September 28, 2007 9:06 AM
Subject: Re: mapping a userspace thread to a kernelspace thread


> Hi Kevin ,
> 
>             Thanks for the info .Now if i want to manage the
> thread->CPU binding explicity in an SMTC environment where we see TC
> (thread context) as a CPU . Then How can i make a kernel thread which
> is inturn created in response to the pthread_create , monopolize a CPU
> (TC) such that whenever i run a userspace program it should run on
> that particular TC (CPU) . Can i use the same
> sys_sched_setaffinity() system call  ? .
> 
> Thanks and Regards,
> Suprasad.
> 
> On 9/28/07, Kevin D. Kissell <kevink@mips.com> wrote:
> > You seem to be laboring under a misconception or two, here.  NPTL is a 1:1 threading
> > model (it would have been damned convenient for me for it not to have been).  Both
> > linuxthreads and NPTL will create a native, known-to-the-kernel thread, which is what
> > I think you mean by a "kernel thread", in response to a pthread_create().  The new thread
> > will start life on the same CPU that created it, but normal load balancing will generally
> > migrate it elsewhere pretty quickly.  If you want to manage thread->CPU binding
> > explicitly, the sys_sched_setaffinity() system call can be used.
> >
> >            Regards,
> >
> >            Kevin K.
> >
> > ----- Original Message -----
> > From: "Suprasad Mutalik Desai" <suprasad.desai@gmail.com>
> > To: <linux-mips@linux-mips.org>
> > Sent: Friday, September 28, 2007 7:23 AM
> > Subject: mapping a userspace thread to a kernelspace thread
> >
> >
> > > Hi list ,
> > >
> > >             I want to know how can we map a userspace thread to a
> > > kernel thread as mentioned in 1:1 threading model (linuxthreads) or
> > > M:N model (NPTL)  . Does this happen by just calling a
> > > pthread_create() in the userspace program or i need to do something
> > > more in the kernel space . i am using 2.6.20 kernel  .
> > >        I want to use this for multi threading operation in a SMP
> > > environment where in i want to schedule a userspace program on another
> > > processor by spawning a thread  . Can anyone help me in this.
> > >
> > > Thanks and regards,
> > > Suprasad.
> > >
> > >
> >
> 
