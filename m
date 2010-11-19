Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 13:03:52 +0100 (CET)
Received: from service87.mimecast.com ([94.185.240.25]:53370 "HELO
        service87.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491188Ab0KSMDp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Nov 2010 13:03:45 +0100
Received: from cam-owa1.Emea.Arm.com (fw-tnat.cambridge.arm.com [217.140.96.21])
        by service87.mimecast.com;
        Fri, 19 Nov 2010 12:03:32 +0000
Received: from [10.1.68.185] ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
         Fri, 19 Nov 2010 12:03:30 +0000
Subject: Re: [PATCH 3/5] MIPS/Perf-events: Check event state in
 validate_event()
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, ralf@linux-mips.org,
        fweisbec@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, wuzhangjin@gmail.com,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com
In-Reply-To: <1290166051.2109.1539.camel@laptop>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
         <1290063401-25440-4-git-send-email-dengcheng.zhu@gmail.com>
         <1290159806.9342.7.camel@e102144-lin.cambridge.arm.com>
         <1290166051.2109.1539.camel@laptop>
Date:   Fri, 19 Nov 2010 12:03:27 +0000
Message-ID: <1290168207.8175.6.camel@e102144-lin.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1
X-OriginalArrivalTime: 19 Nov 2010 12:03:30.0603 (UTC) FILETIME=[C82DD7B0:01CB87E1]
X-MC-Unique: 110111912033201301
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
Precedence: bulk
X-list: linux-mips

On Fri, 2010-11-19 at 11:27 +0000, Peter Zijlstra wrote:
> > So this is the opposite of what we're doing on ARM. Our
> > approach is to ignore events that are OFF (or in the ERROR
> > state) or that belong to a different PMU. We do this by
> > allowing them to *pass* validation (i.e. by returning 1 above).
> > This means that we won't unconditionally fail a mixed event group.
> >
> > x86 does something similar in the collect_events function.
> 
> Right, note that the generic code only allows mixing with software
> events, so simply accepting them is ok as software events give the
> guarantee they're always schedulable.
> 
> 

Ok. Initially it was software events that I had in mind, but does
this constraint prevent you from grouping CPU events with events
for other PMUs within the system? For external L2 cache controllers
with their own PMUs, it would be desirable to group some L2 events
with L1 events on a different PMU.

If each PMU can validate its own events and ignore others then it
sounds like it should be straightforward...

Will
