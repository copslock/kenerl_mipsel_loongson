Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2015 17:16:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62939 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009651AbbAQQQQkdKlr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jan 2015 17:16:16 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BA93A81132253;
        Sat, 17 Jan 2015 16:16:07 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 17 Jan
 2015 16:16:10 +0000
Received: from hhmail02.hh.imgtec.org ([::1]) by hhmail02.hh.imgtec.org
 ([::1]) with mapi id 14.03.0224.002; Sat, 17 Jan 2015 16:16:09 +0000
From:   Daniel Sanders <Daniel.Sanders@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Markos Chandras" <Markos.Chandras@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Behan Webster <behanw@converseincode.com>
Subject: RE: [PATCH] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
Thread-Topic: [PATCH] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
Thread-Index: AQHQLAS56YXs0o1g/UiAxsa46wgpHJy3tI6AgAAQGhCAAEYSAIAAA41AgABocgCAANawYIAJjnGAgAGqCaA=
Date:   Sat, 17 Jan 2015 16:16:08 +0000
Message-ID: <E484D272A3A61B4880CDF2E712E9279F4590386C@hhmail02.hh.imgtec.org>
References: <1420805177-9087-1-git-send-email-daniel.sanders@imgtec.com>
 <54AFC6F3.1020300@cogentembedded.com>
 <E484D272A3A61B4880CDF2E712E9279F458E68B8@hhmail02.hh.imgtec.org>
 <54B00F3C.8030903@gmail.com>
 <E484D272A3A61B4880CDF2E712E9279F458E7DF1@hhmail02.hh.imgtec.org>
 <54B069D4.4090608@gmail.com>
 <E484D272A3A61B4880CDF2E712E9279F458E8336@hhmail02.hh.imgtec.org>
 <20150116143725.GB22296@linux-mips.org>
In-Reply-To: <20150116143725.GB22296@linux-mips.org>
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
X-archive-position: 45244
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
> From: Ralf Baechle [mailto:ralf@linux-mips.org]
> Sent: 16 January 2015 14:37
> To: Daniel Sanders
> Cc: David Daney; Sergei Shtylyov; linux-mips@linux-mips.org; Paul Burton;
> Markos Chandras; James Hogan; Behan Webster
> Subject: Re: [PATCH] MIPS: Changed current_thread_info() to an equivalent
> supported by both clang and GCC
> 
> On Sat, Jan 10, 2015 at 12:53:22PM +0000, Daniel Sanders wrote:
> 
> > The main reason I renamed it is that identifiers starting with '__' are
> reserved. It's pretty unlikely but it's possible that the name will conflict with
> a C implementation in the future.
> 
> The whole kernel is using identifiers starting with a double underscore
> left and right.  The risk should be acceptable though - also because the
> kernel isn't linked against external libraries.

Makes sense, I won't worry too much about then. Thanks for explaining.
 
> The sole reason why _current_thread_info was a local variable is so nobody
> else can use it - the proper interface to use is current_thread_info().
>
> Other than that, both the current and the proposed variant aren't really
> correct for a variable that really is per thread.  So I'm going to just
> queue this for 3.20.
> 
> Thanks!
> 
>   Ralf

Thanks. I'll finish preparing the other clang-related patches for MIPS and will submit them soon.
