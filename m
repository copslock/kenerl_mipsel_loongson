Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Jun 2009 01:26:53 +0200 (CEST)
Received: from gateway02.websitewelcome.com ([74.52.222.226]:50052 "HELO
	gateway02.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1492200AbZFLX0r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 13 Jun 2009 01:26:47 +0200
Received: (qmail 20168 invoked from network); 12 Jun 2009 23:31:01 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway02.websitewelcome.com with SMTP; 12 Jun 2009 23:31:01 -0000
Received: from 216-239-45-4.google.com ([216.239.45.4]:60708 helo=epiktistes.mtv.corp.google.com)
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1MFG8q-00049B-5y; Fri, 12 Jun 2009 18:26:36 -0500
Message-ID: <4A32E42C.6000801@paralogos.com>
Date:	Fri, 12 Jun 2009 16:26:36 -0700
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	Anoop P A <an4linu@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: smtc support
References: <eefc325c0906121335i6b575864kd10ca52948c36bd8@mail.gmail.com>	 <4A32C3EC.4060606@paralogos.com> <eefc325c0906121428y53a969eahe4f194eae58b8ebb@mail.gmail.com>
In-Reply-To: <eefc325c0906121428y53a969eahe4f194eae58b8ebb@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------020404080604030707090800"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020404080604030707090800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Performance impact of SMTC varies enormously with the job mix and the 
system configuration.  The 34K core is based on the 24K pipeline, which 
is pretty efficient, so  if you're not missing in the caches or doing a 
lot of targeted multiplies, there's not always a whole lot of dead 
cycles to fill with multiple threads.  And to sponge up cache miss stall 
cycles, the memory controller has to be able to handle the multiple 
streams of outstanding requests, which isn't the case in some systems 
that were originally designed for the 24K.  I gave a paper at the HiPEAC 
conference last January which showed performance impact on various 
microbenchmarks of SMTC.  This looks to (finally) be freely downloadable 
at http://www.springerlink.com/index/787307253g2644h4.pdf

If you're not planning on doing anything else with the other VPE (i.e. 
RTOS or some other scheduling domain), using it for virtual SMP is an 
option.  The kernel will be a little smaller than SMTC, and some 
internal functions will be faster.  You'll be limited to 2-way 
parallelism, but going from 1 to 2 is always the step that gives the 
biggest performance increase. The general pattern seems to be that going 
from 2 to 3 gives you half again what you got from 1->2, three to for 
gives you half again what you got from 2->3, etc., up to the point where 
the pipeline saturates or you start thrashing the cache.  Most of the 
experiments I ran showed the sweet spot to be 3 or 4 threads per core. 
SMTC also has the slight advantage of making all threads use a common 
ASID space and share the same TLB, while the VPE SMP scheme splits the 
TLB between the two VPEs.  This makes a difference if you're running 
with large, parallel working sets, but you won't see much of an impact 
on small benchmarks.

I think that the biggest potential advantage of SMTC probably comes not 
from increasing throughput per se, but from using it in conjunction with 
the YIELD instruction to provide zero-latency user-mode event handling, 
but one has to have the right signals wired to the YQ inputs of the core 
to exploit it.

             Regards,

             Kevin K.

Anoop P A wrote:
>
>
> Thanks for your inputs. 
>
> My platforms support is not available in lmo kernel.( So I am free to 
> use any version of kernel :) ) 
>
> Since you are the guy who wrote SMTC stuff , I think you are the right 
> person to answer few of my queries. How much performance improvement 
> you are getting in SMTC mode. Will it give us any reasonable 
> performance improvements.( As I could see some other negaive comments 
> . just curious!). Does it make sence to use SMP ( my SOC is having 2 
> VPE each with couple of threads). 
>
> Thanks
> An
>
>
>
> On Sat, Jun 13, 2009 at 2:39 AM, Kevin D. Kissell 
> <kevink@paralogos.com <mailto:kevink@paralogos.com>> wrote:
>
>     As the guy who wrote the SMTC stuff, I'd recommend picking up
>     something newer.  Ralf has merged some of the subsequent
>     improvements and fixes into 2.6.18, but not the patches that I
>     made last year to allow tickless support, which is actually a
>     very, very good thing to have for SMTC.  That support was
>     initially available in 2.6.24, but subsequently got broken by some
>     changes to control register manipulation APIs that I identified
>     and fixed a few months ago.  Ralf back-merged them into several
>     recent baselines, but I'm not sure which ones. 2.6.29-stable seems
>     to have all the right patches applied for SMTC, but of course I
>     can't tell whether there would be other issues for your platform.
>
>             Regards,
>
>             Kevin K.
>
>
>     Anoop P A wrote:
>
>         Hi List,
>
>         I have got a reference board with mips 34k core SOC.I am
>         planning to enable smtc/smp support . The reference kernel I
>         am having is linux-2.6.18 which is in uniprocessor mode.
>
>          Could any of you suggest me in which way i have to proceed?.
>         Does it make sense to continue using 2.6.18 or port newer
>         kernel version ( which might be having better SMTC/SMP support)?
>         Thanks
>         An
>
>
>


