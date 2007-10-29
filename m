Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 18:08:29 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:35562 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022964AbXJ2SI1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 18:08:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TI8Kg9010956;
	Mon, 29 Oct 2007 18:08:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TI8542010955;
	Mon, 29 Oct 2007 18:08:05 GMT
Date:	Mon, 29 Oct 2007 18:08:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MTX1 try 2] Register platform devices
Message-ID: <20071029180805.GD3953@linux-mips.org>
References: <200710231855.55605.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200710231855.55605.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 23, 2007 at 06:55:55PM +0200, Florian Fainelli wrote:

> This patch separates the platform devices registration
> for the MTX-1 specific devices : GPIO leds and watchdog.

Thanks, applied.

  Ralf
