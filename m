Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2011 18:46:07 +0100 (CET)
Received: from mail.vyatta.com ([76.74.103.46]:53901 "EHLO mail.vyatta.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491830Ab1BXRqF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Feb 2011 18:46:05 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.vyatta.com (Postfix) with ESMTP id 719A118290E5;
        Thu, 24 Feb 2011 09:45:58 -0800 (PST)
X-Virus-Scanned: amavisd-new at tahiti.vyatta.com
Received: from mail.vyatta.com ([127.0.0.1])
        by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jtF1JHAy-Lq4; Thu, 24 Feb 2011 09:45:57 -0800 (PST)
Received: from nehalam (pool-74-107-135-205.ptldor.fios.verizon.net [74.107.135.205])
        by mail.vyatta.com (Postfix) with ESMTPSA id 76AF518290DE;
        Thu, 24 Feb 2011 09:45:57 -0800 (PST)
Date:   Thu, 24 Feb 2011 09:45:56 -0800
From:   Stephen Hemminger <shemminger@vyatta.com>
To:     "Anoop P.A" <anoop.pa@gmail.com>
Cc:     davem@davemloft.net, khilman@deeprootsystems.com, cyril@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Network driver for PMC-Sierra MSP71xx TSMAC.
Message-ID: <20110224094556.6c371c38@nehalam>
In-Reply-To: <1298548660-10546-1-git-send-email-anoop.pa@gmail.com>
References: <1298548660-10546-1-git-send-email-anoop.pa@gmail.com>
Organization: Vyatta
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <shemminger@vyatta.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shemminger@vyatta.com
Precedence: bulk
X-list: linux-mips

On Thu, 24 Feb 2011 17:27:40 +0530
"Anoop P.A" <anoop.pa@gmail.com> wrote:

> +#if PMC_MSP_TSMAC
> +
> +config DESC_ALL_DSPRAM
> +	bool "TX/RX Descriptors in DSPRAM"
> +	depends on DMA_TO_SPRAM
> +	default n
> +	help
> +	  Turning this on puts TX/RX descriptors in DSPRAM. Otherwise they are in
> +	  DRAM.
> +
> +config TSMAC_LINELOOPBACK_FEATURE
> +	bool "lineLoopBack command"
> +	default n
> +	help
> +	  Turning this on includes the lineLoopBack command in the driver's proc
> +	  interface.  Echoing 1 into the lineLoopBack results in all rx packets
> +	  being transmitted out the same port.
> +
> +config TSMAC_TEST_CMDS
> +	bool "test commands"
> +	default n
> +	help
> +	  Turning this on includes the testing commands in the driver's proc
> +	  interface.  These are used internally by PMC.
> +

Too many config options. Usually no config options is best, or at
most one debug option.

The proc interface for testing should be replaced with debugfs
