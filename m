Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 12:53:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45454 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992696AbcGEKxqGDy2m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jul 2016 12:53:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A189927751A80;
        Tue,  5 Jul 2016 11:53:37 +0100 (IST)
Received: from [10.20.78.24] (10.20.78.24) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 5 Jul 2016
 11:53:38 +0100
Date:   Tue, 5 Jul 2016 11:53:17 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        John Stultz <john.stultz@linaro.org>, <mguzik@redhat.com>,
        <athorlton@sgi.com>, <mhocko@suse.com>, <ebiederm@xmission.com>,
        <gorcunov@openvz.org>, <luto@kernel.org>, <cl@linux.com>,
        <serge.hallyn@ubuntu.com>, Kees Cook <keescook@chromium.org>,
        <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>, <mingo@kernel.org>,
        <alex.smith@imgtec.com>, <markos.chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <david.daney@cavium.com>, <zhaoxiu.zeng@gmail.com>,
        <chenhc@lemote.com>, <Zubair.Kakakhel@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] mips: Add MXU context switching support
In-Reply-To: <CANc+2y7meDYJyrHbbKWGsTNwangKCLB+kWLC6bys89PSXj-TdQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1607051144190.4076@tp.orcam.me.uk>
References: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com> <alpine.DEB.2.00.1607042317480.4076@tp.orcam.me.uk> <CANc+2y7meDYJyrHbbKWGsTNwangKCLB+kWLC6bys89PSXj-TdQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.24]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54215
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

On Tue, 5 Jul 2016, PrasannaKumar Muralidharan wrote:

> >> +     asm volatile(".word     0x700803ee\n\t");
> >> +     tsk->thread.mxu.xr[15] = reg_val;
> >> +}
> >
> >  Not using an output operand with asms here?
> 
> I think the instruction saves the xr* register value to reg_val
> without need for output operand.

 It does, a classic `asm' is supposed to act as an optimisation barrier.  

 However since you've used an operand `asm' in `__restore_mxu' I think 
it would be good for consistency to use one here as well; it would make 
this piece of code a little bit more readable too, as you wouldn't have 
to guess that the `asm' writes to `reg_val' then.

 So I suggest that you convert `__save_mxu' to use an operand `asm' as 
well.

  Maciej
