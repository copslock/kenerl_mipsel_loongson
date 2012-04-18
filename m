Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2012 01:47:10 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45646 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903729Ab2DRXrA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2012 01:47:00 +0200
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 588F22081F
        for <linux-mips@linux-mips.org>; Wed, 18 Apr 2012 19:46:59 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 18 Apr 2012 19:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=ST8eLKuFAM6khM+JBo33ofgov7k=; b=HNpjLaxv5g2VF3H/bjTOnbspTIj8
        wFvcRscQGrD4e6wY/3L/k8esc6NBqudn1naEnul2IhsWA733K/04HdMJpAgscp67
        U4Bakk+cHvpZ4intFrREQOFX7b/qFktsOfdHzt+xEOjRuwwtkfhIHjy/4buJlxuw
        8X0w+ROdApLYBzI=
X-Sasl-enc: 6/PzmHXexx7iyMtGHb10V2LraF+lmEVdfpXJOpPp5ZYi 1334792818
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net [67.168.183.230])
        by mail.messagingengine.com (Postfix) with ESMTPSA id D31FF4824EE;
        Wed, 18 Apr 2012 19:46:58 -0400 (EDT)
Date:   Wed, 18 Apr 2012 16:46:57 -0700
From:   Greg KH <greg@kroah.com>
To:     Imre Kaloz <kaloz@openwrt.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        david.daney@cavium.com
Subject: Re: [PATCH] STAGING: octeon-ethernet: fix build errors by including
 interrupt.h
Message-ID: <20120418234657.GA2202@kroah.com>
References: <1333996155-30523-1-git-send-email-kaloz@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1333996155-30523-1-git-send-email-kaloz@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Apr 09, 2012 at 08:29:15PM +0200, Imre Kaloz wrote:
> This patch fixes the following build failures:
> 
> drivers/staging/octeon/ethernet.c: In function 'cvm_oct_cleanup_module':
> drivers/staging/octeon/ethernet.c:799:2: error: implicit declaration of function 'free_irq'
> drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_no_more_work':
> drivers/staging/octeon/ethernet-rx.c:119:3: error: implicit declaration of function 'enable_irq'
> drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_do_interrupt':
> drivers/staging/octeon/ethernet-rx.c:136:2: error: implicit declaration of function 'disable_irq_nosync'
> drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_rx_initialize':
> drivers/staging/octeon/ethernet-rx.c:532:2: error: implicit declaration of function 'request_irq'
> drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_tx_initialize':
> drivers/staging/octeon/ethernet-tx.c:712:2: error: implicit declaration of function 'request_irq'
> drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_tx_shutdown':
> drivers/staging/octeon/ethernet-tx.c:723:2: error: implicit declaration of function 'free_irq'
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> Acked-by: David Daney <david.daney@cavium.com>

This patch is messed up and does not apply.

And is this needed for 3.4-final?

Please resend it after you fix up your email client.

thanks,

greg k-h
