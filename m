Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2011 15:05:18 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36592 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491041Ab1BKOFP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Feb 2011 15:05:15 +0100
Received: from duck.linux-mips.net (localhost.localdomain [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p1BE61sW004023;
        Fri, 11 Feb 2011 15:06:01 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p1BE60If004019;
        Fri, 11 Feb 2011 15:06:00 +0100
Date:   Fri, 11 Feb 2011 15:06:00 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A" <anoop.pa@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] Platform support MSP onchip USB controller.
Message-ID: <20110211140600.GA23348@linux-mips.org>
References: <1295943725-20308-1-git-send-email-anoop.pa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295943725-20308-1-git-send-email-anoop.pa@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@duck.linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 25, 2011 at 01:52:05PM +0530, Anoop P.A wrote:

> +#ifdef CONFIG_MSP_HAS_DUAL_USB
> +#define NUM_USB_DEVS   2
> +#else
> +#define NUM_USB_DEVS   1
> +#endif

I thought you meant to replace CONFIG_MSP_HAS_DUAL_USB with a runtime
check?

  Ralf