--------------020404080604030707090800
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Performance impact of SMTC varies enormously with the job mix and the
system configuration.&nbsp; The 34K core is based on the 24K pipeline, which
is pretty efficient, so&nbsp; if you're not missing in the caches or doing a
lot of targeted multiplies, there's not always a whole lot of dead
cycles to fill with multiple threads.&nbsp; And to sponge up cache miss
stall cycles, the memory controller has to be able to handle the
multiple streams of outstanding requests, which isn't the case in some
systems that were originally designed for the 24K.&nbsp; I gave a paper at
the HiPEAC conference last January which showed performance impact on
various microbenchmarks of SMTC.&nbsp; This looks to (finally) be freely
downloadable at <a class="moz-txt-link-freetext" href="http://www.springerlink.com/index/787307253g2644h4.pdf">http://www.springerlink.com/index/787307253g2644h4.pdf</a><br>
<br>
If you're not planning on doing anything else with the other VPE (i.e.
RTOS or some other scheduling domain), using it for virtual SMP is an
option.&nbsp; The kernel will be a little smaller than SMTC, and some
internal functions will be faster.&nbsp; You'll be limited to 2-way
parallelism, but going from 1 to 2 is always the step that gives the
biggest performance increase. The general pattern seems to be that
going from 2 to 3 gives you half again what you got from 1-&gt;2, three
to for gives you half again what you got from 2-&gt;3, etc., up to the
point where the pipeline saturates or you start thrashing the cache.&nbsp;
Most of the experiments I ran showed the sweet spot to be 3 or 4
threads per core. SMTC also has the slight advantage of making all
threads use a common ASID space and share the same TLB, while the VPE
SMP scheme splits the TLB between the two VPEs.&nbsp; This makes a
difference if you're running with large, parallel working sets, but you
won't see much of an impact on small benchmarks.<br>
<br>
I think that the biggest potential advantage of SMTC probably comes not
from increasing throughput per se, but from using it in conjunction
with the YIELD instruction to provide zero-latency user-mode event
handling, but one has to have the right signals wired to the YQ inputs
of the core to exploit it.<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Regards,<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Kevin K.<br>
<br>
Anoop P A wrote:
<blockquote
 cite="mid:eefc325c0906121428y53a969eahe4f194eae58b8ebb@mail.gmail.com"
 type="cite"><br>
  <div><br>
  </div>
  <div>Thanks for your inputs.&nbsp;</div>
  <div><br>
  </div>
  <div>My platforms support is not available in lmo kernel.( So I am
free to use any version of kernel :) )&nbsp;</div>
  <div><br>
  </div>
  <div>Since you are the guy who wrote SMTC stuff , I think you are the
right person to answer few of my queries. How much performance
improvement you are getting in SMTC mode. Will it give us any
reasonable performance improvements.( As I could see some other negaive
comments . just curious!). Does it make sence to use SMP ( my SOC is
having 2 VPE each with couple of threads).&nbsp;</div>
  <div><br>
  </div>
  <div>Thanks</div>
  <div>An</div>
  <div><br>
  </div>
  <div><br>
  <br>
  <div class="gmail_quote">On Sat, Jun 13, 2009 at 2:39 AM, Kevin D.
Kissell <span dir="ltr">&lt;<a moz-do-not-send="true"
 href="mailto:kevink@paralogos.com">kevink@paralogos.com</a>&gt;</span>
wrote:<br>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">As
the guy who wrote the SMTC stuff, I'd recommend picking up something
newer. &nbsp;Ralf has merged some of the subsequent improvements and fixes
into 2.6.18, but not the patches that I made last year to allow
tickless support, which is actually a very, very good thing to have for
SMTC. &nbsp;That support was initially available in 2.6.24, but subsequently
got broken by some changes to control register manipulation APIs that I
identified and fixed a few months ago. &nbsp;Ralf back-merged them into
several recent baselines, but I'm not sure which ones. 2.6.29-stable
seems to have all the right patches applied for SMTC, but of course I
can't tell whether there would be other issues for your platform.<br>
    <br>
&nbsp; &nbsp; &nbsp; &nbsp; Regards,<br>
    <br>
&nbsp; &nbsp; &nbsp; &nbsp; Kevin K.
    <div>
    <div class="h5"><br>
    <br>
Anoop P A wrote:<br>
    <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi List,<br>
      <br>
I have got a reference board with mips 34k core SOC.I am planning to
enable smtc/smp support . The reference kernel I am having is
linux-2.6.18 which is in uniprocessor mode.<br>
      <br>
&nbsp;Could any of you suggest me in which way i have to proceed?. Does it
make sense to continue using 2.6.18 or port newer kernel version (
which might be having better SMTC/SMP support)? <br>
Thanks<br>
An<br>
    </blockquote>
    <br>
    </div>
    </div>
  </blockquote>
  </div>
  <br>
  </div>
</blockquote>
<br>
</body>
</html>

--------------020404080604030707090800--
