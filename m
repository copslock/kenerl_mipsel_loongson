Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 16:41:36 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33501 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21365580AbZA2Qle (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2009 16:41:34 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0TGfViG002367;
	Thu, 29 Jan 2009 16:41:31 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0TGfV7l002365;
	Thu, 29 Jan 2009 16:41:31 GMT
Date:	Thu, 29 Jan 2009 16:41:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Phil Sutter <n0-1@freewrt.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: rb532: auto disable GPIO alternate function
Message-ID: <20090129164131.GD1155@linux-mips.org>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net> <20081128194333.B8090386B1A6@mail.ifyouseekate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081128194333.B8090386B1A6@mail.ifyouseekate.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 28, 2008 at 08:46:09PM +0100, Phil Sutter wrote:

> When a driver calls gpio_set_direction_{input,output}(), it obviously
> doesn't want the alternate function for that pin to be active (as the
> direction would not matter in that case). This patch ensures alternate
> function is disabled when the direction is being changed.

Applied.  Thanks,

  Ralf
