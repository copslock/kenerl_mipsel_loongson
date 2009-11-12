Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 17:41:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57498 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493108AbZKLQl2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Nov 2009 17:41:28 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nACGfRun010396;
	Thu, 12 Nov 2009 17:41:27 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nACGfO8I010394;
	Thu, 12 Nov 2009 17:41:24 +0100
Date:	Thu, 12 Nov 2009 17:41:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] alchemy: add au1000-eth platform device
Message-ID: <20091112164124.GA10372@linux-mips.org>
References: <200911100113.31471.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200911100113.31471.florian@openwrt.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 10, 2009 at 01:13:30AM +0100, Florian Fainelli wrote:

> (resending per Ralf's request as the patch had some checkpatch errors)

You missed the trailing whitespace ...  Anyway, fixed that up and queued
it for 2.6.33.

  Ralf
