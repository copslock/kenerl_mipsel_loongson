Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2018 23:14:23 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993070AbeF0VOP0mfnq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jun 2018 23:14:15 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1812505C;
        Wed, 27 Jun 2018 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530134048;
        bh=/P5NFbo+IhlMd57cFNnisR/yX5fOrQ7Ny/8h8rHKPLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paGlCXb9KfsZqZ8Oz85RIAV1BjkuOCtilBaouJCwrs92aw0ObcvUr0ZbTyzydGa3B
         rTIn4Hk49HGg1uVWm7q7eo0QhbYceYoic/zx3vbmTT6FNZO4nS8USGYDrrSEE2Aqrv
         QDwueAGnvtQUeFKNpoxyo5JGHG4JLCPy8+4QcPB4=
Date:   Wed, 27 Jun 2018 22:14:04 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Georgi Guninski <guninski@guninski.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Potential BUG_ON() in do_group_exit() on 4.17.2
Message-ID: <20180627211403.GA11655@jamesdev>
References: <20180627121302.56nivw2adgov3fvn@sivokote.iziade.m$>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627121302.56nivw2adgov3fvn@sivokote.iziade.m$>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

On Wed, Jun 27, 2018 at 03:13:02PM +0300, Georgi Guninski wrote:
> Does this BUG_ON() gets hit on mips?
> 
> in 4.17.2 ./kernel/exit.c
> 
> do_group_exit(int exit_code)
> {
> 	struct signal_struct *sig = current->signal;
> 
> 	BUG_ON(exit_code & 0x80);
> 
> |do_group_exit| is called from
> 
> ./kernel/signal.c:2482:		do_group_exit(ksig->info.si_signo);
> 
> Appears to me si_signo can be 0x80 (in decimal 128) because of:
> 
> arch/mips/include/uapi/asm/signal.h:15:#define _NSIG		128
> 
> Probably testcase will be:
> $kill -128 `pidof program`

I've hit this by accident before, while tweaking GDB on MIPS. See here:

[RFC] kernel/signal.c: avoid BUG_ON with SIG128 (MIPS):
https://patchwork.linux-mips.org/patch/5343/

[v2] MIPS: Reduce _NSIG from 128 to 127 to avoid BUG_ON:
https://patchwork.linux-mips.org/patch/5461/

[v3] kernel/signal.c: fix BUG_ON with SIG128 (MIPS):
https://patchwork.linux-mips.org/patch/5538/
https://patchwork.linux-mips.org/patch/5550/

[v4] MIPS: Reduce _NSIG from 128 to 127 to avoid BUG_ON:
https://patchwork.linux-mips.org/patch/5564/

I think the fear of subtle user ABI breakage was probably prominent in
why it never got properly fixed. It'd be nice to get some resolution
though.

Cheers
James
