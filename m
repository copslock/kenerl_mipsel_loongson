Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2015 13:53:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17086 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010903AbbAJMxabWQb6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jan 2015 13:53:30 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D9AA6B53A7B29;
        Sat, 10 Jan 2015 12:53:21 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 10 Jan
 2015 12:53:24 +0000
Received: from hhmail02.hh.imgtec.org ([::1]) by hhmail02.hh.imgtec.org
 ([::1]) with mapi id 14.03.0224.002; Sat, 10 Jan 2015 12:53:23 +0000
From:   Daniel Sanders <Daniel.Sanders@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "Behan Webster" <behanw@converseincode.com>
Subject: RE: [PATCH] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
Thread-Topic: [PATCH] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
Thread-Index: AQHQLAS56YXs0o1g/UiAxsa46wgpHJy3tI6AgAAQGhCAAEYSAIAAA41AgABocgCAANawYA==
Date:   Sat, 10 Jan 2015 12:53:22 +0000
Message-ID: <E484D272A3A61B4880CDF2E712E9279F458E8336@hhmail02.hh.imgtec.org>
References: <1420805177-9087-1-git-send-email-daniel.sanders@imgtec.com>
 <54AFC6F3.1020300@cogentembedded.com>
 <E484D272A3A61B4880CDF2E712E9279F458E68B8@hhmail02.hh.imgtec.org>
 <54B00F3C.8030903@gmail.com>
 <E484D272A3A61B4880CDF2E712E9279F458E7DF1@hhmail02.hh.imgtec.org>
 <54B069D4.4090608@gmail.com>
In-Reply-To: <54B069D4.4090608@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.14.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Daniel.Sanders@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

> -----Original Message-----
> From: David Daney [mailto:ddaney.cavm@gmail.com]
> Sent: 09 January 2015 23:53
> To: Daniel Sanders
> Cc: Sergei Shtylyov; linux-mips@linux-mips.org; Ralf Baechle; Paul Burton;
> Markos Chandras; James Hogan; Behan Webster
> Subject: Re: [PATCH] MIPS: Changed current_thread_info() to an equivalent
> supported by both clang and GCC
> 
> On 01/09/2015 12:06 PM, Daniel Sanders wrote:
> >> -----Original Message-----
> >> From: David Daney [mailto:ddaney.cavm@gmail.com]
> [...]
> 
> >
> >>>>> Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
> >>>>
> >>>> [...]
> >>>>
> >>>>> diff --git a/arch/mips/include/asm/thread_info.h
> >>>> b/arch/mips/include/asm/thread_info.h
> >>>>> index 99eea59..2a2f3c4 100644
> >>>>> --- a/arch/mips/include/asm/thread_info.h
> >>>>> +++ b/arch/mips/include/asm/thread_info.h
> >>>>> @@ -58,11 +58,11 @@ struct thread_info {
> >>>>>     #define init_stack		(init_thread_union.stack)
> >>>>>
> >>>>>     /* How to get the thread information struct from C.  */
> >>>>> +register struct thread_info *current_gp_register asm("$28");
> >>>>
> >>>>       *static* missing?
> >>>>
> >>>> WBR, Sergei
> >>>
> >>> Combining 'register' and 'static' is invalid.
> >>
> >> Defining global variables in header files is also invalid.
> >
> > I agree with that statement but named register globals are not the same as
> normal global variables. In particular, they do not take up space in the data
> section and they do not have an entry in the symbol table. They can therefore
> be included in multiple objects without causing link errors.
> >
> 
> Well, the GCC manual seems to bless your usage, so I withdraw my
> objection on making this global.  But, changing the name to
> "current_gp_register" removes information about what it is used for.
> 
> Can you resend that patch so that it still has the name
> "__current_thread_info", and only moves it to the global scope?
> 
> Thanks,
> David Daney

Sure. I'll Cc you directly on the re-send.

The main reason I renamed it is that identifiers starting with '__' are reserved. It's pretty unlikely but it's possible that the name will conflict with a C implementation in the future.
