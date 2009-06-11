Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 18:01:32 +0200 (CEST)
Received: from web23606.mail.ird.yahoo.com ([87.248.115.49]:26458 "HELO
	web23606.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1491945AbZFKQBV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Jun 2009 18:01:21 +0200
Received: (qmail 10286 invoked by uid 60001); 11 Jun 2009 08:54:44 -0000
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1244710484; bh=JAUfE4sUnmhot6DegniPz5I0oKLBluGxoLUhqmb+1Ck=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=li22FDONuF7Nx/uh6uTpFR9fGRD4Rfn8+ou0xNjENqPqvUcbkmz95Pzsu+8S73EkD5ffHq8KfZCT/Zkq2WfcmvfCVx/R1cdZV9dOoPI+7nuKHes9uA4TzG/xtu5kwJZGK2gi/f5AMoSRmqhU/Ba/8jqjNtvtLvd9ciaFeyti/wg=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bea3ruRM+zngDV9GMY0Z9HdM/mQCi8VqL+AX1hluO+9NP8MHZYXQCBohFRG8ynaAzJzG+SBtaJR0wpIE4tzRnR923cNiX32r+YwjVJMHnf6sQPfWGg+A+tl0w1ocaolw/RHv8T4X4l6Gubi45d1wSlSIDYJBQRF60G/kdH+6bIc=;
Message-ID: <1099.9578.qm@web23606.mail.ird.yahoo.com>
X-YMail-OSG: 3uJTitEVM1k9MmndMEE8PJiRlBatC8Wii4y7xmYyQfMF.S12oirt57zall71gyB02B.051_YWK.gRxmivJHsPbVvCWpHxEtTraFecZw1f4KIXiXoeVOX6d7itlu86eKY7TC17jcfrxE2avCo_uRl5L5VfyT8InC.QxxJPhG6SVvyJZjzMW359OswANXkugs4knqHIfBfOuj6904MHmVF3iFl2MFCLkk9iqmkQfiYA_NMnDHZXMKQRqMDf5B9ionPZvEjJnkg2Y.25ARxolQ3ZMc_R.vCtmHrYIkCpEoog2a4iJ6zxcMAlKKvY4IRXJQ2w9wfVwS_3_fBW.2zf5K3pzwf5LauDUyQNrNZY6KkFthSyw8v_1kYP3baKibjHEA-
Received: from [83.166.184.142] by web23606.mail.ird.yahoo.com via HTTP; Thu, 11 Jun 2009 08:54:43 GMT
X-Mailer: YahooMailClassic/5.4.12 YahooMailWebService/0.7.289.15
Date:	Thu, 11 Jun 2009 08:54:43 +0000 (GMT)
From:	Glyn Astill <glynastill@yahoo.co.uk>
Subject: Re: Qube2 slowly dies
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glynastill@yahoo.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glynastill@yahoo.co.uk
Precedence: bulk
X-list: linux-mips


Hi Kevin,

It's nice to see a scientific suggestion to the nature of the problem

> From: Kevin D. Kissell <kevink@paralogos.com>

> Your description sounds an awful lot
> like failures I've seen when 
> interrupts get lost or blocked for some reason (could be
> hardware, the 
> kernel, or some interaction between them).  Have you
> looked at 
>  to see if "Spurious" interrupts are
> occurring, or if 
> the rate of serviced timer and I/O interrupts decreases or
> increases as 
> the system degrades?

No I haven't checked - but I will. What would I be looking for that would stick out as "spurious"? The type of interrupt, qty or random interrupts appearing and dissapearing?
  
> When the system becomes unresponsive, by any 
> chance does it "wake up" after 10-20 minutes (the time for
> the Count 
> register to wrap)?
> 

Not that I've noticed, I just see it degrade further and further untill it dies over the course of an hour or so.

> If other Qube2s don't exhibit this behavior with a given
> Linux kernel, 
> but yours does, and yet yours runs NetBSD OK, it suggests
> that there's a 
> difference in interrupt setup/handling between the two
> systems that just 
> happens to work around a hardware problem on your board.

I'm sure that's a valid possibility, however I do have two of these machines and I have tried both with the same results.

I also had a problem back when I tried etch with the 2.6.18 kernel, however in this case I saw no degraded performance at all, however after a some of hours of activity (anywhere between 2 and 24+) it'd just fall on it's ass.

> 
>           Regards,
> 
>           Kevin K.
> 
> Glyn Astill wrote:
> > Hi people,
> >
> > I've been directed here from the Debian lists by
> Martin Michlmayr. I'm running lenny on a qube2 128mb ram /
> 40gb disk.
> >
> > I've tried kernels 2.6.26 and 2.6.30~rc8 and the issue
> I'm about to describe is present in both, I haven't tried
> any other kernels - but I will try 2.6.22 when I can.
> >
> > Essentially the machine gets more and more sluggish
> until it finally dies. I've had a quick look in meminfo and
> I can't see that it's running out of memory, and I'm not
> sure what else to check?
> >
> > I find it hard to describe what's going off, but
> here's a scenario I hope illustrates the problem. The
> configure script is just an example of doing something - I
> could easily have extracted an archive with tar or something
> for the same results;
> >
> > - I start 2 ssh sessions and in one start configure
> for the postgres source, in the other I just started top.
> >
> > - And for a while all seems fine; configure ticks away
> and top refreshes every second.
> >
> > - Then top stops ticking over - but it'll refresh with
> a keypress. Anyway I exit top and try to run it again...
> nothing. I hit ctrl-c which brings me back to the prompt and
> I try again... nothing.
> >
> > - The configure script is still ticking over slowly.
> >
> > - I try "ps ax" - it works; so I try it again...
> nothing.
> >
> > - I try "ipcs" and "lsof" they both work and seem to
> keep working.
> >
> > - I try "ps ax" again... nothing. I hit ctrl-c and now
> it doesn't come back to the command prompt for a while.. say
> 5 minutes and eventually it's back.
> >
> > - It's still going. Some commands still work, some
> just do nothing. proc/meminfo shows it's not eaten all the
> memory.
> >
> > - If I try to start another ssh session I can log in,
> I get the motd, but I don't get to the shell.
> >
> > - Eventually the configure script ends, and all shells
> come back to the prompt. But it now seems totally
> braindamaged, I can run "ps ax" but "top" and other commands
> still do nothing. Heres strace attached to the top process:
> >
> > deb:~# strace -p 7228
> > Process 7228 attached - interrupt to quit
> > _newselect(0, NULL, NULL, NULL, {0, 500013}
> >
> > - Then after a little while the whole thing becomes
> unresponsive.
> >
> >
> > Can anyone confirm they've seen the same behaviour or
> direct me what to look into?
> >
> > Thanks
> > Glyn
> >
> >
> >       
> >
> >   
> 
> 


      
