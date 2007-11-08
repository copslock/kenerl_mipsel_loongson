Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2007 02:30:32 +0000 (GMT)
Received: from ozlabs.org ([203.10.76.45]:58569 "EHLO ozlabs.org")
	by ftp.linux-mips.org with ESMTP id S28577831AbXKHCaY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2007 02:30:24 +0000
Received: by ozlabs.org (Postfix, from userid 1003)
	id 03633DDE27; Thu,  8 Nov 2007 13:30:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18226.29871.368838.584925@cargo.ozlabs.ibm.com>
Date:	Thu, 8 Nov 2007 13:30:07 +1100
From:	Paul Mackerras <paulus@samba.org>
To:	Johannes Berg <johannes@sipsolutions.net>
Cc:	linux-pm@lists.linux-foundation.org,
	Bryan Wu <bryan.wu@analog.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH (2.6.25) 2/2] suspend: clean up Kconfig
In-Reply-To: <20071107135849.207149000@sipsolutions.net>
References: <20071107135758.100171000@sipsolutions.net>
	<20071107135849.207149000@sipsolutions.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Return-Path: <paulus@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulus@samba.org
Precedence: bulk
X-list: linux-mips

Johannes Berg writes:

> This cleans up the suspend Kconfig and removes the need to
> declare centrally which architectures support suspend. All
> architectures that currently support suspend are modified
> accordingly.

Acked-by: Paul Mackerras <paulus@samba.org>
