Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2003 14:02:07 +0100 (BST)
Received: from news.ti.com ([IPv6:::ffff:192.94.94.33]:45714 "EHLO
	dragon.ti.com") by linux-mips.org with ESMTP id <S8225208AbTHNJUW>;
	Thu, 14 Aug 2003 10:20:22 +0100
Received: from dlep50.itg.ti.com ([157.170.141.74])
	by dragon.ti.com (8.12.9/8.12.9) with ESMTP id h7E9KE1p011159;
	Thu, 14 Aug 2003 04:20:14 -0500 (CDT)
Received: from dlep90.itg.ti.com (localhost [127.0.0.1])
	by dlep50.itg.ti.com (8.12.9/8.12.9) with ESMTP id h7E9KE20001047;
	Thu, 14 Aug 2003 04:20:14 -0500 (CDT)
Received: from dlee70.itg.ti.com (dlee70.itg.ti.com [157.170.135.145])
	by dlep90.itg.ti.com (8.12.9/8.12.9) with ESMTP id h7E9KEJ5000338;
	Thu, 14 Aug 2003 04:20:14 -0500 (CDT)
Received: by dlee70.itg.ti.com with Internet Mail Service (5.5.2653.19)
	id <QZCGMJG5>; Thu, 14 Aug 2003 04:20:14 -0500
Received: from ti.com (cbc0794930.isr.asp.ti.com [137.167.2.134]) by dile70.itg.ti.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id Q6F22TL6; Thu, 14 Aug 2003 12:17:52 +0300
From: "Sirotkin, Alexander" <demiurg@ti.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Message-ID: <3F3B53C0.30408@ti.com>
Date: Thu, 14 Aug 2003 12:17:52 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: tasklet latency and system calls on mips
References: <3F3A411C.70603@ti.com> <20030813095446.C9655@mvista.com>
In-Reply-To: <20030813095446.C9655@mvista.com>
Content-Type: multipart/alternative;
 boundary="------------060908050308030909000207"
Return-Path: <demiurg@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3049
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiurg@ti.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060908050308030909000207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

See my comments below.

Jun Sun wrote:


On Wed, Aug 13, 2003 at 04:46:04PM +0300, Sirotkin, Alexander wrote:

  

Hello dearest all.



I have a question regarding tasklets on MIPS. I suspect that there is a

bug in generic MIPS kernel, but I'm not sure yet.



Linux kernel has a couple of so called "checkpoints" when the system

should check if there are tasklets to

run and run them in the following way :



if (softirq_pending(cpu))

                    do_softirq();



One of these places is at the end of interrupt handler (do_IRQ()),

however this is not the only place. I was under

impression that this code should be called after system call too. The

caveat here is that on MIPS (contrary to

other architectures, such as x86) system call is not an interrupt (it's

a different exception) and has completely

different handler. So in x86 it is sufficient to call



if (softirq_pending(cpu))

                    do_softirq();



at the end of do_IRQ because do_IRQ handles system call too, but on MIPS

it is not. Therefore I believe

these lines should be added to the end of sys_syscall function on MIPS.



What do you think ?



    



softirq/tasklet/bottom_half/etc should only be raised from interrupt

context.  Checking at the end of do_IRQ should be good enough.

  

On mips interrupt is an exception and system call is a different
exception. Different exceptions has different exception handlers,
at least that's what I was able to figure from entry.S file. So the
system call does not go through do_IRQ and do_softirq
is not called.





One possible mistake in MIPS porting is that if the board uses its
private

time interrupt routine poeple may forget to put the above two lines

at the end.  Check against that.

  

In our kernel port we do have these lines in the timer interrupt, that
is not a problem. 



P.S. The whole issue started when we noticed that user process making

many system calls has very

significant impact on device drivers running in tasklet mode 

    



What kind of impact?  On i386? Or on MIPS?



  

Jun


The impact is that if our driver works in tasklet mode then some user
mode application making system calls
causes some (although quite small) packet loss. It does not happen if we
don't use tasklet and do everything in the
ISR.

I suspect that what happens is as follows :

system call arrives and while it's being processed and interrupt to one
of the drivers arrives. This interrupt 
schedules a tasklet which however is not executed after the system call
finishes, only after the next timer
interrupt which causes up to 10 ms latency (not all the time, only when
somebody makes a system call).

It only happens on MIPS. There is no easy way to check this on x86.
-- 

Alexander Sirotkin

SW Engineer



Texas Instruments

Broadband Communications Israel (BCIL)

Tel:  +972-9-9706587

________________________________________________________________________

"Those who do not understand Unix are condemned to reinvent it, poorly."

      -- Henry Spencer 

--------------060908050308030909000207
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Hi.<br>
<br>
See my comments below.<br>
<br>
Jun Sun wrote:<br>
<blockquote type="cite" cite="mid20030813095446.C9655@mvista.com">
  <pre wrap="">On Wed, Aug 13, 2003 at 04:46:04PM +0300, Sirotkin, Alexander wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello dearest all.

I have a question regarding tasklets on MIPS. I suspect that there is a
bug in generic MIPS kernel, but I'm not sure yet.

Linux kernel has a couple of so called "checkpoints" when the system
should check if there are tasklets to
run and run them in the following way :

if (softirq_pending(cpu))
                    do_softirq();

One of these places is at the end of interrupt handler (do_IRQ()),
however this is not the only place. I was under
impression that this code should be called after system call too. The
caveat here is that on MIPS (contrary to
other architectures, such as x86) system call is not an interrupt (it's
a different exception) and has completely
different handler. So in x86 it is sufficient to call

if (softirq_pending(cpu))
                    do_softirq();

at the end of do_IRQ because do_IRQ handles system call too, but on MIPS
it is not. Therefore I believe
these lines should be added to the end of sys_syscall function on MIPS.

What do you think ?

    </pre>
  </blockquote>
  <pre wrap=""><!---->
softirq/tasklet/bottom_half/etc should only be raised from interrupt
context.  Checking at the end of do_IRQ should be good enough.
  </pre>
</blockquote>
On mips interrupt is an exception and system call is a different
exception. Different exceptions has different exception handlers,<br>
at least that's what I was able to figure from entry.S file. So the
system call does not go through do_IRQ and do_softirq<br>
is not called.<br>
<br>
<blockquote type="cite" cite="mid20030813095446.C9655@mvista.com">
  <pre wrap="">
One possible mistake in MIPS porting is that if the board uses its private
time interrupt routine poeple may forget to put the above two lines
at the end.  Check against that.
  </pre>
</blockquote>
In our kernel port we do have these lines in the timer interrupt, that
is not a problem. <br>
<br>
<blockquote type="cite" cite="mid20030813095446.C9655@mvista.com">
  <blockquote type="cite">
    <pre wrap="">P.S. The whole issue started when we noticed that user process making
many system calls has very
significant impact on device drivers running in tasklet mode 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
What kind of impact?  On i386? Or on MIPS?

  </pre>
</blockquote>
<blockquote type="cite" cite="mid20030813095446.C9655@mvista.com">
  <pre wrap="">Jun</pre>
</blockquote>
<br>
The impact is that if our driver works in tasklet mode then some user
mode application making system calls<br>
causes some (although quite small) packet loss. It does not happen if
we don't use tasklet and do everything in the<br>
ISR.<br>
<br>
I suspect that what happens is as follows :<br>
<br>
system call arrives and while it's being processed and interrupt to one
of the drivers arrives. This interrupt <br>
schedules a tasklet which however is not executed after the system call
finishes, only after the next timer<br>
interrupt which causes up to 10 ms latency (not all the time, only when
somebody makes a system call).<br>
<pre wrap="">It only happens on MIPS. There is no easy way to check this on x86.
</pre>
<pre class="moz-signature" cols="72">-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 
</pre>
</body>
</html>

--------------060908050308030909000207--
