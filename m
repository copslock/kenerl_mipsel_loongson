Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 18:35:33 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:39826 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021805AbXGJRfb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2007 18:35:31 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id A0DA3B8925;
	Tue, 10 Jul 2007 19:34:55 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1I8Jbz-0001Xl-17; Tue, 10 Jul 2007 18:34:55 +0100
Date:	Tue, 10 Jul 2007 18:34:54 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	pwatkins@sicortex.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, From: 
Subject: Re: [PATCH] [MIPS] Fix resume for 64K page size
Message-ID: <20070710173454.GA30521@networkno.de>
References: <11840880513393-git-send-email-pwatkins@sicortex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11840880513393-git-send-email-pwatkins@sicortex.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

pwatkins@sicortex.com wrote:
> This fixes a bug when running 64K page size on r4k machines. 
> 
> 
> Signed-off-by: Peter Watkins <pwatkins@sicortex.com>
> ---
>  arch/mips/kernel/r4k_switch.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
> index 0672959..65f0f91 100644
> --- a/arch/mips/kernel/r4k_switch.S
> +++ b/arch/mips/kernel/r4k_switch.S
> @@ -85,7 +85,7 @@ #endif
>  	move	$28, a2
>  	cpu_restore_nonscratch a1
>  
> -#if (_THREAD_SIZE - 32) < 0x10000
> +#if (_THREAD_SIZE) < 0x10000
>  	PTR_ADDIU	t0, $28, _THREAD_SIZE - 32
>  #else
>  	PTR_LI		t0, _THREAD_SIZE - 32

This doesn't look right. I think it should be

#if (_THREAD_SIZE - 32) < 0x8000

in order to avoid an overflow of the immediate.


Thiemo
