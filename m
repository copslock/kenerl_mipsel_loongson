Return-Path: <SRS0=BTV6=SC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B513C43381
	for <linux-mips@archiver.kernel.org>; Sun, 31 Mar 2019 00:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693332146F
	for <linux-mips@archiver.kernel.org>; Sun, 31 Mar 2019 00:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfCaAap (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 30 Mar 2019 20:30:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:35247 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730948AbfCaAap (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 30 Mar 2019 20:30:45 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2V0UPpp012433;
        Sat, 30 Mar 2019 19:30:26 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x2V0UNYa012432;
        Sat, 30 Mar 2019 19:30:23 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 30 Mar 2019 19:30:21 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     George Spelvin <lkml@sdf.org>
Cc:     heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-alpha@vger.kernel.org
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc, and alpha?
Message-ID: <20190331003020.GO3969@gate.crashing.org>
References: <20190330084346.GA3801@osiris> <201903301030.x2UAUNOg026448@sdf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903301030.x2UAUNOg026448@sdf.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sat, Mar 30, 2019 at 10:30:23AM +0000, George Spelvin wrote:
> For s390, that was added on 24 March 2017 by
> https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=246457
> which is part of GCC 7.
> 
> It also only applies to TARGET_ARCH12, which I am guessing
> corresponds to HAVE_MARCH_ZEC12_FEATURES.

zEC12 is arch10, while z14 is arch12.  See
https://sourceware.org/binutils/docs-2.32/as/s390-Options.html#s390-Options
for example; it lists the correspondences, and states "The processor names
starting with arch refer to the edition number in the Principle of
Operations manual.  They can be used as alternate processor names and have
been added for compatibility with the IBM XL compiler."

Newer GCC does not use the somewhat confusing TARGET_ARCH12 name anymore;
see https://gcc.gnu.org/r264796 .


Segher
