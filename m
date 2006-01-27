Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 10:07:33 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:5064 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133392AbWA0KHP
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 10:07:15 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0RABfEA026256;
	Fri, 27 Jan 2006 02:11:42 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id k0RABYYr010559;
	Fri, 27 Jan 2006 02:11:35 -0800 (PST)
Message-ID: <000b01c6232a$5ea81470$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Franck" <vagabon.xyz@gmail.com>, "Nigel Stephens" <nigel@mips.com>
Cc:	<linux-mips@linux-mips.org>
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com> <cda58cb80601251003m6ba4379w@mail.gmail.com> <43D7C050.5090607@mips.com> <cda58cb80601260702wf781e70l@mail.gmail.com> <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com> <cda58cb80601260831i61167787g@mail.gmail.com> <43D8FF16.40107@mips.com> <cda58cb80601261002w6eb02249k@mail.gmail.com> <43D93025.9040800@mips.com> <cda58cb80601270103t1419117cq@mail.gmail.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Date:	Fri, 27 Jan 2006 11:13:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> > You could, but why not stick with -march=4ksd if that's your CPU of
> > choice? It appears to result in  marginally smaller code even when using
> > -Os, and should have (slightly) better performance than a generic
> > mips32r2 kernel?
> 
> Just to avoid a new CPU_4KSD definition in the kernel code as
> suggested by Kevin. Basically all mips32r2 specific code is the same
> as 4ksd specific code (except the code that deals with SmartMIPS
> extension). So it can use CONFIG_CPU_MIPS32_R2 macro. But I was not
> aware of -march=4ksd and -march=mips32r2 differences. Maybe now it is
> needed to have a new CPU_4KSD definition ?

Configuration hacks that are specific to a single core create cruft and
maintenence problems.  As I said yesterday, I think we'd be much better
off to have a CONFIG_CPU_MIPS_SMALL or some such option
that could cause -Os to be used, allow branch-likelies, etc. The optimizations
under discussion aren't at all specific to the 4KSd, and I would think that
for every 4KSd embedded Linux platform there are several 4KEc platforms
that would benefit from a smaller kernel footprint.

It's Linux, and people can do what they want, but I'd prefer not to see more
core-specifc cruft work its way back into the linux-mips or kernel.org reference
trees.

            Regards,

            Kevin K.
