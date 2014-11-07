Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 12:32:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52134 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012736AbaKGLcMtnXnN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 12:32:12 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2CF671586C7F2;
        Fri,  7 Nov 2014 11:32:04 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 7 Nov
 2014 11:32:06 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 7 Nov 2014 11:32:06 +0000
Received: from [192.168.154.149] (192.168.154.149) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 7 Nov
 2014 11:32:05 +0000
Message-ID: <545CADB5.3050703@imgtec.com>
Date:   Fri, 7 Nov 2014 11:32:05 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
References: <1414771394-24314-1-git-send-email-manuel.lauss@gmail.com> <20141107020204.GA24423@linux-mips.org> <6D39441BF12EF246A7ABCE6654B0235320F6C533@LEMAIL01.le.imgtec.org>
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320F6C533@LEMAIL01.le.imgtec.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 11/07/2014 11:05 AM, Matthew Fortune wrote:
>> +(mips1) `cfc1 $2,$31'
>> make[1]: *** [arch/mips/math-emu/cp1emu.o] Error 1
>> make: *** [arch/mips/math-emu] Error 2
>> make: *** Waiting for unfinished jobs....
> 
> This is the offending code in cp1emu.c:
> 
>                         if (is_fpu_owner())
>                                 asm volatile(
>                                         ".set push\n"
>                                         "\t.set mips1\n"
>                                         "\tcfc1\t%0,$31\n"
>                                         "\t.set pop" : "=r" (fcr31));
>                         else
>                                 fcr31 = current->thread.fpu.fcr31;
>                         preempt_enable();
> 
> I'm not sure how this can have built with binutils 2.23 (as indicated by
> Manuel and not built with 2.24). The reason this works with the latest
> version of binutils 2.24.x is that cfc1 has been reclassified as not an
> FPU instruction.
> 
> This just needs the hardfloat annotation adding via the macro as in the
> other cases.
> 
> Thanks,
> Matthew
> 
I am confused about this comment. The problem is reproducible with the
latest Mentor toolchain which uses the following gas
GNU assembler version 2.24.51 (mips-linux-gnu) using BFD version
(Sourcery CodeBench Lite 2014.05-27) 2.24.51.20140217.

I am not sure how Manuel's patch triggered this problem on Mentor to be
honest.

-- 
markos
