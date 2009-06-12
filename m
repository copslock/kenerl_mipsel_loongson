Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jun 2009 21:45:40 +0200 (CEST)
Received: from gateway03.websitewelcome.com ([69.93.37.25]:34529 "HELO
	gateway03.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1492117AbZFLTpf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Jun 2009 21:45:35 +0200
Received: (qmail 30393 invoked from network); 12 Jun 2009 19:50:03 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway03.websitewelcome.com with SMTP; 12 Jun 2009 19:50:03 -0000
Received: from 216-239-45-4.google.com ([216.239.45.4]:13608 helo=epiktistes.mtv.corp.google.com)
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1MFCgo-0005nq-3W; Fri, 12 Jun 2009 14:45:26 -0500
Message-ID: <4A32B056.5060707@paralogos.com>
Date:	Fri, 12 Jun 2009 12:45:26 -0700
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	Glyn Astill <glynastill@yahoo.co.uk>
CC:	linux-mips@linux-mips.org
Subject: Re: Qube2 slowly dies
References: <1099.9578.qm@web23606.mail.ird.yahoo.com>
In-Reply-To: <1099.9578.qm@web23606.mail.ird.yahoo.com>
Content-Type: multipart/alternative;
 boundary="------------050208030300020404060401"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050208030300020404060401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Glyn Astill wrote:
>> From: Kevin D. Kissell <kevink@paralogos.com>
>>     
>> Your description sounds an awful lot
>> like failures I've seen when 
>> interrupts get lost or blocked for some reason (could be
>> hardware, the 
>> kernel, or some interaction between them).  Have you
>> looked at 
>>  to see if "Spurious" interrupts are
>> occurring, or if 
>> the rate of serviced timer and I/O interrupts decreases or
>> increases as 
>> the system degrades?
>>     
>
> No I haven't checked - but I will. What would I be looking for that would stick out as "spurious"? The type of interrupt, qty or random interrupts appearing and dissapearing?
>   
There's a separate counter, and /proc/interrupts report, for spurious 
interrupts.
>   
>   
>> When the system becomes unresponsive, by any 
>> chance does it "wake up" after 10-20 minutes (the time for
>> the Count 
>> register to wrap)?
>>
>>     
>
> Not that I've noticed, I just see it degrade further and further untill it dies over the course of an hour or so.
>
>   
>> If other Qube2s don't exhibit this behavior with a given
>> Linux kernel, 
>> but yours does, and yet yours runs NetBSD OK, it suggests
>> that there's a 
>> difference in interrupt setup/handling between the two
>> systems that just 
>> happens to work around a hardware problem on your board.
>>     
>
> I'm sure that's a valid possibility, however I do have two of these machines and I have tried both with the same results.
>   
Ah.  I had misunderstood your messages to have stated that you had one 
Qube2 that exhibited the behavior while others did not.  In the actual 
case, it definitely sounds like a kernel interrupt management problem, 
either at the level of the interrupt controller support code or some bit 
of low-level management of the Status.IM interrupt mask.  If you can 
force the kernel to dump the state of the Status and Cause registers, as 
well as that of whatever outboard interrupt controller is on that thing, 
that would be good.  I used to have a hook in the NMI handler of my 
Malta kernels for that, which was useful when I was debugging the SMTC 
interrupt support, which was pretty subtle and nasty.  And why this 
failure mode sounds vaguely familiar.  ;o)  The interrupt 
ack/mask/enable machinery  has changed and standardized (for the better) 
since the Qube2 was a current product, and the controller "chip" 
struct/functions being used may not in fact be entirely correct for the 
platform, e.g. you may have non-atomic changes to interrupt masks being 
done that screw up in the presence of nested service.
> I also had a problem back when I tried etch with the 2.6.18 kernel, however in this case I saw no degraded performance at all, however after a some of hours of activity (anywhere between 2 and 24+) it'd just fall on it's ass.
>   
That's not a very scientific description of a failure.  I mean, did the 
Qube2 literally jump off the table? ;o)


          Regards,

          Kevin K.

--------------050208030300020404060401
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Glyn Astill wrote:
<blockquote cite="mid:1099.9578.qm@web23606.mail.ird.yahoo.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">From: Kevin D. Kissell <a class="moz-txt-link-rfc2396E" href="mailto:kevink@paralogos.com">&lt;kevink@paralogos.com&gt;</a>
    </pre>
  </blockquote>
  <blockquote type="cite">
    <pre wrap="">Your description sounds an awful lot
like failures I've seen when 
interrupts get lost or blocked for some reason (could be
hardware, the 
kernel, or some interaction between them).&nbsp; Have you
looked at 
 to see if "Spurious" interrupts are
occurring, or if 
the rate of serviced timer and I/O interrupts decreases or
increases as 
the system degrades?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
No I haven't checked - but I will. What would I be looking for that would stick out as "spurious"? The type of interrupt, qty or random interrupts appearing and dissapearing?
  </pre>
</blockquote>
There's a separate counter, and /proc/interrupts report, for spurious
interrupts.<br>
<blockquote cite="mid:1099.9578.qm@web23606.mail.ird.yahoo.com"
 type="cite">
  <pre wrap="">&nbsp; 
  </pre>
  <blockquote type="cite">
    <pre wrap="">When the system becomes unresponsive, by any 
chance does it "wake up" after 10-20 minutes (the time for
the Count 
register to wrap)?

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Not that I've noticed, I just see it degrade further and further untill it dies over the course of an hour or so.

  </pre>
  <blockquote type="cite">
    <pre wrap="">If other Qube2s don't exhibit this behavior with a given
Linux kernel, 
but yours does, and yet yours runs NetBSD OK, it suggests
that there's a 
difference in interrupt setup/handling between the two
systems that just 
happens to work around a hardware problem on your board.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'm sure that's a valid possibility, however I do have two of these machines and I have tried both with the same results.
  </pre>
</blockquote>
Ah.&nbsp; I had misunderstood your messages to have stated that you had one
Qube2 that exhibited the behavior while others did not.&nbsp; In the actual
case, it definitely sounds like a kernel interrupt management problem,
either at the level of the interrupt controller support code or some
bit of low-level management of the Status.IM interrupt mask.&nbsp; If you
can force the kernel to dump the state of the Status and Cause
registers, as well as that of whatever outboard interrupt controller is
on that thing, that would be good.&nbsp; I used to have a hook in the NMI
handler of my Malta kernels for that, which was useful when I was
debugging the SMTC interrupt support, which was pretty subtle and
nasty.&nbsp; And why this failure mode sounds vaguely familiar.&nbsp; ;o)&nbsp; The
interrupt ack/mask/enable machinery&nbsp; has changed and standardized (for
the better) since the Qube2 was a current product, and the controller
"chip" struct/functions being used may not in fact be entirely correct
for the platform, e.g. you may have non-atomic changes to interrupt
masks being done that screw up in the presence of nested service.<br>
<blockquote cite="mid:1099.9578.qm@web23606.mail.ird.yahoo.com"
 type="cite">
  <pre wrap="">
I also had a problem back when I tried etch with the 2.6.18 kernel, however in this case I saw no degraded performance at all, however after a some of hours of activity (anywhere between 2 and 24+) it'd just fall on it's ass.
  </pre>
</blockquote>
That's not a very scientific description of a failure.&nbsp; I mean, did the
Qube2 literally jump off the table? ;o)<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Regards,<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Kevin K.<br>
</body>
</html>

--------------050208030300020404060401--
