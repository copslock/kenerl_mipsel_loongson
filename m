Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 21:38:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:40598 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022973AbXCTVhS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 21:37:18 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2KLYxd3004551;
	Tue, 20 Mar 2007 21:35:14 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2KDcbdk007996;
	Tue, 20 Mar 2007 13:38:38 GMT
Date:	Tue, 20 Mar 2007 13:38:37 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Deepak Saxena <dsaxena@plexity.net>
Cc:	netdev@vger.kernel.org, jeff@garzik.org, linux-mips@linux-mips.org,
	Manish Lachwani <mlachwani@mvista.com>
Subject: Re: [PATCH] Netpoll support for Sibyte MAC
Message-ID: <20070320133837.GA7519@linux-mips.org>
References: <20070319224311.GA10176@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070319224311.GA10176@plexity.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 19, 2007 at 03:43:11PM -0700, Deepak Saxena wrote:

> +#ifdef CONFIG_SBMAC_COALESCE

Not your patch's fault but ...  CONFIG_SBMAC_COALESCE is being defined
in sb1250-mac.c but the CONFIG_* namespace is reserved for kconfig.

  Ralf
