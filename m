Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 14:04:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28788 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992895AbcF3MEqwtVZr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2016 14:04:46 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 918E53E93657E;
        Thu, 30 Jun 2016 13:04:37 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775%25]) with mapi id
 14.03.0294.000; Thu, 30 Jun 2016 13:04:40 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Paul Burton <Paul.Burton@imgtec.com>,
        Faraz Shahbazker <Faraz.Shahbazker@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Raghu Gandham" <Raghu.Gandham@imgtec.com>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>
Subject: RE: [RFC PATCH v3 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
Thread-Topic: [RFC PATCH v3 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
Thread-Index: AQHR0hQTTmJmtt1Vk0q5X1N8w1HBqqABvOywgAAEFYCAAB13YA==
Date:   Thu, 30 Jun 2016 12:04:39 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B023537E465F8E@HHMAIL01.hh.imgtec.org>
References: <20160629143830.526-1-paul.burton@imgtec.com>
 <20160629143830.526-3-paul.burton@imgtec.com>
 <6D39441BF12EF246A7ABCE6654B023537E465A74@HHMAIL01.hh.imgtec.org>
 <fb77e2f2-801d-8dd5-6121-73909ebbd227@imgtec.com>
In-Reply-To: <fb77e2f2-801d-8dd5-6121-73909ebbd227@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.105]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Paul Burton <Paul.Burton@imgtec.com> writes:
> On 30/06/16 10:25, Matthew Fortune wrote:
> > Paul Burton <Paul.Burton@imgtec.com> writes:
> >> The stack and heap have both been executable by default on MIPS until
> >> now. This patch changes the default to be non-executable, but only
> >> for ELF binaries with a non-executable PT_GNU_STACK header present.
> >> This does apply to both the heap & the stack, despite the name
> >> PT_GNU_STACK, and this matches the behaviour of other architectures
> like ARM & x86.
> >>
> >> Current MIPS toolchains do not produce the PT_GNU_STACK header, which
> >> means that we can rely upon this patch not changing the behaviour of
> >> existing binaries. The new default will only take effect for newly
> >> compiled binaries once toolchains are updated to support
> >> PT_GNU_STACK, and since those binaries are newly compiled they can be
> >> compiled expecting the change in default behaviour. Again this
> >> matches the way in which the ARM & x86 architectures handled their
> >> implementations of non-executable memory.
> >
> > There will be some extra work on top of this to inform user-mode that
> > no-exec-stack support is actually safe. I'm a bit fuzzy on the exact
> > details though as I have not been directly involved for a while.
> >
> > https://www.sourceware.org/ml/libc-alpha/2016-01/msg00719.html
> >
> > Adding Faraz who worked on the user-mode side and Maciej who has been
> > reviewing.
> 
> Hi Matthew,
> 
> Interesting. That glibc patch seems to imply that the kernel already
> supports this, which isn't true. It makes use of a
> "AV_FLAGS_MIPS_GNU_STACK" constant & says that's taken from Linux, but
> it doesn't exist. Are you using an experimental patch for the kernel
> side (perhaps Leonid's?). I'm not sure why you'd use AT_FLAGS for this,
> which Linux currently unconditionally sets to 0 for all architectures.
> Would a HWCAP bit for RIXI perhaps be more suitable?

We are/were under the assumption that a pre-existing kernel will honor
the PT_GNU_STACK marker overriding the arch specific read-implies-exec
logic:

http://lxr.free-electrons.com/source/fs/binfmt_elf.c?v=3.2#L689
http://lxr.free-electrons.com/source/fs/exec.c?v=3.2#L703

This means that if we produce tools which have PT_GNU_STACK with executable
stack disabled then older kernels will crash as they will obey it and
the FPU emulator will break.

Is this incorrect? I.e. does today's MIPS kernel do absolutely nothing
when PT_GNU_STACK is seen?

The "AV_FLAGS_MIPS_GNU_STACK" is a proposal of how to handle the
transition from a kernel that does as I describe above to one that safely
supports no-exec-stack. I don't know if this has to be an AT_FLAGS or
whether a HWCAP would do. I think we perhaps latched on to the idea of
AT_FLAGS as we have used that as part of the nan2008 work but we can
work through that detail later. The user-mode work is still very much in
review. There is no kernel with this feature yet.

Faraz: Did I explain that correctly?

Matthew
