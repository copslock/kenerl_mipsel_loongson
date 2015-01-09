Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 14:23:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27011 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009522AbbAINXevm1bV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 14:23:34 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3B28390190841;
        Fri,  9 Jan 2015 13:23:26 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 9 Jan
 2015 13:23:28 +0000
Received: from hhmail02.hh.imgtec.org ([::1]) by hhmail02.hh.imgtec.org
 ([::1]) with mapi id 14.03.0224.002; Fri, 9 Jan 2015 13:23:28 +0000
From:   Daniel Sanders <Daniel.Sanders@imgtec.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <Paul.Burton@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "Behan Webster" <behanw@converseincode.com>
Subject: RE: [PATCH] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
Thread-Topic: [PATCH] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
Thread-Index: AQHQLAS56YXs0o1g/UiAxsa46wgpHJy3tI6AgAAQGhA=
Date:   Fri, 9 Jan 2015 13:23:27 +0000
Message-ID: <E484D272A3A61B4880CDF2E712E9279F458E68B8@hhmail02.hh.imgtec.org>
References: <1420805177-9087-1-git-send-email-daniel.sanders@imgtec.com>
 <54AFC6F3.1020300@cogentembedded.com>
In-Reply-To: <54AFC6F3.1020300@cogentembedded.com>
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
X-archive-position: 45024
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

Hi,

Thanks for the quick reply.

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov@cogentembedded.com]
> Sent: 09 January 2015 12:18
> To: Daniel Sanders; linux-mips@linux-mips.org; Ralf Baechle
> Cc: Paul Burton; Markos Chandras; James Hogan; Behan Webster
> Subject: Re: [PATCH] MIPS: Changed current_thread_info() to an equivalent
> supported by both clang and GCC
> 
> Hello.
> 
> On 1/9/2015 3:06 PM, Daniel Sanders wrote:
> 
> > Without this, a 'break' instruction is executed very early in the boot and
> > the boot hangs.
> 
> > The problem is that clang doesn't honour named registers on local variables
> > and silently treats them as normal uninitialized variables. However, it
> > does honour them on global variables.
> 
> > Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
> 
> [...]
> 
> > diff --git a/arch/mips/include/asm/thread_info.h
> b/arch/mips/include/asm/thread_info.h
> > index 99eea59..2a2f3c4 100644
> > --- a/arch/mips/include/asm/thread_info.h
> > +++ b/arch/mips/include/asm/thread_info.h
> > @@ -58,11 +58,11 @@ struct thread_info {
> >   #define init_stack		(init_thread_union.stack)
> >
> >   /* How to get the thread information struct from C.  */
> > +register struct thread_info *current_gp_register asm("$28");
> 
>     *static* missing?
> 
> WBR, Sergei

Combining 'register' and 'static' is invalid.

gcc gives:
arch/mips/include/asm/thread_info.h:61:1: error: multiple storage classes in declaration specifiers
 static register struct thread_info *current_gp_register asm("$28");
 ^

and clang gives:
arch/mips/include/asm/thread_info.h:61:8: error: cannot combine with previous 'static' declaration specifier
static register struct thread_info *current_gp_register asm("$28");
       ^
