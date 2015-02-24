Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 15:26:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41382 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007119AbbBXO0LWWZhe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 15:26:11 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EE52264B2701F;
        Tue, 24 Feb 2015 14:26:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 24 Feb 2015 14:26:05 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Tue, 24 Feb 2015 14:26:05 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>
Subject: RE: [PATCH v3] MIPS: kernel: elf: Improve the overall ABI and FPU
 mode checks
Thread-Topic: [PATCH v3] MIPS: kernel: elf: Improve the overall ABI and FPU
 mode checks
Thread-Index: AQHQUDsHTpUqzW/P5ESAwcGgwy98jpz/2RXg
Date:   Tue, 24 Feb 2015 14:26:04 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FDEE92@LEMAIL01.le.imgtec.org>
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
        <1422893593-1291-1-git-send-email-markos.chandras@imgtec.com>
        <yw1xwq3778k2.fsf@unicorn.mansr.com>
        <20150224135225.GA23928@mchandras-linux.le.imgtec.org>
 <yw1xsidv76b6.fsf@unicorn.mansr.com>
In-Reply-To: <yw1xsidv76b6.fsf@unicorn.mansr.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.113]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Måns Rullgård <mans@mansr.com> writes:
> Markos Chandras <markos.chandras@imgtec.com> writes:
> 
> > Hi,
> >
> > On Tue, Feb 24, 2015 at 01:17:33PM +0000, Måns Rullgård wrote:
> >> This patch (well, the variant that made it into 4.0-rc1) breaks
> >> MIPS_ABI_FP_DOUBLE (the gcc default) apps on MIPS32.
> >>
> >
> > Thanks for the report.
> >
> >> > +void mips_set_personality_fp(struct arch_elf_state *state) {
> >> > +	/*
> >> > +	 * This function is only ever called for O32 ELFs so we should
> >> > +	 * not be worried about N32/N64 binaries.
> >> > +	 */
> >> >
> >> > -	case MIPS_ABI_FP_XX:
> >> > -	case MIPS_ABI_FP_ANY:
> >> > -		if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
> >> > -			set_thread_flag(TIF_32BIT_FPREGS);
> >> > -		else
> >> > -			clear_thread_flag(TIF_32BIT_FPREGS);
> >> > +	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
> >> > +		return;
> >>
> >> The problem is here.  In a 32-bit configuration,
> >> MIPS_O32_FP64_SUPPORT is always disabled, so the FP mode doesn't get
> >> set.  Simply deleting those two lines makes things work again, but
> >> that's probably not the right fix.

I don't recall the final decision on default on/off for this option but
IIRC it is going to be off for everything except R6 in the first kernel
version and then turned on by default(/option removed) when the code is
proven for the following kernel version.

> >>
> > I had the impression that the loader would have set the FP mode
> earlier on.
> > But that only may happen with the latest version of the tools.
> >
> > Perhaps instead of dropping these two lines we need a similar check on
> > the arch_elf_pt_proc so we don't mess with the default FPI abi?
> >
> > Having said that, dropping these two lines should be fine, it just
> > means you do a little bit of extra work when loading your ELF files to
> > check for ABI compatibility which shouldn't matter in your case.
> 
> There's another early return like this in arch_check_elf() which should
> probably go as well, or everything will end up with the default mode.

Ironically I discussed these changes with Markos in an attempt to make
all the new changes benign when:

!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT)

Clearly this has backfired. I will have to re-read the version of the code
in 4.0-rc1 to see what is the root cause. The intention was that without
the config option then the kernel would blindly continue to assume that
all O32 binaries would run in the original TIF_32BIT_FPREGS mode. As I
recall, the callers to mips_set_personality_fp were setting this mode
which is why the simple early return was added.

Thanks,
Matthew
