Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 16:47:32 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41127 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21365580AbZA2Qra (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2009 16:47:30 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0TGlRcT002631;
	Thu, 29 Jan 2009 16:47:27 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0TGlRrf002628;
	Thu, 29 Jan 2009 16:47:27 GMT
Date:	Thu, 29 Jan 2009 16:47:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Phil Sutter <n0-1@freewrt.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: rb532: remove useless CF GPIO initialisation
Message-ID: <20090129164727.GE1155@linux-mips.org>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net> <20081128194346.5A883386DBBE@mail.ifyouseekate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081128194346.5A883386DBBE@mail.ifyouseekate.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 28, 2008 at 08:46:22PM +0100, Phil Sutter wrote:

> As the pata-rb532-cf driver calls gpio_set_direction_input(), the calls
> to rb532_gpio_set_func() and rb532_gpio_direction_input() are not needed
> since the alternate function is automatically being disabled when
> changing the GPIO pin direction.
> The later two calls to rb532_gpio_set_{ilevel,istat}() are implicitly
> being done by the IRQ initialisation of pata-rb532-cf.
> 
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>

Applied.  Thanks!

  Ralf
