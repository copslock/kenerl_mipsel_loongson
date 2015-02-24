Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 15:06:12 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:42318 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007119AbbBXOGKzM5QT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 15:06:10 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id A5A801538A; Tue, 24 Feb 2015 14:06:05 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v3] MIPS: kernel: elf: Improve the overall ABI and FPU mode checks
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
        <1422893593-1291-1-git-send-email-markos.chandras@imgtec.com>
        <yw1xwq3778k2.fsf@unicorn.mansr.com>
        <20150224135225.GA23928@mchandras-linux.le.imgtec.org>
Date:   Tue, 24 Feb 2015 14:06:05 +0000
In-Reply-To: <20150224135225.GA23928@mchandras-linux.le.imgtec.org> (Markos
        Chandras's message of "Tue, 24 Feb 2015 13:52:25 +0000")
Message-ID: <yw1xsidv76b6.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Markos Chandras <markos.chandras@imgtec.com> writes:

> Hi,
>
> On Tue, Feb 24, 2015 at 01:17:33PM +0000, Måns Rullgård wrote:
>> This patch (well, the variant that made it into 4.0-rc1) breaks
>> MIPS_ABI_FP_DOUBLE (the gcc default) apps on MIPS32.
>> 
>
> Thanks for the report.
>
>> > +void mips_set_personality_fp(struct arch_elf_state *state)
>> > +{
>> > +	/*
>> > +	 * This function is only ever called for O32 ELFs so we should
>> > +	 * not be worried about N32/N64 binaries.
>> > +	 */
>> >
>> > -	case MIPS_ABI_FP_XX:
>> > -	case MIPS_ABI_FP_ANY:
>> > -		if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
>> > -			set_thread_flag(TIF_32BIT_FPREGS);
>> > -		else
>> > -			clear_thread_flag(TIF_32BIT_FPREGS);
>> > +	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
>> > +		return;
>> 
>> The problem is here.  In a 32-bit configuration, MIPS_O32_FP64_SUPPORT
>> is always disabled, so the FP mode doesn't get set.  Simply deleting
>> those two lines makes things work again, but that's probably not the
>> right fix.
>> 
> I had the impression that the loader would have set the FP mode earlier on.
> But that only may happen with the latest version of the tools.
>
> Perhaps instead of dropping these two lines we need a similar check on the
> arch_elf_pt_proc so we don't mess with the default FPI abi?
>
> Having said that, dropping these two lines should be fine, it just means you
> do a little bit of extra work when loading your ELF files to check for ABI
> compatibility which shouldn't matter in your case.

There's another early return like this in arch_check_elf() which should
probably go as well, or everything will end up with the default mode.

-- 
Måns Rullgård
mans@mansr.com
