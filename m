Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2015 16:52:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47712 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009651AbbAQPwricJvk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jan 2015 16:52:47 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 09A9A51BA8469;
        Sat, 17 Jan 2015 15:52:39 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 17 Jan
 2015 15:52:41 +0000
Received: from hhmail02.hh.imgtec.org ([::1]) by hhmail02.hh.imgtec.org
 ([::1]) with mapi id 14.03.0224.002; Sat, 17 Jan 2015 15:52:40 +0000
From:   Daniel Sanders <Daniel.Sanders@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Behan Webster <behanw@converseincode.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        David Daney <ddaney.cavm@gmail.com>
Subject: RE: [PATCH v2] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
Thread-Topic: [PATCH v2] MIPS: Changed current_thread_info() to an
 equivalent supported by both clang and GCC
Thread-Index: AQHQLNRhR7nYfnwtv0ei8RmQHFnasJzC3O0AgAGkXrA=
Date:   Sat, 17 Jan 2015 15:52:39 +0000
Message-ID: <E484D272A3A61B4880CDF2E712E9279F4590384D@hhmail02.hh.imgtec.org>
References: <1420894360-13479-1-git-send-email-daniel.sanders@imgtec.com>
 <20150116144703.GC22296@linux-mips.org>
In-Reply-To: <20150116144703.GC22296@linux-mips.org>
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
X-archive-position: 45243
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
> Sent: 16 January 2015 14:47
> To: Daniel Sanders
> Cc: linux-mips@linux-mips.org; Paul Burton; Markos Chandras; James
> Hogan; Behan Webster; Sergei Shtylyov; David Daney
> Subject: Re: [PATCH v2] MIPS: Changed current_thread_info() to an
> equivalent supported by both clang and GCC
> 
> On Sat, Jan 10, 2015 at 12:52:40PM +0000, Daniel Sanders wrote:
> 
> > The problem is that clang doesn't honour named registers on local
> variables
> > and silently treats them as normal uninitialized variables. However, it
> > does honour them on global variables.
> 
> Older versions of <asm/unistd.h> which have been copied into some
> userland
> packages are using some local register variables in syscall wrappers.  These
> syscall wrappers have historically been a pain because every once in a
> while they got broken by a new GCC release or other issues.  If you're
> lucky that has been resolved by the maintainers of those external software
> packages - the only way to be certain is the review ...
> 
> At least the kernel does no longer do syscalls.
> 
>   Ralf

Thanks for warning me. I'll have to keep an eye out for that.
