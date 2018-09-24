Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 13:00:29 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59663 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeIXLAY4LsuU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 13:00:24 +0200
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DA01D21A7B;
        Mon, 24 Sep 2018 07:00:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 24 Sep 2018 07:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=+3Zq1T085IioVZUG6ygk2FVuGAGypzfDUMvE/zb+64k=; b=PVnNhusD
        z3Wu6ADcNVDXSQiz88+bAj0mmDqVjgxxztFGS+HHz++hdqQJk5z6/LfJuHmtJgge
        loH9O3Zne+4a3BOqwZ6yezriVEc9jyrpIgSQrpyzvEK6WNeaJy90wXNdNLRaHfyO
        AHkRWJyFuavbqUEKfIEv3BohaQ9+0ZLD8B1Z9OqNkdYklzG3cu4oH8A/j1HiC/F3
        FRxK3lrbJspl6OElJ92KfhlenAZ+B6RpqRjmW9He0mP9/PiANjmQaZFslak/njA9
        21PBfkJQF0j/xqbCopuHXq2lpsNuxWzxUCJ+zA2gpfsaeSEAzu4r1/y64R000Vwu
        eRAwWxPOFoGQlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=+3Zq1T085IioVZUG6ygk2FVuGAGyp
        zfDUMvE/zb+64k=; b=uY1eNbWhc6RMxPuWf2vmk2GnbkJZlr2V4lsohMKgDFvWx
        9qYKAbv6yggyEl0doECF8fkJ3W3RYd11DQ2rC7UG2EVXzXDvWvKrsJ6n2ULgrPBK
        oZjeljhwa2SGwSK7IqA6kNMRw3XmgWi4IfS69YqxbCbKdYONAuVV9I3xlVi7Q3iF
        0tPwuztF28XwbctioqbsDg1P3KhHciqp5SLD6N85056pfSyoCdBwnnzmgr5ZBLgh
        rwFmh7bZ2IO6BQi+FuvEeeiDync5vy9bd6KlTtaZMnhuDu6Idq2hRHtbTfJhRFyH
        cau0A9AQfBpPPcmPGGAcwMhJciCxpDrNHVWdeqnTw==
X-ME-Proxy: <xmx:x8OoW2_YG259n-3OpUToHhX0wA9qxr_8gp0EnRVwLOllXmpL1tv5wA>
    <xmx:x8OoW5EHFZIOiboWnQE_uxth7LZYMGKSNvvKsnf6BNZc1iHWMUezRw>
    <xmx:x8OoW1SA_8hA3FX81z23emkBSW8gn-F4L7_4nhEQObDTpftZtl_kAg>
    <xmx:x8OoWxnHRdNsNmolceJr8mxjmghFYrtgDw5wI38emJMGb7nkGD7clA>
    <xmx:x8OoW9lEFSDlpOaRpuxN3SXfop2vf67AsDqd7ra3FnWwm0noTqb0Rw>
    <xmx:x8OoW2tUCT-eIDe-A4j7ll1TxIJgTh1nNY0mJrn6BZntNROj174kTQ>
X-ME-Sender: <xms:xsOoW4oQmhnCkeIOyd2A6g3jA7v2FvBfTCnXrfOlxVcSiRKRtOicfw>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8C958102D2;
        Mon, 24 Sep 2018 07:00:22 -0400 (EDT)
Date:   Mon, 24 Sep 2018 13:00:21 +0200
From:   Greg KH <greg@kroah.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rene Nielsen <rene.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH 4.4] MIPS: VDSO: Match data page cache colouring when D$
 aliases
Message-ID: <20180924110021.GH16476@kroah.com>
References: <20180919212044.21385-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919212044.21385-1-paul.burton@mips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Wed, Sep 19, 2018 at 09:20:59PM +0000, Paul Burton wrote:
> [ Upstream commit 0f02cfbc3d9e413d450d8d0fd660077c23f67eff ]
> 
> When a system suffers from dcache aliasing a user program may observe
> stale VDSO data from an aliased cache line. Notably this can break the
> expectation that clock_gettime(CLOCK_MONOTONIC, ...) is, as its name
> suggests, monotonic.
> 
> In order to ensure that users observe updates to the VDSO data page as
> intended, align the user mappings of the VDSO data page such that their
> cache colouring matches that of the virtual address range which the
> kernel will use to update the data page - typically its unmapped address
> within kseg0.
> 
> This ensures that we don't introduce aliasing cache lines for the VDSO
> data page, and therefore that userland will observe updates without
> requiring cache invalidation.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
> Reported-by: Rene Nielsen <rene.nielsen@microsemi.com>
> Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
> Patchwork: https://patchwork.linux-mips.org/patch/20344/
> Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Tested-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: stable@vger.kernel.org # v4.4+
> ---
>  arch/mips/kernel/vdso.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

This, and the 4.9.y backport, are now applied, thanks.

greg k-h
