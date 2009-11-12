Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 17:42:01 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57562 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493047AbZKLQl6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Nov 2009 17:41:58 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nACGg21F010419;
	Thu, 12 Nov 2009 17:42:02 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nACGg2q5010418;
	Thu, 12 Nov 2009 17:42:02 +0100
Date:	Thu, 12 Nov 2009 17:42:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips <linux-mips@linux-mips.org>, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] au1000-eth: convert to platform_driver model
Message-ID: <20091112164202.GB10372@linux-mips.org>
References: <200911100113.38685.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200911100113.38685.florian@openwrt.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 10, 2009 at 01:13:38AM +0100, Florian Fainelli wrote:

> 
> This patch converts the au1000-eth driver to become a full
> platform-driver as it ought to be. We now pass PHY-speficic
> configurations through platform_data but for compatibility
> the driver still assumes the default settings (search for PHY1 on
> MAC0) when no platform_data is passed. Tested on my MTX-1 board.
> 
> Acked-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Queued for 2.6.33.  Thanks everybody!

  Ralf
