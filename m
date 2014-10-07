Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 14:22:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18211 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010694AbaJGMW0gAnC3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 14:22:26 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 18CFA4F9846C3;
        Tue,  7 Oct 2014 13:22:17 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 7 Oct
 2014 13:22:19 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 7 Oct 2014 13:22:19 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 7 Oct
 2014 13:22:18 +0100
Message-ID: <5433DAFA.4010008@imgtec.com>
Date:   Tue, 7 Oct 2014 13:22:18 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     David Daney <david.s.daney@gmail.com>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        David Daney <ddaney.cavm@gmail.com>,
        <libc-alpha@sourceware.org>, Leonid <Leonid.Yegoshin@imgtec.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com> <54333B9C.2040302@paralogos.com> <54336CED.3040106@gmail.com> <5433D429.3020804@imgtec.com>
In-Reply-To: <5433D429.3020804@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43054
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

On 07/10/14 12:53, James Hogan wrote:
> On 07/10/14 05:32, David Daney wrote:
>> If the kernel automatically allocated the emulation locations, what
>> would happen if there were a signal that interrupted the emulation, and
>> the signal handler did a longjump to somewhere else?  How would we clean
>> up the now unused emulation memory allocations?
> 
> AFAICT, Leonid's implementation also has this problem, and that has a
> separate stack of emuframes per thread managed completely by the kernel.
> 
> Essentially the kernel doesn't manage the stack, userland does, and
> userland can choose to skip over sigframes and emuframes with siglongjmp
> without telling the kernel.
> 
> Userland can even switch between contexts (which includes stack) with
> setcontext (coroutines etc) which breaks the assumption in Leonid's
> patches that emuframes will be completed in reverse order to them being
> started, again demonstrating that it is essentially userland that
> manages the stack.
> 
> I think any attempt by the kernel to keep track of user stacks (e.g. by
> storing a stack pointer along with the emuframe so that unused emuframes
> can be discarded later when stack pointer goes high again) will be
> foiled by setcontext.
> 
> Hmm, I can't see a way forward that doesn't involve invasive userland
> handling & ABI changes other than giving up with non-executable stacks
> or limiting permitted instructions in delay slots to those Linux knows
> how to emulate directly.

Would it work for a signal encountered during branch delay slot
emulation (maybe where the PC is pointing at that magic location the
kernel uses for emulation) to be treated as a return from emulation, but
leaving the user PC pointing to the original branch (with Cause.BD=1 I
suppose) prior to handling the signal, so that no more than one emuframe
is needed by each thread at a time?

Cheers
James
