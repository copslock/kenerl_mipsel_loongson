Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2014 11:45:39 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40534 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006959AbaLDKphf1gGe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Dec 2014 11:45:37 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EFD1AB73B427B;
        Thu,  4 Dec 2014 10:45:28 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 4 Dec 2014 10:45:31 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Dec
 2014 10:45:30 +0000
Message-ID: <54803B4A.10201@imgtec.com>
Date:   Thu, 4 Dec 2014 10:45:30 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <peterz@infradead.org>,
        <paul.gortmaker@windriver.com>, <macro@linux-mips.org>,
        <chenhc@lemote.com>, <cl@linux.com>, <mingo@kernel.org>,
        <richard@nod.at>, <zajec5@gmail.com>, <james.hogan@imgtec.com>,
        <keescook@chromium.org>, <tj@kernel.org>, <alex@alex-smith.me.uk>,
        <pbonzini@redhat.com>, <blogic@openwrt.org>,
        <linux-kernel@vger.kernel.org>, <markos.chandras@imgtec.com>,
        <dengcheng.zhu@imgtec.com>, <manuel.lauss@gmail.com>,
        <lars.persson@axis.com>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/3] MIPS: Add full ISA emulator.
References: <1417650258-2811-1-git-send-email-ddaney.cavm@gmail.com> <1417650258-2811-3-git-send-email-ddaney.cavm@gmail.com> <547FA2E5.1040105@imgtec.com> <547FA8D2.2030703@caviumnetworks.com> <547FB032.2000000@imgtec.com> <547FB8FB.7040803@caviumnetworks.com> <547FBF63.70802@imgtec.com> <547FC530.1060109@caviumnetworks.com> <20141204101229.GC5482@NP-P-BURTON>
In-Reply-To: <20141204101229.GC5482@NP-P-BURTON>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

By all means I don't really understand the whole issues surrounding this 
but this approach looks better to me as well. It seems more generic and 
future proof and at least I can understand the patch series.

But did I say I don't understand all of this? Would be nice to hear from 
more people :)

Qais

On 12/04/2014 10:16 AM, Paul Burton wrote:
> Nice work David, I like this approach. It's so much simpler than hacking
> atop the current dsemul code. I also imagine this could be reused for
> emulation of instructions removed in r6, when running pre-r6 userland
> binaries on r6 systems.
>
> On Wed, Dec 03, 2014 at 06:21:36PM -0800, David Daney wrote:
>> On 12/03/2014 05:56 PM, Leonid Yegoshin wrote:
>>> I see only two technical issues here which differs:
>>>
>>> 1.  You believe your GCC experts, I trust HW Architecture manual and
>>> don't trust toolchain people too much ==> we see a different value in
>>> fact that your approach has a subset of emulated ISAs (and it can't, of
>>> course, emulate anything because some custom opcodes are reused).
>> Yes, I agree that the emulation approach cannot handle some of the cases you
>> mention (most would have to be the result of hand coded assembly
>> specifically trying to break it).
> I'm not sure I'd agree even with that - ASEs & vendor-specific
> instructions could easily be added if necessary.
>
> On Thu, Dec 04, 2014 at 05:56:51PM -0800, Leonid Yehoshin wrote:
>>> 2.  My approach is ready to use and is used right now, you still have a
>>> framework which passed an initial boot.
> Subjective.
>
> Thanks,
>      Paul
