Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 18:04:51 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:13526 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8224847AbSLDREu>;
	Wed, 4 Dec 2002 18:04:50 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB4H4XNf023765;
	Wed, 4 Dec 2002 09:04:33 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA23529;
	Wed, 4 Dec 2002 09:04:29 -0800 (PST)
Message-ID: <021401c29bb7$cd02abe0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Carsten Langgaard" <carstenl@mips.com>
Cc: <linux-mips@linux-mips.org>, "Jun Sun" <jsun@mvista.com>
References: <20021203224504.B13437@mvista.com> <007501c29b78$f34680e0$10eca8c0@grendel> <3DEDD414.3854664F@mips.com> <3DEDE537.CD58AD8F@mips.com> <013d01c29b95$fb487f60$10eca8c0@grendel> <3DEDFFB9.3312BA1A@mips.com>
Subject: Re: possible Malta 4Kc cache problem ...
Date: Wed, 4 Dec 2002 18:08:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> > I think that Carsten's patch (or equivalent) should certainly be
> > applied to the main tree, but I wonder how relevant it is here.
> > The flushes associated with trampolines don't do indexed
> > flush operations, do they?
> 
> True, but are we sure that it's the trampoline that's the problem here?

Jun Sun seemed to think it was. To quote his original message

"The problem involves emulating a "lw" instruction in cp1 branch delay
 slot, which needs to  set up trampoline in user stack.  The net effect
 looks as if the icache line or dcache line is not flushed properly."

I don't know what his actual observations were that lead to that
conclusion, but the resemblence to what was reported under LTP
with the pre-break_cow()-patch kernel intrigues me.

So, I repeat... 
> > ...I don't have a 4Kc platform at
> > hand, but I think that Jun Sun *may* have found a better
> > way to get at the other problem I was referring to, which
> > we rarely saw on non-superscalar issue CPUs, and which
> > seems to be masked by an otherwise superfluous flush of
> > the Icache that was added to the latest versions of break_cow().
> > If Carsten's patch solves the problem without applying that
> > other update, I'd want to know that.  If it *doesn't*, I'd be
> > really interested to know if, by any chance, there is a
> > corelation between failures of Jun Sun's test and the incidence
> > of page faults on the CACHE op in protected_icache_invalidate_line().
> >
> >             Kevin K.
