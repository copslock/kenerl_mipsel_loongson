Return-Path: <SRS0=U4pd=SB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E5C43381
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 23:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956F3217F5
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 23:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfC3Xwe (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 30 Mar 2019 19:52:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:46137 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730968AbfC3Xwe (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 30 Mar 2019 19:52:34 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2UNqChW011347;
        Sat, 30 Mar 2019 18:52:13 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x2UNq76d011345;
        Sat, 30 Mar 2019 18:52:07 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 30 Mar 2019 18:52:06 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc, and alpha?
Message-ID: <20190330235205.GN3969@gate.crashing.org>
References: <20190329202557.GL3969@gate.crashing.org> <201903301128.x2UBSLNH017484@sdf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903301128.x2UBSLNH017484@sdf.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sat, Mar 30, 2019 at 11:28:21AM +0000, George Spelvin wrote:
> >> I like that the MIPS code leaves the high half of the product in
> >> the hi register until it tests the low half; I wish PowerPC would
> >> similarly move the mulhdu *after* the loop,
> 
> > The MIPS code has the multiplication inside the loop as well, and even
> > the mfhi I think: MIPS has delay slots.
> 
> Yes, it's in the delay slot, which is fine (the branch is unlikely,
> after all).  But it does the compare (sltu) before accessing %hi, which
> is good as %hi often has a longer latency than %lo.  (On out-of-order
> cores, of course, none of this matters.)

Yes.  But it does the mfhi on every iteration, while it only needs it for
the last one (or after the last one).  This may not be more expensive for
the actual hardware, but it is for GCC's cost model

> > GCC treats the int128 as one register until it has expanded to RTL, and it
> > does not do such loop optimisations after that, apparently.
> > 
> > File a PR please?  https://gcc.gnu.org/bugzilla/
> 
> Er...  about what?  The fact that the PowerPC code is not
> >> PowerPC:
> >> .L9:
> >> 	bl get_random_u64
> >> 	nop
> >> 	mulld 9,3,31
> >> 	cmpld 7,30,9
> >> 	bgt 7,.L9
> >> 	mulhdu 3,3,31
> 
> I'm not sure quite how to explain it in gcc-ese.

Yeah, exactly, like that.  This transformation is called "loop sinking"
usually: if anything that is set within a loop is only used after the loop,
it can be set after the loop (provided you keep the set's sources alive).


Segher
