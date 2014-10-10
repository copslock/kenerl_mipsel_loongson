Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 01:40:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59888 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011125AbaJJXkfc24O8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 01:40:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2154C324B56A2;
        Sat, 11 Oct 2014 00:40:24 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 11 Oct
 2014 00:40:28 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 11 Oct
 2014 00:40:28 +0100
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 10 Oct
 2014 16:40:26 -0700
Message-ID: <54386E6A.8060108@imgtec.com>
Date:   Fri, 10 Oct 2014 16:40:26 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <Zubair.Kakakhel@imgtec.com>, <geert+renesas@glider.be>,
        <david.daney@cavium.com>, <peterz@infradead.org>,
        <paul.gortmaker@windriver.com>, <davidlohr@hp.com>,
        <macro@linux-mips.org>, <chenhc@lemote.com>, <richard@nod.at>,
        <zajec5@gmail.com>, <keescook@chromium.org>,
        <alex@alex-smith.me.uk>, <tglx@linutronix.de>,
        <blogic@openwrt.org>, <jchandra@broadcom.com>,
        <paul.burton@imgtec.com>, <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <markos.chandras@imgtec.com>, <dengcheng.zhu@imgtec.com>,
        <manuel.lauss@gmail.com>, <akpm@linux-foundation.org>,
        <lars.persson@axis.com>
Subject: Re: [PATCH v2 2/3] MIPS: Setup an instruction emulation in VDSO protected
 page instead of user stack
References: <20141009195030.31230.58695.stgit@linux-yegoshin> <20141009200017.31230.69698.stgit@linux-yegoshin> <20141009224304.GA4818@jhogan-linux.le.imgtec.org> <543715D7.1020505@imgtec.com> <20141009234044.GB4818@jhogan-linux.le.imgtec.org> <5437232F.60800@imgtec.com> <20141010100334.GD4818@jhogan-linux.le.imgtec.org> <5438621C.8020708@imgtec.com> <54386438.9090606@gmail.com>
In-Reply-To: <54386438.9090606@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43238
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

On 10/10/2014 03:56 PM, David Daney wrote:
>
>>  > Right, look at uprobes, it does exactly all this with a single page.
>>  > Slot allocation will block waiting for a free slot when all are in 
>> use.
>>
>> I don't see a reason to change my 300 lines design into much more
>> lengthy code. That code has more links to the rest of kernel and high
>> possibility to execute atomic operation/locks/mutex/etc - I can't do it
>> for emulation of MIPS locking instructions.
>>
>
> It isn't just the number of lines of code that is important.
>
> Doesn't your solution consume an extra page for each thread requiring 
> emulation?  That could be a significant amount of memory in a system 
> with many threads.

Yes, you right. However, per-thread memory is useful for many goals.

>
> Are you are using this to emulate atomic operations in addition to FPU 
> branch delay slot instructions?  Where is the code that does that?

Yes, in MIPS R2 emulator - MIPS R6 changed LL/LLD/SC/SCD opcodes and 
offset size.
The code-in-developement is in 
ssh://git.linux-mips.org/pub/scm/yegoshin/mips.git, branch 
android-linux-mti-3.10.14

- Leonid.
