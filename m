Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 12:52:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50570 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010694AbaJGKwmfb14E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 12:52:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2865A954A5F16;
        Tue,  7 Oct 2014 11:52:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 7 Oct 2014 11:52:35 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 7 Oct
 2014 11:52:35 +0100
Message-ID: <5433C5F2.2050506@imgtec.com>
Date:   Tue, 7 Oct 2014 11:52:34 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        David Daney <david.s.daney@gmail.com>,
        Rich Felker <dalias@libc.org>,
        David Daney <ddaney@caviumnetworks.com>
CC:     Andy Lutomirski <luto@amacapital.net>,
        David Daney <ddaney.cavm@gmail.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "Leonid Yegoshin" <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com> <20141006205459.GZ23797@brightrain.aerifal.cx> <5433071B.4050606@caviumnetworks.com> <20141006213101.GA23797@brightrain.aerifal.cx> <54330D79.80102@caviumnetworks.com> <20141006215813.GB23797@brightrain.aerifal.cx> <543327E7.4020608@amacapital.net> <54332A64.5020605@caviumnetworks.com> <20141007000514.GD23797@brightrain.aerifal.cx> <543334CE.8060305@caviumnetworks.com> <20141007004915.GF23797@brightrain.aerifal.cx> <54337127.40806@gmail.com> <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org>
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43047
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

On 07/10/14 10:13, Matthew Fortune wrote:
>>>> the out-of-line execution trick, but do it somewhere other than in
>>>> stack memory.
>>> How do you answer Andy Lutomirski's question about what happens when a
>>> signal handler interrupts execution while the program counter is
>>> pointing at this "out-of-line execution" trampoline? This seems like a
>>> show-stopper for using anything other than the stack.
>> It would be nice to support, but not doing so would not be a regression
>> from current behavior.
> 
> It seems appropriate to mention another issue which should be addressed as
> part of the overall FPU emulation work...
> 
> From what I can see the out-of-line execution of delay slot instructions
> will break micromips R3 addiupc, and all MIPS32r6 and MIPS64r6 PC-relative
> instructions (inc load/store) as they will have the wrong base. Is there
> anything in the current set of proposals that can address this (beyond
> adding restrictions to what is ABI allowed in FPU branch delay slots)?
> 
> This is an issue whether the stack is executable or not but does directly
> relate to the topic of FPU emulation.  It sounds like the kernel would not
> be able to emulate a pc-relative load/store even if it was a special case
> as it would not run in the correct MM context? [be gentle, I'm no expert
> in this area].

I think special casing and emulating them in the kernel would work in
these cases, since it'd be a known set of instructions rather than
arbitrary unknown instructions, the kernel needs to read/write safely
into the user address space all the time for system calls.

Cheers
James
