Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 19:21:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19620 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010780AbbG0RVxkqfZp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 19:21:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ED60DAC53648B;
        Mon, 27 Jul 2015 18:21:43 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Jul 2015 18:21:47 +0100
Received: from localhost (10.100.200.213) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 27 Jul
 2015 18:21:44 +0100
Date:   Mon, 27 Jul 2015 10:21:42 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-next@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: Crash in -next due to 'MIPS: Move FP usage checks into
 protected_{save, restore}_fp_context'
Message-ID: <20150727172142.GE7289@NP-P-BURTON>
References: <20150715160918.GA27653@roeck-us.net>
 <20150727150652.GA1756@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150727150652.GA1756@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.213]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Mon, Jul 27, 2015 at 08:06:52AM -0700, Guenter Roeck wrote:
> On Wed, Jul 15, 2015 at 09:09:18AM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > my qemu test for mipsel crashes with next-20150715 as follows.
> > 
> ping ... problem is still seen as of next-20150727.

Hi Guenter,

Apologies for the delay. Could you share your affected kernel
configuration & which userland you're running?

I've just tested with a malta_defconfig kernel & a buildroot based
initramfs without problems, and things are also fine on my physical
MIPSr6 setups. If you have any directions with which I can reproduce
this problem that would be great.

Thanks,
    Paul

> 
> > ...
> > Btrfs loaded
> > console [netcon0] enabled
> > netconsole: network logging started
> > Freeing unused kernel memory: 284K (808f9000 - 80940000)
> > Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000008
> > 
> > Bisect points to commit 'MIPS: Move FP usage checks into protected_{save,
> > restore}_fp_context'. Bisect log is as follows.
> > 
> > The problem is not seen with bit endian qemu test.
> > 
> > Please let me know if there is anything I can do to help debugging
> > this problem.
> > 
> > Thanks,
> > Guenter
> > ---
> > 
> > # bad: [f4d61b2d73c1e4964ad68df238af5005485469af] Add linux-next specific files for 20150715
> > # good: [bc0195aad0daa2ad5b0d76cce22b167bc3435590] Linux 4.2-rc2
> > git bisect start 'HEAD' 'v4.2-rc2'
> > # bad: [897f492ee766d354b949f3838cbfda8978cfd3cd] Merge remote-tracking branch 'crypto/master'
> > git bisect bad 897f492ee766d354b949f3838cbfda8978cfd3cd
> > # bad: [687fe9993e4fbe728113086eb9525360465694e6] Merge remote-tracking branch 'mips/mips-for-linux-next'
> > git bisect bad 687fe9993e4fbe728113086eb9525360465694e6
> > # good: [a06e5ae4e8d6d5846809e94d0d45afcc5a9eaf35] Merge remote-tracking branch 'omap/for-next'
> > git bisect good a06e5ae4e8d6d5846809e94d0d45afcc5a9eaf35
> > # good: [badbfaedef0876d3cffb3264512aaec8cc162c61] Merge remote-tracking branch 'tegra/for-next'
> > git bisect good badbfaedef0876d3cffb3264512aaec8cc162c61
> > # bad: [88841d986cebe1207a47cd7422f5069b2616b194] MIPS: Advertise MSA support via HWCAP when present
> > git bisect bad 88841d986cebe1207a47cd7422f5069b2616b194
> > # good: [7c1f7b83170bc14a3e461a9b5595fcecf857da70] MIPS: octeon: Replace the homebrewn flow handler
> > git bisect good 7c1f7b83170bc14a3e461a9b5595fcecf857da70
> > # good: [186a699fdf6f0866ca980bcf5e79f54922fe52c2] MIPS: Introduce accessors for MSA vector registers
> > git bisect good 186a699fdf6f0866ca980bcf5e79f54922fe52c2
> > # bad: [1793cdaa84ed5c4025a36793f350b07b49555b57] MIPS: Skip odd double FP registers when copying FP32 sigcontext
> > git bisect bad 1793cdaa84ed5c4025a36793f350b07b49555b57
> > # good: [8a6bb0ab74eaca5f2a4e60f94df2ea5b08cdfd63] MIPS: Simplify EVA FP context handling code
> > git bisect good 8a6bb0ab74eaca5f2a4e60f94df2ea5b08cdfd63
> > # good: [6f47ebd751531249fe0e2b4d3afdfcbf9f66dbd8] MIPS: Use struct mips_abi offsets to save FP context
> > git bisect good 6f47ebd751531249fe0e2b4d3afdfcbf9f66dbd8
> > # bad: [fa3156ca734cb65f23df0f844433e75ea1da37f3] MIPS: Move FP usage checks into protected_{save, restore}_fp_context
> > git bisect bad fa3156ca734cb65f23df0f844433e75ea1da37f3
> > # first bad commit: [fa3156ca734cb65f23df0f844433e75ea1da37f3] MIPS: Move FP usage checks into protected_{save, restore}_fp_context
