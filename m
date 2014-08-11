Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2014 13:09:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9192 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842441AbaHKLJpSG8oJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Aug 2014 13:09:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3BA8FE96FFBCE;
        Mon, 11 Aug 2014 12:09:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 11 Aug 2014 12:09:37 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 11 Aug
 2014 12:09:36 +0100
Message-ID: <53E8A470.1050603@imgtec.com>
Date:   Mon, 11 Aug 2014 12:09:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Ralf <ralf@linux-mips.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Markos (GMail)" <markos.chandras@gmail.com>,
        Markos <markos.chandras@imgtec.com>,
        Paul <paul.burton@imgtec.com>,
        Rob Kendrick <rob.kendrick@codethink.co.uk>,
        "Alex Smith" <alex@alex-smith.me.uk>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: Please add my temporary MIPS fixes branch to linux-next
References: <53D9169D.3020705@imgtec.com>
In-Reply-To: <53D9169D.3020705@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41948
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

Hi Ralf,

On 30/07/14 17:00, James Hogan wrote:
> Hi Stephen & MIPS people
> 
> v3.16 is fast approaching and there are quite a few important MIPS
> patches pending. Since Ralf appears to be unavailable at the moment I've
> reviewed and applied some of those patches which are least controversial
> to a fixes branch with the intention of sending a pull request to Ralf &
> Linus so that one of them can hopefully merge it before the release.

I sent you a pull request for these fixes prior to v3.16 but
unfortunately they still missed the release, and only two of the patches
were applied in the main v3.17 MIPS merge.

What are you intentions for the remaining fixes from Markos & Aaro? I'm
happy for my branch to be dropped from linux-next if you want to apply
them yourself, or to drop the two patches you applied so you can merge
it cleanly.

Thanks
James

> 
> Please could the following branch be added to linux-next:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git
> branch: mips-fixes
> 
> Details of fixes below.
> 
> Thanks
> James
> 
> The current shortlog looks like this:
> 
> Aaro Koskinen (1):
>       MIPS: OCTEON: make get_system_type() thread-safe
> 
> Markos Chandras (5):
>       MIPS: syscall: Fix AUDIT value for O32 processes on MIPS64
>       MIPS: scall64-o32: Fix indirect syscall detection
>       MIPS: EVA: Add new EVA header
>       MIPS: Malta: EVA: Rename 'eva_entry' to 'platform_eva_init'
>       MIPS: CPS: Initialize EVA before bringing up VPEs from secondary cores
> 
> Paul Burton (1):
>       MIPS: prevent user from setting FCSR cause bits
> 
> Rob Kendrick (1):
>       MIPS: math-emu: cp1emu: Fix typo when returning to register file
> 
> 
> If I've missed any other critical fixes for v3.16 please let me know.
> 
> 
> 
> I haven't included the patches below, even though they are important, as
> I'm less sure about them. Comments welcome.
> 
> 
> This one fixes mips32 debian boot, but changes the layout of the
> NT_PRSTATUS regset which is accessible through ptrace. I don't believe
> this will break anything, but there are other patches pending in the
> patchset to fix up the regset stuff properly anyway (as it is already
> broken for core dumps) and I don't really want to take the risk without
> Ralf's okay.
> 
> Alex Smith (1):
>       MIPS: O32/32-bit: Fix bug which can cause incorrect system call
> restarts
> 
> 
> This one I'm not confident about, hasn't had any comments on the list,
> and has been broken for quite a while anyway, so I haven't risked it.
> 
> Huacai Chen (1):
>       MIPS: tlbex: fix a missing statement for HUGETLB
> 
> 
