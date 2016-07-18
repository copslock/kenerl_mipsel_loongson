Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2016 13:55:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58190 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992663AbcGRLzeWgp4D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jul 2016 13:55:34 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A0D49A344F467;
        Mon, 18 Jul 2016 12:55:14 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775%25]) with mapi id
 14.03.0294.000; Mon, 18 Jul 2016 12:55:17 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Faraz Shahbazker <Faraz.Shahbazker@imgtec.com>
CC:     Paul Burton <Paul.Burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Leonid Yegoshin" <Leonid.Yegoshin@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>
Subject: RE: [PATCH v5 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
Thread-Topic: [PATCH v5 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
Thread-Index: AQHR2QB+CywUwQZeWUO+QkPS4ltKPqAOqvkAgAAj3oCAABMwgIAPPryA
Date:   Mon, 18 Jul 2016 11:55:16 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B023537E47FB7A@HHMAIL01.hh.imgtec.org>
References: <20160708100620.4754-1-paul.burton@imgtec.com>
 <20160708100620.4754-3-paul.burton@imgtec.com>
 <alpine.DEB.2.00.1607081655580.4076@tp.orcam.me.uk>
 <577FF4A1.5000200@imgtec.com>
 <alpine.DEB.2.00.1607082025140.4076@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1607082025140.4076@tp.orcam.me.uk>
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
X-archive-position: 54346
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

Maciej Rozycki <Maciej.Rozycki@imgtec.com> writes:
> On Fri, 8 Jul 2016, Faraz Shahbazker wrote:
> 
> > On 07/08/2016 09:36 AM, Maciej W. Rozycki wrote:
> > > implementation previously present, and the MIPS port specifically
> > > has been updated to actually report this at the EI_ABIVERSION offset
> > > of the `e_ident' array of the ELF header with commit 17733f5be961
> > > ("Increment the ABIVERSION to 5 for MIPS objects with non-executable
> > > stacks."), earlier this year (it's not clear to me offhand why we
> > > need to do this rather than relying on the lone presence of
> > > PT_GNU_STACK, but I'm sure someone will enlighten me).
> >
> > This was simply to be able to check whether the tools support a safe
> > non-exec stack scheme, before enabling it as a default in the
> > compiler. Refer to the attached e-mail from Matthew. Neither linker
> nor compiler patch is upstream.
> 
>  Hmm, now I am really confused: what problem are we trying to solve on
> the toolchain side?

The problem was that if we just turn on no-exec-stack support in GCC then
when someone combines that with an older binutils and/or build glibc
from source (using those tools) then they would get an executable that
asked for a non-executable stack and the kernel would willingly do so.

However, this would then crash. So we need a way to prevent the generic
logic in glibc's build system from creating a no-exec-stack library until
we have the kernel checks in place in glibc to undo no-exec-stack. This
then leads to the convoluted system of increased EI_ABIVERSION (or some
other equally complex plan) to ensure mix-and-match of new and old tools
glibc and kernel all behave nicely.

>  As I understand the current state of affairs, we have now have a
> situation where the toolchain may be asked (although it is not on by
> default) to produce a MIPS PT_GNU_STACK binary, which will be happily
> executed by the kernel with the execution permission disabled for the
> stack memory (where supported by hardware, i.e. RIXI), however then it
> will itself happily try to execute from that stack memory in the FPU
> emulator.
> 
>  So first of all we need to address the problem in the kernel by making
> the FPU emulator avoid stack execution.  That will fix PT_GNU_STACK
> support on our target.

Yes.

>  Second we want to enforce the non-executable-stack policy in the
> userland by adding a check early on in glibc startup for a flag, such as
> in the FLAGS entry of the auxiliary vector, set by a fixed kernel only,
> telling glibc that the presence of PT_GNU_STACK has been respected by
> the kernel, and make the startup bail out right away if the flag is not
> there.

Yes.

>  So where does the static linker EI_ABIVERSION update fit here?  What is
> it needed for?  What have I missed?

Making sure new GCC + new binutils + old glibc (from source) does not create
executables that crash. My proposal was to also make sure that a MIPS GCC
with no-exec-stack support would fail the generic glibc build system test
for no-exec-stack and instead need a new MIPS specific test so that old
glibc built from source never ended up with no-exec-stack support for MIPS.

I'd love to simplify all this if for some reason this isn't actually a
problem. I was trying to stick to the principle of all combinations of old
and new tools/libraries should just work.

Matthew
