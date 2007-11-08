Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2007 09:48:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:9631 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022395AbXKHJs3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Nov 2007 09:48:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA89mSwj010938;
	Thu, 8 Nov 2007 09:48:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA89mPSN010923;
	Thu, 8 Nov 2007 09:48:25 GMT
Date:	Thu, 8 Nov 2007 09:48:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Johannes Berg <johannes@sipsolutions.net>
Cc:	linux-pm@lists.linux-foundation.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Scott Wood <scottwood@freescale.com>,
	David Howells <dhowells@redhat.com>, linux-mips@linux-mips.org,
	Paul Mundt <lethal@linux-sh.org>,
	Bryan Wu <bryan.wu@analog.com>,
	Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH (2.6.25) 2/2] suspend: clean up Kconfig
Message-ID: <20071108094825.GB10665@linux-mips.org>
References: <20071107135758.100171000@sipsolutions.net> <20071107135849.207149000@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071107135849.207149000@sipsolutions.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 07, 2007 at 02:58:00PM +0100, Johannes Berg wrote:

> This cleans up the suspend Kconfig and removes the need to
> declare centrally which architectures support suspend. All
> architectures that currently support suspend are modified
> accordingly.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Cheers,

  Ralf
