Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2002 12:55:06 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:1420 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122960AbSITKzF>;
	Fri, 20 Sep 2002 12:55:05 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8KAsoUD018986;
	Fri, 20 Sep 2002 03:54:50 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA27733;
	Fri, 20 Sep 2002 03:55:05 -0700 (PDT)
Message-ID: <008401c26094$794952f0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Gareth" <g.c.bransby-99@student.lboro.ac.uk>,
	<linux-mips@linux-mips.org>
References: <20020920095623.5300295a.g.c.bransby-99@student.lboro.ac.uk>
Subject: Re: Cycles for certain instructions
Date: Fri, 20 Sep 2002 12:57:03 +0200
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
X-archive-position: 253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> I am doing an investigation with a mips malta board that has a 4kc processor on
> it. I am trying to find out how many cycles certain instructions take to
> execute.
> 
> The program I am running loops a small piece of code many times. After a few
> loops of the code the caches will have all the instructions in them and so 
> accesses to memory will be few and far between. So how many cycles do 
> instructions such as load word and store word take? Obviosly if the data is not
> in the cache the time take will depend on the speed of the external memory. If
> the data is in the cache is the time taken fairly predictable for a given core?

On a 4Kc, and indeed on the vast majority of MIPS CPUs,
if the data is in the cache, a load will pipeline fully.  Which is
to say, the following instruction will issue on the next clock.
*However*, if that following instruction uses the loaded data,
it will stall by one cycle waiting for the data to come back
from the cache.  Compilers for MIPS will generally try to stick
some useful instructions between load and load data use.

            Regards,

            Kevin K.
