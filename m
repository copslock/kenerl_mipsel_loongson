Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0PICwJ19306
	for linux-mips-outgoing; Fri, 25 Jan 2002 10:12:58 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0PICpP19285;
	Fri, 25 Jan 2002 10:12:51 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA24804;
	Fri, 25 Jan 2002 09:12:41 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA02330;
	Fri, 25 Jan 2002 09:12:30 -0800 (PST)
Message-ID: <002b01c1a5c3$f1b71d80$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, "Girish Gulawani" <girishvg@yahoo.com>
Cc: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
References: <3C505900.9685DDE3@cotw.com> <003901c1a532$d01576e0$de920dd3@gol.com> <20020124174521.B8860@dea.linux-mips.net>
Subject: Re: MIPS/Linux NonSGI
Date: Fri, 25 Jan 2002 18:15:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> On Fri, Jan 25, 2002 at 08:41:10AM +0900, Girish Gulawani wrote:
>
> > i'm trying to bringup linux 2.4.[2|9] on our board based on LSI mips r4k
> > core.

[snip]

> Seems pretty obvious that cacheflushing for your system is broken.

Sure sounds like it.

> Verify that arch/mips/mm/c-r4k.c knows how to handle your system.
>
>   Ralf

LSI has done a number of R3K and R4K-like designs under
their MIPS architecture license which have features
that differ from the main stream of MIPS CPUs where the OS
is concerned.  Cache manipulation is a case in point.
If it's not obvious to you from the cache management
code, compare the relevant sections of your CPU manual
with the MIPS32 spec (which I think is on the web somewhere
at www.mips.com) or a copy of the R4000 manual if you
can find one kicking around somewhere.

            Regards,

            Kevin K.
