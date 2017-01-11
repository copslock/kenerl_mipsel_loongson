Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 18:40:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6775 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993896AbdAKRkdq3Jsi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2017 18:40:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 42DD2BFE72080;
        Wed, 11 Jan 2017 17:40:24 +0000 (GMT)
Received: from [10.20.78.149] (10.20.78.149) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 11 Jan 2017
 17:40:26 +0000
Date:   Wed, 11 Jan 2017 17:40:16 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Yunqiang Su <Yunqiang.Su@imgtec.com>
CC:     Paul Hua <paul.hua.gm@gmail.com>,
        Richard Sandiford <rdsandiford@googlemail.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Sandra Loosemore <sandra@codesourcery.com>,
        gcc-patches <gcc-patches@gcc.gnu.org>,
        "Moore, Catherine (Catherine_Moore@mentor.com)" 
        <Catherine_Moore@mentor.com>,
        "huangpei@loongson.cn" <huangpei@loongson.cn>,
        <linux-mips@linux-mips.org>
Subject: Re: [Patch ,gcc/MIPS] add an build-time/runtime option to disable
 madd.fmt
In-Reply-To: <6BFA91F2-1B3B-422C-AD1C-D6F4A00D625A@imgtec.com>
Message-ID: <alpine.DEB.2.00.1701111725080.6936@tp.orcam.me.uk>
References: <7FDC38C0-90D4-4A32-8FD5-ED65DC469055@imgtec.com> <585AF58B.5030601@codesourcery.com> <6D39441BF12EF246A7ABCE6654B0235380B0684E@HHMAIL01.hh.imgtec.org> <878tr8geud.fsf@googlemail.com> <9CE78A41-A06C-49E3-A198-1389418ED8EC@imgtec.com>
 <1F820539-D3AD-4FF4-A710-D9F1C76C6219@imgtec.com> <87vaucey35.fsf@googlemail.com> <12EFBD0A-5AC7-409A-B08C-86A5032801E5@imgtec.com> <CAKjxQH=aePXvOeP807MCKxDpG5RDAaNgB6LjH=cNi=XysrFW2A@mail.gmail.com> <6BFA91F2-1B3B-422C-AD1C-D6F4A00D625A@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Fri, 23 Dec 2016, Yunqiang Su wrote:

> > 3, kernel: the emulation  when a float exception taken.
> 
> The big problem is that Loongson use the same encode for (unfused) 
> madd.fmt to (fused) madd.fmt. We cannot trap this in kernel.

 Why is that a problem?  Just add a setting like `cpu_has_fused_madd' to 
<asm/cpu-features.h>, switch processing in the emulator accordingly and 
initialise the setting early on in bootstrap as processor features are 
determined.  We'd have to do it likewise for the R8000 MIPS IV CPU Richard 
referred to previously if we had full support for this processor (unlikely 
to happen).

 Cc-ing <linux-mips@linux-mips.org> in case you want to discuss it further 
with the kernel developers; arguably it's a kernel bug already that the 
FPU as perceived by user software has different semantics on FPU Loongson 
hardware depending on whether or not the `nofpu' kernel parameter has been 
set (I don't know if denormals are handled by Loongson FPU hardware or 
trap with an Unimplemented Operation exception, but if the former, then 
this inconsistency applies for such data in the regular FPU mode as well).

 HTH,

  Maciej
