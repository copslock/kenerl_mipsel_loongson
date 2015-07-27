Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 19:46:33 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:48370 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011286AbbG0Rqb0GaNz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 19:46:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Xy5Uy5UsyCe4ELQujC8fqU44O6PZom5fDeuaa7w0r/U=;
        b=xHHMuL+S7QoUQx25981gfFGA1sfVsrJSo11/q0Gt3O3XFJVSKQKS3KrzTH23/V22SwQux6s44wdLTidDXJHVzSVyQ/1dHq28pX6V8a1wIpHvCSK3yIF5r5X6eRf5nB1ER+cx/Z8H8U70V/7ahdRKMfYphKOSpQg85O7ucp8SGtw=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54709 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZJmTo-002QG3-Gt; Mon, 27 Jul 2015 17:46:25 +0000
Date:   Mon, 27 Jul 2015 10:46:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-next@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Crash in -next due to 'MIPS: Move FP usage checks into
 protected_{save, restore}_fp_context'
Message-ID: <20150727174622.GA10708@roeck-us.net>
References: <20150715160918.GA27653@roeck-us.net>
 <20150727150652.GA1756@roeck-us.net>
 <20150727172142.GE7289@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150727172142.GE7289@NP-P-BURTON>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Mon, Jul 27, 2015 at 10:21:42AM -0700, Paul Burton wrote:
> On Mon, Jul 27, 2015 at 08:06:52AM -0700, Guenter Roeck wrote:
> > On Wed, Jul 15, 2015 at 09:09:18AM -0700, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > my qemu test for mipsel crashes with next-20150715 as follows.
> > > 
> > ping ... problem is still seen as of next-20150727.
> 
> Hi Guenter,
> 
> Apologies for the delay. Could you share your affected kernel
> configuration & which userland you're running?
> 
> I've just tested with a malta_defconfig kernel & a buildroot based
> initramfs without problems, and things are also fine on my physical
> MIPSr6 setups. If you have any directions with which I can reproduce
> this problem that would be great.
> 
This is with qemu in little endian mode. Big endian works fine.
The configuration, the script to build and run the kernel, 
and the root file system used are are available at
https://github.com/groeck/linux-build-test, in directory
rootfs/mipsel/. The log for the latest build failure is in
http://server.roeck-us.net:8010/builders/qemu-mipsel-next/builds/194/steps/qemubuildcommand/logs/stdio.

Hope this helps,
Guenter


> Thanks,
>     Paul
> 
> > 
> > > ...
> > > Btrfs loaded
> > > console [netcon0] enabled
> > > netconsole: network logging started
> > > Freeing unused kernel memory: 284K (808f9000 - 80940000)
> > > Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000008
> > > 
> > > Bisect points to commit 'MIPS: Move FP usage checks into protected_{save,
> > > restore}_fp_context'. Bisect log is as follows.
> > > 
> > > The problem is not seen with bit endian qemu test.
> > > 
> > > Please let me know if there is anything I can do to help debugging
> > > this problem.
> > > 
> > > Thanks,
> > > Guenter
> > > ---
> > > 
> > > # bad: [f4d61b2d73c1e4964ad68df238af5005485469af] Add linux-next specific files for 20150715
> > > # good: [bc0195aad0daa2ad5b0d76cce22b167bc3435590] Linux 4.2-rc2
> > > git bisect start 'HEAD' 'v4.2-rc2'
> > > # bad: [897f492ee766d354b949f3838cbfda8978cfd3cd] Merge remote-tracking branch 'crypto/master'
> > > git bisect bad 897f492ee766d354b949f3838cbfda8978cfd3cd
> > > # bad: [687fe9993e4fbe728113086eb9525360465694e6] Merge remote-tracking branch 'mips/mips-for-linux-next'
> > > git bisect bad 687fe9993e4fbe728113086eb9525360465694e6
> > > # good: [a06e5ae4e8d6d5846809e94d0d45afcc5a9eaf35] Merge remote-tracking branch 'omap/for-next'
> > > git bisect good a06e5ae4e8d6d5846809e94d0d45afcc5a9eaf35
> > > # good: [badbfaedef0876d3cffb3264512aaec8cc162c61] Merge remote-tracking branch 'tegra/for-next'
> > > git bisect good badbfaedef0876d3cffb3264512aaec8cc162c61
> > > # bad: [88841d986cebe1207a47cd7422f5069b2616b194] MIPS: Advertise MSA support via HWCAP when present
> > > git bisect bad 88841d986cebe1207a47cd7422f5069b2616b194
> > > # good: [7c1f7b83170bc14a3e461a9b5595fcecf857da70] MIPS: octeon: Replace the homebrewn flow handler
> > > git bisect good 7c1f7b83170bc14a3e461a9b5595fcecf857da70
> > > # good: [186a699fdf6f0866ca980bcf5e79f54922fe52c2] MIPS: Introduce accessors for MSA vector registers
> > > git bisect good 186a699fdf6f0866ca980bcf5e79f54922fe52c2
> > > # bad: [1793cdaa84ed5c4025a36793f350b07b49555b57] MIPS: Skip odd double FP registers when copying FP32 sigcontext
> > > git bisect bad 1793cdaa84ed5c4025a36793f350b07b49555b57
> > > # good: [8a6bb0ab74eaca5f2a4e60f94df2ea5b08cdfd63] MIPS: Simplify EVA FP context handling code
> > > git bisect good 8a6bb0ab74eaca5f2a4e60f94df2ea5b08cdfd63
> > > # good: [6f47ebd751531249fe0e2b4d3afdfcbf9f66dbd8] MIPS: Use struct mips_abi offsets to save FP context
> > > git bisect good 6f47ebd751531249fe0e2b4d3afdfcbf9f66dbd8
> > > # bad: [fa3156ca734cb65f23df0f844433e75ea1da37f3] MIPS: Move FP usage checks into protected_{save, restore}_fp_context
> > > git bisect bad fa3156ca734cb65f23df0f844433e75ea1da37f3
> > > # first bad commit: [fa3156ca734cb65f23df0f844433e75ea1da37f3] MIPS: Move FP usage checks into protected_{save, restore}_fp_context
