Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 02:07:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45162 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011026AbaJJAHUX9kjm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 02:07:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AF595945067A9;
        Fri, 10 Oct 2014 01:07:08 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 10 Oct
 2014 01:07:13 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 10 Oct
 2014 01:07:12 +0100
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 9 Oct 2014
 17:07:11 -0700
Message-ID: <5437232F.60800@imgtec.com>
Date:   Thu, 9 Oct 2014 17:07:11 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <paul.gortmaker@windriver.com>,
        <davidlohr@hp.com>, <macro@linux-mips.org>, <chenhc@lemote.com>,
        <richard@nod.at>, <zajec5@gmail.com>, <keescook@chromium.org>,
        <alex@alex-smith.me.uk>, <tglx@linutronix.de>,
        <blogic@openwrt.org>, <jchandra@broadcom.com>,
        <paul.burton@imgtec.com>, <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <markos.chandras@imgtec.com>, <dengcheng.zhu@imgtec.com>,
        <manuel.lauss@gmail.com>, <akpm@linux-foundation.org>,
        <lars.persson@axis.com>
Subject: Re: [PATCH v2 2/3] MIPS: Setup an instruction emulation in VDSO protected
 page instead of user stack
References: <20141009195030.31230.58695.stgit@linux-yegoshin> <20141009200017.31230.69698.stgit@linux-yegoshin> <20141009224304.GA4818@jhogan-linux.le.imgtec.org> <543715D7.1020505@imgtec.com> <20141009234044.GB4818@jhogan-linux.le.imgtec.org>
In-Reply-To: <20141009234044.GB4818@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 10/09/2014 04:40 PM, James Hogan wrote:
>
>> It may be a case for mix of FPU and MIPS R6 emulations. I just keep both
>> emulators separate as much as possible but I assume that without prove
>> it may be stackable - some rollback is needed to join both and it may
>> (probably) cause a double emulation setup - dsemul may be called twice
>> for the same pair of instructions. I didn't see that yet, honestly and
>> you may be right.
> If the only time they're used is for emulation of a branch delay slot
> instruction which should never be another branch, and signals always
> undo the emuframe before being handled (btw, should the BD bit in cause
> get set if rewinding for signal handlers/gdb?), then it stands to reason
> it should never nest.

I don't want to give a chance. If it is proved excessive, then slashing 
it - 15minutes, it doesn't harm.

OK, I will spend some time to look into that, it have sense to 
reconsider after unwinding signals.

>
> You could then avoid the whole stack and per-thread thing and just have
> a maximum of one emuframe dedicated to each thread or allocated on
> demand, and if there genuinely is a use case for nesting later on, worry
> about it then.

As I understand, you propose to allocate some space in mmap.

This requires a stuff to handle allocation of user space beyond VMAs.
It also may have some pain during thread creation, stopping and 
subsequent cloning because that memory allocator should service that 
events too and it may be not easy if emulation blocks are packed into 
page. If it is not packed then it waste of user space and put additional 
constraint to number of thread on single mmap.

Some cooperation with GLIBC may be needed to prevent re-use of user 
address space, at a moment not sure the extent of it.

I estimated that it can be much more troubling.

>
> So long as the kernel handles a long sequence of sequential emulated
> branches gracefully (not necessarily correctly).
>
I don't understand a question. Each pair/single instruction is emulated 
separately but there is some pipeline of that, even in FPU emulator, it 
is just not this patch issue.
