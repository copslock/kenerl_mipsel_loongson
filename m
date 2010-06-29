Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2010 22:17:06 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:34148 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491158Ab0F2URB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jun 2010 22:17:01 +0200
Received: from localhost (cpc5-brad6-0-0-cust25.barn.cable.virginmedia.com [82.38.64.26])
        by arkanian.console-pimps.org (Postfix) with ESMTPSA id 6CCD348043;
        Tue, 29 Jun 2010 21:17:00 +0100 (BST)
From:   Matt Fleming <matt@console-pimps.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mmc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3] MMC: Add JZ4740 mmc driver
In-Reply-To: <1277688041-23522-1-git-send-email-lars@metafoo.de>
References: <1276924111-11158-19-git-send-email-lars@metafoo.de> <1277688041-23522-1-git-send-email-lars@metafoo.de>
User-Agent: Notmuch/0.3.1-61-g3f63bb6 (http://notmuchmail.org) Emacs/23.1.90.2 (x86_64-unknown-linux-gnu)
Date:   Tue, 29 Jun 2010 21:17:00 +0100
Message-ID: <87aaqd1tmr.fsf@linux-g6p1.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 27277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19722

On Mon, 28 Jun 2010 03:20:41 +0200, Lars-Peter Clausen <lars@metafoo.de> wrote:
> This patch adds support for the mmc controller on JZ4740 SoCs.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: linux-mmc@vger.kernel.org
> 
> ---
> Changes since v1
> - Do not request IRQ with IRQF_DISABLED since it is a noop now
> - Use a generous slack for the timeout timer. It does not need to be accurate.
> Changes since v2
> - Use sg_mapping_to iterate over sg elements in mmc read and write functions
> - Use bitops instead of a spinlock and a variable for testing whether a request
>   has been finished.
> - Rework irq and timeout handling in order to get rid of locking in hot paths

Acked-by: Matt Fleming <matt@console-pimps.org>

Are you planning on maintaining this driver? If so, it'd be a good idea
to update MAINTAINERS.
