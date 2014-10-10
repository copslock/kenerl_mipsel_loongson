Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 12:03:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10217 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011062AbaJJKDmTnFKv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 12:03:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CAC8B30334382;
        Fri, 10 Oct 2014 11:03:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Oct 2014 11:03:35 +0100
Received: from localhost (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 10 Oct
 2014 11:03:33 +0100
Date:   Fri, 10 Oct 2014 11:03:34 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
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
Subject: Re: [PATCH v2 2/3] MIPS: Setup an instruction emulation in VDSO
 protected page instead of user stack
Message-ID: <20141010100334.GD4818@jhogan-linux.le.imgtec.org>
References: <20141009195030.31230.58695.stgit@linux-yegoshin>
 <20141009200017.31230.69698.stgit@linux-yegoshin>
 <20141009224304.GA4818@jhogan-linux.le.imgtec.org>
 <543715D7.1020505@imgtec.com>
 <20141009234044.GB4818@jhogan-linux.le.imgtec.org>
 <5437232F.60800@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <5437232F.60800@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Leonid,

On Thu, Oct 09, 2014 at 05:07:11PM -0700, Leonid Yegoshin wrote:
> On 10/09/2014 04:40 PM, James Hogan wrote:
> > You could then avoid the whole stack and per-thread thing and just have
> > a maximum of one emuframe dedicated to each thread or allocated on
> > demand, and if there genuinely is a use case for nesting later on, worry
> > about it then.
> 
> As I understand, you propose to allocate some space in mmap.

No, sorry if I wasn't very clear. I just mean that you can get away with
a single kernel managed page per mm, with an emuframe allocated
per-thread which that thread always uses, since they never nest, which I
think simplifies the whole thing significantly.

The allocation could be smarter than that of course in case you have
thousands of threads and only a subset doing lots of FP branches, but a
single thread should never need more than one at a time since the new
signal behaviour effectively makes the delay slot emulation sort of
atomic from the point of view of usermode, and the kernel knows for sure
whether BD emulation is in progress from the PC.

(If there is some other way than signals that I haven't taken into
account that the emulation could be pre-empted then please let me know!)

> > So long as the kernel handles a long sequence of sequential emulated
> > branches gracefully (not necessarily correctly).
> >
> I don't understand a question. Each pair/single instruction is emulated 
> separately but there is some pipeline of that, even in FPU emulator, it 
> is just not this patch issue.

I just mean an (illegal/undefined) sequence of FPU branch instructions
in one anothers delay slots shouldn't be able to crash the kernel.

Actually 2 of them would be enough to verify the kernel didn't get too
confused. Maybe the second will be detected & ignored, or maybe it
doesn't matter if the first emuframe gets overwritten by the second one
from the kernels point of view.

Cheers
James
