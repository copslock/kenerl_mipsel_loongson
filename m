Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2009 15:30:06 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54733 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493021AbZGQN36 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Jul 2009 15:29:58 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6HDU95k012303;
	Fri, 17 Jul 2009 14:30:10 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6HDU9B0012301;
	Fri, 17 Jul 2009 14:30:09 +0100
Date:	Fri, 17 Jul 2009 14:30:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/2] ar7: make board code register ar7_wdt as a
	platform device
Message-ID: <20090717133009.GA7396@linux-mips.org>
References: <200907151209.35566.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200907151209.35566.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 15, 2009 at 12:09:34PM +0200, Florian Fainelli wrote:

> This patch makes the board code register the ar7_wdt
> driver as a platform device. We move the dynamic
> resource calculation here since the driver should not be
> aware of the AR7 SoC version it is running on.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Thanks, queued for 2.6.32.  Haven't heared from Wim yet ...

  Ralf
