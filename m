Return-Path: <SRS0=U4pd=SB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1468EC43381
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 10:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C0D218D3
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 10:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfC3Kar (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 30 Mar 2019 06:30:47 -0400
Received: from mx.sdf.org ([205.166.94.20]:63544 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730535AbfC3Kar (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 30 Mar 2019 06:30:47 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2UAUNMB015486
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 30 Mar 2019 10:30:24 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2UAUNOg026448;
        Sat, 30 Mar 2019 10:30:23 GMT
Date:   Sat, 30 Mar 2019 10:30:23 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903301030.x2UAUNOg026448@sdf.org>
To:     heiko.carstens@de.ibm.com, lkml@sdf.org
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc, and alpha?
Cc:     linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20190330084346.GA3801@osiris>
References: <201903291307.x2TD772v013534@sdf.org>,
    <20190330084346.GA3801@osiris>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sat, 30 Mar 2019 at 09:43:47 +0100, Heiko Carstens wrote:
> It hasn't been enabled on s390 simply because at least I wasn't aware
> of this config option. Feel free to send a patch, otherwise I will
> enable this. Whatever you prefer.
> 
> Thanks for pointing this out!

Here's a draft patch, but obviously it should be tested!

From 6f3cc608c49dba33a38e81232a2fd46e8fa8dbcd Mon Sep 17 00:00:00 2001
From: George Spelvin <lkml@sdf.org>
Date: Sat, 30 Mar 2019 10:27:14 +0000
Subject: [PATCH] s390: Enable CONFIG_ARCH_SUPPORTS_INT128 on 64-bit builds

If a platform supports a 64x64->128-bit widening multiply,
that allows more efficient scaling of 64-bit values in various
parts of the kernel.  GCC advertises __int128 support with the
__INT128__ #define, but we care about efficient inline
support, so this is a separate flag.

For s390, that was added on 24 March 2017 by
https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=246457
which is part of GCC 7.

It also only applies to TARGET_ARCH12, which I am guessing
corresponds to HAVE_MARCH_ZEC12_FEATURES.  clang support is
pure guesswork.

Signed-off-by: George Spelvin <lkml@sdf.org>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ed554b09eb3f..43e6dc677f7d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -372,6 +372,7 @@ endchoice
 
 config 64BIT
 	def_bool y
+	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 70000 && HAVE_MARCH_ZEC12_FEATURES || CC_IS_CLANG
 
 config COMPAT
 	def_bool y
-- 
2.20.1

