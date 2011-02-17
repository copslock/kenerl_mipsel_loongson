Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 12:38:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53764 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491104Ab1BQLih (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 12:38:37 +0100
Received: from duck.linux-mips.net (localhost.localdomain [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p1HBcK9J010905;
        Thu, 17 Feb 2011 12:38:21 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p1HBcK3g010902;
        Thu, 17 Feb 2011 12:38:20 +0100
Date:   Thu, 17 Feb 2011 12:38:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Loongson: Kconfig: add MACH_LOONGSON dependency
Message-ID: <20110217113820.GA6707@linux-mips.org>
References: <1297936544-24369-1-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1297936544-24369-1-git-send-email-antonynpavlov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 17, 2011 at 12:55:44PM +0300, Antony Pavlov wrote:

> The options LOONGSON_SUSPEND, LOONGSON_UART_BASE et al. don't depend
> on MACH_LOONGSON option.
> So my configuration file (.config) for MIPS Malta board contains
> 
>  # CONFIG_MACH_LOONGSON is not set
>  CONFIG_MIPS_MALTA=y
> 
>  ...
> 
>  CONFIG_LOONGSON_UART_BASE=y

Patch is looking good but commit 3a1f2f05e1759dd6a0876a7998408438d59d4a39
[ MIPS: Fix always CONFIG_LOONGSON_UART_BASE=y ] already fixes the issue.

Thanks!

  Ralf
