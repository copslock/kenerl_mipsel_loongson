Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 15:15:27 +0000 (GMT)
Received: from pip10.gyao.ne.jp ([61.122.117.248]:12693 "EHLO mx.gate01.com")
	by ftp.linux-mips.org with ESMTP id S28574144AbXKGPO6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2007 15:14:58 +0000
Received: from [124.34.33.190] (helo=master.linux-sh.org)
	by smtp32.isp.us-com.jp with esmtp (Mail 4.41)
	id 1Ipmb4-0006lJ-V7; Thu, 08 Nov 2007 00:13:39 +0900
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id 33C0A64C7C;
	Wed,  7 Nov 2007 15:13:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b9LclNW9sE96; Thu,  8 Nov 2007 00:13:28 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
	id CC2E064C80; Thu,  8 Nov 2007 00:13:28 +0900 (JST)
Date:	Thu, 8 Nov 2007 00:13:28 +0900
From:	Paul Mundt <lethal@linux-sh.org>
To:	Johannes Berg <johannes@sipsolutions.net>
Cc:	linux-pm@lists.linux-foundation.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Scott Wood <scottwood@freescale.com>,
	David Howells <dhowells@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Bryan Wu <bryan.wu@analog.com>,
	Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH (2.6.25) 2/2] suspend: clean up Kconfig
Message-ID: <20071107151328.GA28181@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-pm@lists.linux-foundation.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Scott Wood <scottwood@freescale.com>,
	David Howells <dhowells@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Bryan Wu <bryan.wu@analog.com>, Russell King <rmk@arm.linux.org.uk>
References: <20071107135758.100171000@sipsolutions.net> <20071107135849.207149000@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071107135849.207149000@sipsolutions.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 07, 2007 at 02:58:00PM +0100, Johannes Berg wrote:
> This cleans up the suspend Kconfig and removes the need to
> declare centrally which architectures support suspend. All
> architectures that currently support suspend are modified
> accordingly.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: linuxppc-dev@ozlabs.org
> Cc: linux-pm@lists.linux-foundation.org
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Bryan Wu <bryan.wu@analog.com>
> Cc: Russell King <rmk@arm.linux.org.uk>
> ---
> Architecture maintainers should evaluate whether their
> ARCH_SUSPEND_POSSIBLE symbol should be set only under
> stricter circumstances like I've done for powerpc.
> 
The SH bits look fine.

Acked-by: Paul Mundt <lethal@linux-sh.org>
