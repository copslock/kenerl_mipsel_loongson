Return-Path: <SRS0=+gtK=SA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B617C43381
	for <linux-mips@archiver.kernel.org>; Fri, 29 Mar 2019 13:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C41217F5
	for <linux-mips@archiver.kernel.org>; Fri, 29 Mar 2019 13:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="klCrQccB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfC2NH1 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:07:27 -0400
Received: from mx.sdf.org ([205.166.94.20]:55961 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbfC2NH0 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 29 Mar 2019 09:07:26 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2TD77wr023453
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Fri, 29 Mar 2019 13:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
        t=1553864836; bh=8YRwR3yMd0d+KmTP83jP1DXcBrFHiIf3wDMXMVarqIg=;
        h=Date:From:To:Subject:Cc;
        b=klCrQccBZVcPalDQLRFRayly6cD1dUqGarewpeB34eaWc77ouPgOCvRcbx5dExYxc
         hY3iqJYoorpRzRXEoR3u4RacU8Y4kiUFqpQVtS6zoDpdHWzftW66TQKLyiACKNT7FA
         l6ykZiSaA8QOJtU/AiGYb5g+EFp6WoLlO5ID1cEc=
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2TD772v013534;
        Fri, 29 Mar 2019 13:07:07 GMT
Date:   Fri, 29 Mar 2019 13:07:07 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903291307.x2TD772v013534@sdf.org>
To:     linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc, and alpha?
Cc:     lkml@sdf.org
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

(Cross-posted in case there are generic issues; please trim if
discussion wanders into single-architecture details.)

I was working on some scaling code that can benefit from 64x64->128-bit
multiplies.  GCC supports an __int128 type on processors with hardware
support (including z/Arch and MIPS64), but the support was broken on
early compilers, so it's gated behind CONFIG_ARCH_SUPPORTS_INT128.

Currently, of the ten 64-bit architectures Linux supports, that's
only enabled on x86, ARM, and RISC-V.

SPARC and HP-PA don't have support.

But that leaves Alpha, Mips, PowerPC, and S/390x.

Current mips64, powerpc64, and s390x gcc seems to generate sensible code
for mul_u64_u64_shr() in <linux/math64.h> if I cross-compile them.

I don't have easy access to an Alpha cross-compiler to test, but
as it has UMULH, I suspect it would work, too.

Is there a reason it hasn't been enabled on these platforms?

There might be a MIPS64r6 issue, since r6 changed from DMULTU
writing the lo and hi registers to DMULU/DMUHU, and gcc 8.3, at
least, doesn't know how to generate inline code for the latter.

(Note that users *also* check __INT128__, which is defined if GCC
claims to support __int128, so you don't have to worry about 32-bit
compiles or ancient compilers.  It only has to be conditional on
*broken* support.)


FWIW, the code I'm working on has this inner loop:
(https://arxiv.org/abs/1805.10941 for details)

u64 get_random_u64(void);
u64 get_random_max64(u64 range, u64 lim)
{
	unsigned __int128 prod;
	do {
		prod = (unsigned __int128)get_random_u64() * range;
	} while (unlikely((u64)prod < lim));
	return prod >> 64;
}

Which turns into these inner loops:
MIPS:
.L7:
	jal	get_random_u64
	nop
	dmultu $2,$17
	mflo	$3
	sltu	$4,$3,$16
	bne	$4,$0,.L7
	mfhi	$2

PowerPC:
.L9:
	bl get_random_u64
	nop
	mulld 9,3,31
	mulhdu 3,3,31
	cmpld 7,30,9
	bgt 7,.L9

s/390:
.L13:
	brasl	%r14,get_random_u64@PLT
	lgr	%r5,%r2
	mlgr	%r4,%r10
	lgr	%r2,%r4
	clgr	%r11,%r5
	jh	.L13

I like that the MIPS code leaves the high half of the product in
the hi register until it tests the low half; I wish PowerPC would
similarly move the mulhdu *after* the loop, like the following
hypothetical MIPS R6 code:

.L7:
	balc	get_random_u64
	dmulu	$3, $2, $17
	sltu	$3, $3, $16
	bnezc	$3, .L7
	dmuhu	$2, $2, $17

Or this handwritten Alpha code:
1:
	bsr	$26, get_random_u64
	mulq	$0, $9, $1	# $9 is range
	cmpult	$1, $10, $1	# $10 is lim
	bne	$1, 1b
	umulh	$0, $9, $0
