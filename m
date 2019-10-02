Return-Path: <SRS0=RYQo=X3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70116C4360C
	for <linux-mips@archiver.kernel.org>; Wed,  2 Oct 2019 19:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5478820700
	for <linux-mips@archiver.kernel.org>; Wed,  2 Oct 2019 19:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJBT3I (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:29:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56336 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBT3H (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 2 Oct 2019 15:29:07 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iFkJ8-00043W-5t; Wed, 02 Oct 2019 19:29:06 +0000
Date:   Wed, 2 Oct 2019 21:29:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH] MIPS: Wire up clone3 syscall
Message-ID: <20191002192904.tuit4ltadkxtyatx@wittgenstein>
References: <20191002185942.295960-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191002185942.295960-1-paul.burton@mips.com>
User-Agent: NeoMutt/20180716
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Oct 02, 2019 at 06:59:49PM +0000, Paul Burton wrote:
> Wire up the new clone3 syscall for MIPS, using save_static_function() to
> generate a wrapper that saves registers $s0-$s7 prior to invoking the
> generic sys_clone3 function just like we do for plain old clone.
> 
> Tested atop 64r6el_defconfig using o32, n32 & n64 builds of the simple
> test program from:
> 
>   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Christian Brauner <christian@brauner.io>

Thank you, Paul!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
