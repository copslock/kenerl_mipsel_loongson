Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 08:53:19 +0000 (GMT)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:60078 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225251AbTCDIxS>;
	Tue, 4 Mar 2003 08:53:18 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h248r6Ue016114;
	Tue, 4 Mar 2003 00:53:06 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA05620;
	Tue, 4 Mar 2003 00:53:07 -0800 (PST)
Message-ID: <007701c2e22c$66e30e70$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "TAKANO Ryousei" <takano@os-omicron.org>,
	<linux-mips@linux-mips.org>
References: <20030302121820.A30790@linux-mips.org><20030304011459.457.qmail@web13302.mail.yahoo.com> <20030304171340.1a9af44d.takano@os-omicron.org>
Subject: Re: JVM under Linux on MIPS
Date: Tue, 4 Mar 2003 09:59:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Mon, 3 Mar 2003 17:14:59 -0800 (PST)
> Rajesh Palani <rpalani2@yahoo.com> wrote:
> >    Has anyone had any success running any open source JVMs (other than Cobalt machines running Transvirtual's Kaffe) under
Linux/MIPS.
> >
>
> I have succeeded in running Kaffe 1.0.7 with --with-engine=jit3
> on a TANBAC TB0193 board (VR4181/66MHz).
> However, it was very poor performance. A hello world execution,
> for example, takes about 30 seconds.
> I think that a JIT initialization has taken a lot of time.

I'm very pleased to hear that you got it running on a Vr41xx,
but I'm curious about the JIT behavior you saw.  I can believe
that it could run "hello world", but does it really pass all the
internal regression tests ("make check")?  Are you running
a "normal" MIPS/Linux distribution which assumes a
hardware FPU and does kernel emulation where necessary,
or are you using a purely soft-float environment?  I ask
this because most of the problems I have with the JIT are
in areas where mixed integer/floating arguments are being
passed, and those might not be an issue with soft-float.

As for the performance you observed, how much memory
did you have on the board, and what kind of secondary storage
(disk?) hardware was used?  66MHz isn't fast, but the combined
compile-and-run time for Caffeinemark for the patched
kaffe 1.0.7 on a MIPS 5Kc core at 160MHz was in fact
pretty good, better than 3 Embedded Caffeienmarks
per megahertz, which isn't as fast as commercial dynmic
compilers, but which is still several times faster than most
commercial interpretive JVMs.  Running fully interpretive,
kaffe's performance is mediocre but reasonable, I certainly
wasn't seeing delays of 10 seconds to run "hello world",
which is roughly what one would expect scaling your reported
run time by the frequency.  I really think that you are far more
likely to have been I/O bound, either from paging or from file I/O.

            Kevin K.
