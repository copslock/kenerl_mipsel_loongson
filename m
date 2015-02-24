Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 14:52:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11098 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007112AbbBXNwbsGLyN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 14:52:31 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 837C189786F79;
        Tue, 24 Feb 2015 13:52:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 24 Feb 2015 13:52:26 +0000
Received: from localhost (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 24 Feb
 2015 13:52:25 +0000
Date:   Tue, 24 Feb 2015 13:52:25 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
CC:     <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v3] MIPS: kernel: elf: Improve the overall ABI and FPU
 mode checks
Message-ID: <20150224135225.GA23928@mchandras-linux.le.imgtec.org>
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
 <1422893593-1291-1-git-send-email-markos.chandras@imgtec.com>
 <yw1xwq3778k2.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xwq3778k2.fsf@unicorn.mansr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45920
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

Hi,

On Tue, Feb 24, 2015 at 01:17:33PM +0000, Måns Rullgård wrote:
> This patch (well, the variant that made it into 4.0-rc1) breaks
> MIPS_ABI_FP_DOUBLE (the gcc default) apps on MIPS32.
> 

Thanks for the report.

> > +void mips_set_personality_fp(struct arch_elf_state *state)
> > +{
> > +	/*
> > +	 * This function is only ever called for O32 ELFs so we should
> > +	 * not be worried about N32/N64 binaries.
> > +	 */
> >
> > -	case MIPS_ABI_FP_XX:
> > -	case MIPS_ABI_FP_ANY:
> > -		if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
> > -			set_thread_flag(TIF_32BIT_FPREGS);
> > -		else
> > -			clear_thread_flag(TIF_32BIT_FPREGS);
> > +	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
> > +		return;
> 
> The problem is here.  In a 32-bit configuration, MIPS_O32_FP64_SUPPORT
> is always disabled, so the FP mode doesn't get set.  Simply deleting
> those two lines makes things work again, but that's probably not the
> right fix.
> 
I had the impression that the loader would have set the FP mode earlier on.
But that only may happen with the latest version of the tools.

Perhaps instead of dropping these two lines we need a similar check on the
arch_elf_pt_proc so we don't mess with the default FPI abi?

Having said that, dropping these two lines should be fine, it just means you
do a little bit of extra work when loading your ELF files to check for ABI
compatibility which shouldn't matter in your case.

Matthew what do you think?

-- 
markos
