Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2003 17:32:06 +0100 (BST)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:35216 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8225296AbTHRPaK>;
	Mon, 18 Aug 2003 16:30:10 +0100
Received: from dlep52.itg.ti.com ([157.170.134.103])
	by go4.ext.ti.com (8.12.9/8.12.9) with ESMTP id h7IFU2wD003339;
	Mon, 18 Aug 2003 10:30:02 -0500 (CDT)
Received: from dlep90.itg.ti.com (localhost [127.0.0.1])
	by dlep52.itg.ti.com (8.12.9/8.12.9) with ESMTP id h7IFU1Th009461;
	Mon, 18 Aug 2003 10:30:02 -0500 (CDT)
Received: from dlee70.itg.ti.com (dlee70.itg.ti.com [157.170.135.145])
	by dlep90.itg.ti.com (8.12.9/8.12.9) with ESMTP id h7IFU1J5020712;
	Mon, 18 Aug 2003 10:30:01 -0500 (CDT)
Received: by dlee70.itg.ti.com with Internet Mail Service (5.5.2653.19)
	id <QZCGQSVR>; Mon, 18 Aug 2003 10:30:01 -0500
Received: from ti.com (cbc0794930.isr.asp.ti.com [137.167.2.134]) by dile70.itg.ti.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id Q6F2JCPJ; Mon, 18 Aug 2003 18:29:52 +0300
From: "Sirotkin, Alexander" <demiurg@ti.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Message-ID: <3F40F0F0.1080106@ti.com>
Date: Mon, 18 Aug 2003 18:29:52 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: tasklet latency and system calls on mips
References: <3F3A411C.70603@ti.com> <20030813095446.C9655@mvista.com> <3F3B53C0.30408@ti.com> <20030814094515.B1203@mvista.com>
In-Reply-To: <20030814094515.B1203@mvista.com>
Content-Type: multipart/alternative;
 boundary="------------080800070704020208060604"
Return-Path: <demiurg@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3065
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiurg@ti.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080800070704020208060604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Jun Sun wrote:


On Thu, Aug 14, 2003 at 12:17:52PM +0300, Sirotkin, Alexander wrote:

  

I suspect that what happens is as follows :



system call arrives and while it's being processed and interrupt to one

of the drivers arrives. This interrupt 

schedules a tasklet which however is not executed after the system call

finishes, 

    



The tasklet should be executed at the return of interrupt handling.

If not, there is a bug.

  

I have a feeling that we are going in circles. Tasklets are executed at
the return of interrupt handler.
However, I suspect that this is not enough. On mips (contrary to x86),
system call is NOT an interrupt.
It's a different exception with different handler. Therefore I suspect
that tasklets are NOT called at 
the end of system call exception handler (which is a different handler,
not do_IRQ).






  

only after the next timer

interrupt which causes up to 10 ms latency (not all the time, only when

somebody makes a system call).



    



BTW, make sure tasklet_schedule() is indeed called in an interrupt
handler.

I am not sure why will happen otherwise.



If you suspect it is a bug, you can easily trace them.  You may my

little tracing tool useful,

I can try to trace it, I just wanted to ensure that what I was saying
makes sense. See above.






	
http://linux.junsun.net/patches/generic/experimental/030716.a-jstrace.pa
tch
<http://linux.junsun.net/patches/generic/experimental/030716.a-jstrace.p
atch> 



Jun

  


-- 

Alexander Sirotkin

SW Engineer



Texas Instruments

Broadband Communications Israel (BCIL)

Tel:  +972-9-9706587

________________________________________________________________________

"Those who do not understand Unix are condemned to reinvent it, poorly."

      -- Henry Spencer 

--------------080800070704020208060604
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
<br>
<br>
Jun Sun wrote:<br>
<blockquote type="cite" cite="mid20030814094515.B1203@mvista.com">
  <pre wrap="">On Thu, Aug 14, 2003 at 12:17:52PM +0300, Sirotkin, Alexander wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I suspect that what happens is as follows :

system call arrives and while it's being processed and interrupt to one
of the drivers arrives. This interrupt 
schedules a tasklet which however is not executed after the system call
finishes, 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The tasklet should be executed at the return of interrupt handling.
If not, there is a bug.
  </pre>
</blockquote>
I have a feeling that we are going in circles. Tasklets are executed at
the return of interrupt handler.<br>
However, I suspect that this is not enough. On mips (contrary to x86),
system call is NOT an interrupt.<br>
It's a different exception with different handler. Therefore I suspect
that tasklets are NOT called at <br>
the end of system call exception handler (which is a different handler,
not do_IRQ).<br>
<blockquote type="cite" cite="mid20030814094515.B1203@mvista.com">
  <pre wrap="">

  </pre>
  <blockquote type="cite">
    <pre wrap="">only after the next timer
interrupt which causes up to 10 ms latency (not all the time, only when
somebody makes a system call).

    </pre>
  </blockquote>
  <pre wrap=""><!---->
BTW, make sure tasklet_schedule() is indeed called in an interrupt handler.
I am not sure why will happen otherwise.

If you suspect it is a bug, you can easily trace them.  You may my
little tracing tool useful,</pre>
</blockquote>
I can try to trace it, I just wanted to ensure that what I was saying
makes sense. See above.<br>
<blockquote type="cite" cite="mid20030814094515.B1203@mvista.com">
  <pre wrap="">

	<a class="moz-txt-link-freetext" href="http://linux.junsun.net/patches/generic/experimental/030716.a-jstrace.patch">http://linux.junsun.net/patches/generic/experimental/030716.a-jstrace.patch</a>

Jun
  </pre>
</blockquote>
<br>
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

--------------080800070704020208060604--
