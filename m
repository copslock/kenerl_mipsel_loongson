Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2O0b1214828
	for linux-mips-outgoing; Fri, 23 Mar 2001 16:37:01 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2O0b0M14825
	for <linux-mips@oss.sgi.com>; Fri, 23 Mar 2001 16:37:00 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id QAA29948;
	Fri, 23 Mar 2001 16:37:01 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA29978;
	Fri, 23 Mar 2001 16:36:57 -0800 (PST)
Message-ID: <01b801c0b3fb$1770b740$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <carlson@sibyte.com>, "Matthew Dharm" <mdharm@momenco.com>
Cc: <linux-mips@oss.sgi.com>
References: <NEBBLJGMNKKEEMNLHGAIKELLCAAA.mdharm@momenco.com> <01032316143609.00779@plugh.sibyte.com>
Subject: Re: Multiple processor support?
Date: Sat, 24 Mar 2001 01:40:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > Well, I'd like to know about both, frankly.  Tho I'm more interested
> > in whichever is designed to run on RM7000 series processors.

None are "designed" as such for the RM7000.  I don't have a
full RM7000 manual in the shop, but the short-form advance
manual that I do have, while it goes into a fair amount of
detail about the cache operations and external interface
protocols, makes no mention of any support for hardware
coherence of the sort provided by the R10000/R12000
(and the R4000/R4400 for that matter).  If there is no support
for cached/coherent memory attributes and cache interventions
from the system side, an SMP kernel design for an MP SGI box
might not be useful for an MP RM7K configuration.  It is possible,
but tricky, and at times unavoidably inefficient to build a
software-coherent SMP system.  I have not heard of anyone
doing so with MIPS/Linux.

> To the best of my knowledge, the mips64 tree only works in SMP on the
ip-27
> which is r10K based.  There would be a bit of work to get an RM7K  based
> multiprocessor system to run. A fair amount of the "generic" code in
> that tree is also pretty ip-27 specific, and so would need to be cleaned
up.
>
> I'm working on mips32 SMP support at the moment; there are no existing
ports of
> this tree to an SMP platform.  The mips64 stuff is certainly much, much
more
> mature.  I don't know of any reasons not to use the mips64 side for an
RM7K.

Well, one reason might be memory footprint...

            Regards,

            Kevin K.
