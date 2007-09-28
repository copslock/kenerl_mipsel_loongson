Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 08:06:28 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.237]:44608 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022923AbXI1HGU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Sep 2007 08:06:20 +0100
Received: by hu-out-0506.google.com with SMTP id 31so1382045huc
        for <linux-mips@linux-mips.org>; Fri, 28 Sep 2007 00:06:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GxPE3qHyhZ65PiHNdoFqYotw2SXY9oHkSwPO/Hy8NOg=;
        b=Tc7o8QrqiGNZ+s4ZZtSsbV6/1IkHsIOxRfDHeg9hcgyw8IU3dL9/G1xWa//NiVgQtBm4od3ufRzuOF0fva/sBfjoSnpklpFu9Z1+WAyr84/onV0Pf10utdAE+s7KHdUCTPX9BVhA3n1QZLNMOa1nggttntuuh6OY6YENNYpSHlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P1FuZikI0fjYM1N5TNH0wNerHxOQcZgZNlxwm4tOH33eKnoFEZ1yOuuQ+MIKpvaMNy2cQpQsjurM8XDz/0Z2SwPYSOJrQ92GOBV0ktttNcr4H0qowuNMeiKZ2WdaHvjBKKRe2eHAytxmz8b6T4KfaBfh2aNfHLhDOiPUSeTmAc4=
Received: by 10.67.98.20 with SMTP id a20mr4615717ugm.1190963161973;
        Fri, 28 Sep 2007 00:06:01 -0700 (PDT)
Received: by 10.86.71.18 with HTTP; Fri, 28 Sep 2007 00:06:01 -0700 (PDT)
Message-ID: <52163af60709280006j23c781c7s75ba27b0285ddedc@mail.gmail.com>
Date:	Fri, 28 Sep 2007 12:36:01 +0530
From:	"Suprasad Mutalik Desai" <suprasad.desai@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: mapping a userspace thread to a kernelspace thread
Cc:	linux-mips@linux-mips.org
In-Reply-To: <002801c80196$003f4dd0$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <52163af60709272223n72212e2bh197c7e622e3ba155@mail.gmail.com>
	 <002801c80196$003f4dd0$10eca8c0@grendel>
Return-Path: <suprasad.desai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: suprasad.desai@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Kevin ,

            Thanks for the info .Now if i want to manage the
thread->CPU binding explicity in an SMTC environment where we see TC
(thread context) as a CPU . Then How can i make a kernel thread which
is inturn created in response to the pthread_create , monopolize a CPU
(TC) such that whenever i run a userspace program it should run on
that particular TC (CPU) . Can i use the same
sys_sched_setaffinity() system call  ? .

Thanks and Regards,
Suprasad.

On 9/28/07, Kevin D. Kissell <kevink@mips.com> wrote:
> You seem to be laboring under a misconception or two, here.  NPTL is a 1:1 threading
> model (it would have been damned convenient for me for it not to have been).  Both
> linuxthreads and NPTL will create a native, known-to-the-kernel thread, which is what
> I think you mean by a "kernel thread", in response to a pthread_create().  The new thread
> will start life on the same CPU that created it, but normal load balancing will generally
> migrate it elsewhere pretty quickly.  If you want to manage thread->CPU binding
> explicitly, the sys_sched_setaffinity() system call can be used.
>
>            Regards,
>
>            Kevin K.
>
> ----- Original Message -----
> From: "Suprasad Mutalik Desai" <suprasad.desai@gmail.com>
> To: <linux-mips@linux-mips.org>
> Sent: Friday, September 28, 2007 7:23 AM
> Subject: mapping a userspace thread to a kernelspace thread
>
>
> > Hi list ,
> >
> >             I want to know how can we map a userspace thread to a
> > kernel thread as mentioned in 1:1 threading model (linuxthreads) or
> > M:N model (NPTL)  . Does this happen by just calling a
> > pthread_create() in the userspace program or i need to do something
> > more in the kernel space . i am using 2.6.20 kernel  .
> >        I want to use this for multi threading operation in a SMP
> > environment where in i want to schedule a userspace program on another
> > processor by spawning a thread  . Can anyone help me in this.
> >
> > Thanks and regards,
> > Suprasad.
> >
> >
>
