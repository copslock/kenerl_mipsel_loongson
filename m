Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 16:40:03 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:30941 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21365580AbZA2QkB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2009 16:40:01 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0TGdu6G002255;
	Thu, 29 Jan 2009 16:39:56 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0TGdumJ002253;
	Thu, 29 Jan 2009 16:39:56 GMT
Date:	Thu, 29 Jan 2009 16:39:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Phil Sutter <n0-1@freewrt.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: rb532: add set_type() function to IRQ struct
Message-ID: <20090129163956.GC1155@linux-mips.org>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net> <20081128194234.EC0FC386DBBE@mail.ifyouseekate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081128194234.EC0FC386DBBE@mail.ifyouseekate.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 28, 2008 at 08:45:10PM +0100, Phil Sutter wrote:

> +	switch (type) {
> +		case IRQ_TYPE_LEVEL_HIGH:
> +			rb532_gpio_set_ilevel(1, gpio);
> +			break;
> +		case IRQ_TYPE_LEVEL_LOW:
> +			rb532_gpio_set_ilevel(0, gpio);
> +			break;
> +		default:
> +			return -EINVAL;
> +	}

Linux coding style - the case and default labels should have the same
indentation level as the switch statement.  I fixed that.

Applied, thanks.

  Ralf
