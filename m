Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 08:46:10 +0000 (GMT)
Received: from 12-234-29-241.client.attbi.com ([IPv6:::ffff:12.234.29.241]:44418
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225192AbTB0IqJ>; Thu, 27 Feb 2003 08:46:09 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h1R8k6ln001720
	for <linux-mips@linux-mips.org>; Thu, 27 Feb 2003 00:46:07 -0800
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.5/8.12.5/Submit) id h1R8k1nq001718
	for linux-mips@linux-mips.org; Thu, 27 Feb 2003 00:46:01 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 27 Feb 2003 00:46:01 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: volatile question
Message-ID: <20030227084601.GC1246@greglaptop.attbi.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20030227005338.GB2077@greglaptop.internal.keyresearch.com> <003501c2de36$b27c8360$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003501c2de36$b27c8360$10eca8c0@grendel>
User-Agent: Mutt/1.4i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

> call_data is neither local nor static to the function, so the modification
> of the storage location would seem to be mandatory for the compiler
> before the call to core_send_ipi(),

Ah, yes. call_data is static but is scoped in the file, not the function.

And if you add OOO to the mix, I guess that the wb() becomes
necessary.

> I take it that you've observed a problem with this on your system?:

No. I had a bug that was freezing one of my cpus, so the other one was
eventually getting stuck in an endless loop in smp_call_function(). I
added a little debugging so it prink()ed when that happens, and then I
got to thinking about how smp_call_function() worked...

Personally, I think the kernel ought to not go into endless loops
without saying something useful on the console. Hanging in
smp_call_function() is always the symptom, not the bug, but still,
it's nice to print what is known instead of being silent.
Unfortunately, I see quite a few opportunities for endless loops in
device drivers (grrr). Makes you wonder how Windows works at all with
all those shitty but closed-source drivers.

-- greg
