Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 10:44:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7924 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007349AbbBZJowLouoa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 10:44:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9F66A527A69F9;
        Thu, 26 Feb 2015 09:44:44 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 26 Feb 2015 09:44:46 +0000
Received: from localhost (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 26 Feb
 2015 09:44:45 +0000
Date:   Thu, 26 Feb 2015 09:44:45 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
CC:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>
Subject: Re: [PATCH v3] MIPS: kernel: elf: Improve the overall ABI and FPU
 mode checks
Message-ID: <20150226094445.GA18496@mchandras-linux.le.imgtec.org>
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
 <1422893593-1291-1-git-send-email-markos.chandras@imgtec.com>
 <yw1xwq3778k2.fsf@unicorn.mansr.com>
 <20150224135225.GA23928@mchandras-linux.le.imgtec.org>
 <yw1xsidv76b6.fsf@unicorn.mansr.com>
 <6D39441BF12EF246A7ABCE6654B0235320FDEE92@LEMAIL01.le.imgtec.org>
 <20150226085943.GA26793@mchandras-linux.le.imgtec.org>
 <yw1x8ufl6nlq.fsf@unicorn.mansr.com>
 <20150226092406.GA27701@mchandras-linux.le.imgtec.org>
 <6D39441BF12EF246A7ABCE6654B0235320FE182B@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320FE182B@LEMAIL01.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

On Thu, Feb 26, 2015 at 09:31:36AM +0000, Matthew Fortune wrote:
> Markos Chandras <Markos.Chandras@imgtec.com>  writes:
> > On Thu, Feb 26, 2015 at 09:14:41AM +0000, Måns Rullgård wrote:
> > > Markos Chandras <markos.chandras@imgtec.com> writes:
> > >
> > > > On Tue, Feb 24, 2015 at 02:26:04PM +0000, Matthew Fortune wrote:
> > > >> Måns Rullgård <mans@mansr.com> writes:
> > > >> > Markos Chandras <markos.chandras@imgtec.com> writes:
> > > >> >
> > > >> > > Hi,
> > > >> > >
> > > >> > > On Tue, Feb 24, 2015 at 01:17:33PM +0000, Måns Rullgård wrote:
> > > >> > >> This patch (well, the variant that made it into 4.0-rc1)
> > > >> > >> breaks MIPS_ABI_FP_DOUBLE (the gcc default) apps on MIPS32.
> > > >> > >>
> > > >> > >
> > > >> > > Thanks for the report.
> > > >> > >
> > > >> > >> > +void mips_set_personality_fp(struct arch_elf_state *state)
> > {
> > > >> > >> > +	/*
> > > >> > >> > +	 * This function is only ever called for O32 ELFs so we
> > should
> > > >> > >> > +	 * not be worried about N32/N64 binaries.
> > > >> > >> > +	 */
> > > >> > >> >
> > > >> > >> > -	case MIPS_ABI_FP_XX:
> > > >> > >> > -	case MIPS_ABI_FP_ANY:
> > > >> > >> > -		if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
> > > >> > >> > -			set_thread_flag(TIF_32BIT_FPREGS);
> > > >> > >> > -		else
> > > >> > >> > -			clear_thread_flag(TIF_32BIT_FPREGS);
> > > >> > >> > +	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
> > > >> > >> > +		return;
> > > >> > >>
> > > >> > >> The problem is here.  In a 32-bit configuration,
> > > >> > >> MIPS_O32_FP64_SUPPORT is always disabled, so the FP mode
> > > >> > >> doesn't get set.  Simply deleting those two lines makes things
> > > >> > >> work again, but that's probably not the right fix.
> > > >>
> > > >> I don't recall the final decision on default on/off for this option
> > > >> but IIRC it is going to be off for everything except R6 in the
> > > >> first kernel version and then turned on by default(/option removed)
> > > >> when the code is proven for the following kernel version.
> > > >>
> > > >> > >>
> > > >> > > I had the impression that the loader would have set the FP mode
> > > >> > > earlier on.  But that only may happen with the latest version
> > > >> > > of the tools.
> > > >> > >
> > > >> > > Perhaps instead of dropping these two lines we need a similar
> > > >> > > check on the arch_elf_pt_proc so we don't mess with the default
> > FPI abi?
> > > >> > >
> > > >> > > Having said that, dropping these two lines should be fine, it
> > > >> > > just means you do a little bit of extra work when loading your
> > > >> > > ELF files to check for ABI compatibility which shouldn't matter
> > in your case.
> > > >> >
> > > >> > There's another early return like this in arch_check_elf() which
> > > >> > should probably go as well, or everything will end up with the
> > default mode.
> > > >>
> > > >> Ironically I discussed these changes with Markos in an attempt to
> > > >> make all the new changes benign when:
> > > >>
> > > >> !config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT)
> > > >>
> > > >> Clearly this has backfired. I will have to re-read the version of
> > > >> the code in 4.0-rc1 to see what is the root cause. The intention
> > > >> was that without the config option then the kernel would blindly
> > > >> continue to assume that all O32 binaries would run in the original
> > > >> TIF_32BIT_FPREGS mode. As I recall, the callers to
> > > >> mips_set_personality_fp were setting this mode which is why the
> > simple early return was added.
> > > >>
> > > >> Thanks,
> > > >> Matthew
> > > >
> > > > I think I can see what is going on. The problem is that
> > > > mips_set_personality_fp() (as already mentioned) is not executed for
> > > > !CONFIG_MIPS_O32_FP64_SUPPORT. The reason this is a problem (i think
> > > > this could only happen in 64-bit)
> > >
> > > It's definitely causing problems on my 74Kf system.
> > >
> > > > is that SET_PERSONALITY2 clears all the thread flags related to
> > > > 32-bit and FPU. The 32-bit flags will be set again by the
> > > > SET_PERSONALITY32_O32 but the FPU flags are not since the entire
> 
> OK, so this sounds like what differs from what I remember seeing. I thought
> the various SET_PERSONALITY macros were setting up the default FPU flags
> (default as in to match the default O32 FP ABI) and then this would be
> updated in mips_set_personality_fp(). Iirc then mips_set_personality_fp
> is only called for the O32 case so the FPU related flags must be correctly
> set for n32/n64 in the macros. Why not just update the O32 macros to
> set the mode?
Yes that should be fine too.

Mans, could you try the following patch please since it seems you already have
a suitable environment ready to reproduce this problem

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 535f196ffe02..694925a26924 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -294,6 +294,9 @@ do {									\
 	if (personality(current->personality) != PER_LINUX)		\
 		set_personality(PER_LINUX);				\
 									\
+	clear_thread_flag(TIF_HYBRID_FPREGS);				\
+	set_thread_flag(TIF_32BIT_FPREGS);				\
+									\
 	mips_set_personality_fp(state);					\
 									\
 	current->thread.abi = &mips_abi;				\
@@ -319,6 +322,8 @@ do {									\
 	do {								\
 		set_thread_flag(TIF_32BIT_REGS);			\
 		set_thread_flag(TIF_32BIT_ADDR);			\
+		clear_thread_flag(TIF_HYBRID_FPREGS);			\
+		set_thread_flag(TIF_32BIT_FPREGS);			\
 									\
 		mips_set_personality_fp(state);				\
 									\


If that works, I will submit a format patch asap.

-- 
markos
