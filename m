Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2015 20:50:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48336 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013422AbbKLTujJSZxC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Nov 2015 20:50:39 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 1CBB5A6DAA401;
        Thu, 12 Nov 2015 19:50:29 +0000 (GMT)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 12 Nov
 2015 19:50:32 +0000
Received: from BADAG03.ba.imgtec.org (10.20.40.115) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 12 Nov
 2015 19:50:32 +0000
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 badag03.ba.imgtec.org ([::1]) with mapi id 14.03.0123.003; Thu, 12 Nov 2015
 11:50:26 -0800
From:   Nikola Veljkovic <Nikola.Veljkovic@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Chris Dearman <Chris.Dearman@imgtec.com>,
        "Raghu Gandham" <Raghu.Gandham@imgtec.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Lazar Trsic <Lazar.Trsic@imgtec.com>
Subject: RE: [PATCH] MIPS: personality syscall discrepancy on mips64-o32/n32
Thread-Topic: [PATCH] MIPS: personality syscall discrepancy on mips64-o32/n32
Thread-Index: AdDZoDWdYYUUjfUKSkyGO9XRIv7l2QAT7T6AAFm3ySoQlMDfAP//rwUs
Date:   Thu, 12 Nov 2015 19:50:26 +0000
Message-ID: <19CDB9880DBFC241860D925D8FAA94A024A0AFBA@BADAG02.ba.imgtec.org>
References: <19CDB9880DBFC241860D925D8FAA94A00342EAB8@BADAG02.ba.imgtec.org>
 <20150818125605.GA25978@mchandras-linux.le.imgtec.org>
 <19CDB9880DBFC241860D925D8FAA94A00342F48A@BADAG02.ba.imgtec.org>,<20151112162529.GF29184@linux-mips.org>
In-Reply-To: <20151112162529.GF29184@linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.40.117]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Nikola.Veljkovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Nikola.Veljkovic@imgtec.com
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

>For anything that changes an established ABI - in this case for about 15 or
>16 years I'm going to be conservative at changing such an ABI.  Also Sparc64
>and PowerPC are using the exactly same wrapper.

>Anyway, can you tell me more about the Android issue?

I started the discussion after Google updated personality test in bionic [1].
Test expects the PER_LINUX32 to be returned for a 32-bit binary, so it fails
on mips64 for 32bit binaries.
https://android-review.googlesource.com/#/c/157455/1/tests/sys_personality_test.cpp

My guess was that the changes in test were going to be followed with the code
dependent on the personality syscall elsewhere, but so far that did not happen.
Only user of the personality syscall in Android is strace, and there are no 
issues with it as far as I know.

Also, my understanding of the risks the change in kernel would create was wrong.
From this perspective I believe your arguments against the kernel change to be
sufficient for me to propose to Google a change in the personality test.

Thank you for the additional info,
Nikola
________________________________________
From: Ralf Baechle [ralf@linux-mips.org]
Sent: Thursday, November 12, 2015 5:25 PM
To: Nikola Veljkovic
Cc: Markos Chandras; linux-mips@linux-mips.org; Chris Dearman; Raghu Gandham; Miodrag Dinic; Petar Jovanovic; Lazar Trsic
Subject: Re: [PATCH] MIPS: personality syscall discrepancy on mips64-o32/n32

On Thu, Aug 20, 2015 at 02:46:26PM +0000, Nikola Veljkovic wrote:

>  > I am not sure what the implication will be to userland with that change...
> I could not find any code that explicitly checks for PER_LINUX[32]. Of course,
> I might be missing something. Any suspects?

The one thing where it really matters is the architecture return value
for uname, try "uname -m".  On a 32 bit kernel this will return "mips",
on a 64 bit kernel "mips64".  This will break some software that expects
to identify MIPS by "mips".  There's a small tool to set this personality
flag, see ftp://ftp.linux-mips.org/pub/linux/mips/mips32/ for a year 2000
vintage source and binary rpm.  Or also the more modern setarch(1) utility.

>  > I presume you also need to fix the n32 case and then completely remove the
>  > sys_32_personality syscall from linux32.c.
> New patch below removes the syscall.
>
>  > Moreover, I think you also need to fix the arch/mips/include/asm/elf.h
>  > code to set LINUX32 for O32 and n32 (for both 32b and 64b kernels.)
> Other archs (arm, intel) do not do that, so I think we should follow, and set
> PER_LINUX, but let userspace change this if it wants to. On the kernel side this
> only affects uname. From the discussion [1] it seems like the right way to go.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/114506.html

x86 and ARM maybe but not SPARC64 which uses the exactly same code,
see arch/sparc/kernel/sys_sparc_64.c function sparc64_personality() and
from which this function and the mips32 utility which was named sparc32
in a former live, were taken.

The PER_LINUX32 -> PER_LINUX translation of the return value is for antique
programs that expect to see PER_LINUX as the return value.

> Tested changing only o32 on Android, there were no regressions:

For anything that changes an established ABI - in this case for about 15 or
16 years I'm going to be conservative at changing such an ABI.  Also Sparc64
and PowerPC are using the exactly same wrapper.

Anyway, can you tell me more about the Android issue?

  Ralf
