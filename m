Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K9RYG06644
	for linux-mips-outgoing; Wed, 20 Feb 2002 01:27:34 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K9RS906640
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 01:27:29 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g1K8RK411834;
	Wed, 20 Feb 2002 08:27:21 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15475.24039.877276.257999@gladsmuir.algor.co.uk>
Date: Wed, 20 Feb 2002 08:27:19 +0000
To: Jun Sun <jsun@mvista.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
In-Reply-To: <20020219171238.E25739@mvista.com>
References: <3C6C6ACF.CAD2FFC@mvista.com>
	<20020215031118.B21011@dea.linux-mips.net>
	<20020214232030.A3601@mvista.com>
	<20020215003037.A3670@mvista.com>
	<002b01c1b607$6afbd5c0$10eca8c0@grendel>
	<20020219140514.C25739@mvista.com>
	<00af01c1b9a2$c0d6d5f0$10eca8c0@grendel>
	<20020219171238.E25739@mvista.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Somewhere in this thread:

> > > > > Hmm, I see. The lazy fpu context switch code is not SMP safe.
> > > > > I see fishy things like "last_task_used_math" etc...

Lazy FPU context switching?  Let's turn the whole thing off...

It may be heretical... but the lazy FPU context switch was invented
for 16MHz CPUs using a write-through cache and non-burst memory, where
saving 16 x 64-bit registers took 6us or so (and quite a bit less,
later, to read them back).  Call it 8us.

A 500MHz CPU with a writeback primary cache - which typically keeps up
with the CPU pipeline - takes about 120ns to do the job (there are
more registers these days).  The overhead is not only less than 2% in
absolute terms, but is about a third what it used to be relative to
the overall CPU performance...

Really, is it worth all this trouble?

Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
