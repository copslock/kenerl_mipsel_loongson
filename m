Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 16:33:40 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:14487 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21103684AbZA2Qdi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2009 16:33:38 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0TGXXWv001941;
	Thu, 29 Jan 2009 16:33:33 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0TGXWLo001939;
	Thu, 29 Jan 2009 16:33:32 GMT
Date:	Thu, 29 Jan 2009 16:33:32 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Phil Sutter <n0-1@freewrt.org>
Cc:	linux-mips@linux-mips.org, florian@openwrt.org
Subject: Re: [PATCH] define io_map_base for rc32434's PCI controller
Message-ID: <20090129163332.GB1155@linux-mips.org>
References: <1226445364-5402-1-git-send-email-n0-1@freewrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1226445364-5402-1-git-send-email-n0-1@freewrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 12, 2008 at 12:16:04AM +0100, Phil Sutter wrote:

> The code is rather based on trial-and-error than knowledge. Verified Via
> Rhine functionality in PIO as well as MMIO mode.
> 
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> Tested-by: Florian Fainelli <florian@openwrt.org>

Thanks, applied.

  Ralf
