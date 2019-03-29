Return-Path: <SRS0=+gtK=SA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D7C43381
	for <linux-mips@archiver.kernel.org>; Fri, 29 Mar 2019 20:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC52F218A3
	for <linux-mips@archiver.kernel.org>; Fri, 29 Mar 2019 20:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfC2U4z (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:56:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:53817 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730219AbfC2U4z (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 29 Mar 2019 16:56:55 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2TKQKTV010775;
        Fri, 29 Mar 2019 15:26:24 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x2TKQ6eX010707;
        Fri, 29 Mar 2019 15:26:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 29 Mar 2019 15:25:58 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc, and alpha?
Message-ID: <20190329202557.GL3969@gate.crashing.org>
References: <201903291307.x2TD772v013534@sdf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903291307.x2TD772v013534@sdf.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi!

On Fri, Mar 29, 2019 at 01:07:07PM +0000, George Spelvin wrote:
> I was working on some scaling code that can benefit from 64x64->128-bit
> multiplies.  GCC supports an __int128 type on processors with hardware
> support (including z/Arch and MIPS64), but the support was broken on
> early compilers, so it's gated behind CONFIG_ARCH_SUPPORTS_INT128.
> 
> Currently, of the ten 64-bit architectures Linux supports, that's
> only enabled on x86, ARM, and RISC-V.
> 
> SPARC and HP-PA don't have support.
> 
> But that leaves Alpha, Mips, PowerPC, and S/390x.
> 
> Current mips64, powerpc64, and s390x gcc seems to generate sensible code
> for mul_u64_u64_shr() in <linux/math64.h> if I cross-compile them.

Yup.

> I don't have easy access to an Alpha cross-compiler to test, but
> as it has UMULH, I suspect it would work, too.

https://mirrors.edge.kernel.org/pub/tools/crosstool/

> u64 get_random_u64(void);
> u64 get_random_max64(u64 range, u64 lim)
> {
> 	unsigned __int128 prod;
> 	do {
> 		prod = (unsigned __int128)get_random_u64() * range;
> 	} while (unlikely((u64)prod < lim));
> 	return prod >> 64;
> }

> Which turns into these inner loops:
> MIPS:
> .L7:
> 	jal	get_random_u64
> 	nop
> 	dmultu $2,$17
> 	mflo	$3
> 	sltu	$4,$3,$16
> 	bne	$4,$0,.L7
> 	mfhi	$2
> 
> PowerPC:
> .L9:
> 	bl get_random_u64
> 	nop
> 	mulld 9,3,31
> 	mulhdu 3,3,31
> 	cmpld 7,30,9
> 	bgt 7,.L9
> 
> s/390:
> .L13:
> 	brasl	%r14,get_random_u64@PLT
> 	lgr	%r5,%r2
> 	mlgr	%r4,%r10
> 	lgr	%r2,%r4
> 	clgr	%r11,%r5
> 	jh	.L13
> 
> I like that the MIPS code leaves the high half of the product in
> the hi register until it tests the low half; I wish PowerPC would
> similarly move the mulhdu *after* the loop,

The MIPS code has the multiplication inside the loop as well, and even
the mfhi I think: MIPS has delay slots.

GCC treats the int128 as one register until it has expanded to RTL, and it
does not do such loop optimisations after that, apparently.

File a PR please?  https://gcc.gnu.org/bugzilla/


Segher
