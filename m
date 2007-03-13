Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 19:07:48 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.24]:19941 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20022334AbXCMTHm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2007 19:07:42 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2DJ4Io4000783
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Mar 2007 12:04:19 -0700
Received: from freekitty (freekitty.pdx.osdl.net [10.8.0.54])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2DJ4ILA006238;
	Tue, 13 Mar 2007 11:04:18 -0800
Date:	Tue, 13 Mar 2007 12:04:18 -0700
From:	Stephen Hemminger <shemminger@linux-foundation.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	netdev@vger.kernel.org, jeff@garzik.org, sshtylyov@ru.mvista.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH] tc35815: Fix an usage of streaming DMA API.
Message-ID: <20070313120418.554a3a43@freekitty>
In-Reply-To: <20070314.010220.65192616.anemo@mba.ocn.ne.jp>
References: <20070303.235459.25478204.anemo@mba.ocn.ne.jp>
	<20070314.010220.65192616.anemo@mba.ocn.ne.jp>
Organization: Linux Foundation
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <shemminger@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shemminger@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 Mar 2007 01:02:20 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> The tc35815 driver lacks a call to pci_dma_sync_single_for_device() on
> receiving.  Recent fix of MIPS dma_sync_single_for_cpu() reveal this
> bug.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch can be applied to netdev-2.6 tree or 2.6.21-rc3-mm2.
> 
> diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
> index ec888db..eed78b5 100644
> --- a/drivers/net/tc35815.c
> +++ b/drivers/net/tc35815.c
> @@ -58,12 +58,13 @@
>   *	1.34	Fix netpoll locking.  "BH rule" for NAPI is not enough with
>   *		netpoll, hard_start_xmit might be called from irq context.
>   *		PM support.
> + *	1.35	Fix an usage of streaming DMA API.
>   */

Please don't use comments as changelog anymore. It gets out of date.
The use of change control systems has made this practice obsolete.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
