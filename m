Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 01:07:23 +0100 (BST)
Received: from mx1.redhat.com ([66.187.233.31]:7850 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S20045185AbWHLAHQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2006 01:07:16 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7C079fX011627;
	Fri, 11 Aug 2006 20:07:09 -0400
Received: from nwo.kernelslacker.org (vpn-248-1.boston.redhat.com [10.13.248.1])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7C073HI025786;
	Fri, 11 Aug 2006 20:07:06 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.7/8.13.5) with ESMTP id k7C06mFb006697;
	Fri, 11 Aug 2006 20:06:55 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.7/8.13.7/Submit) id k7C06aas006696;
	Fri, 11 Aug 2006 20:06:36 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
Date:	Fri, 11 Aug 2006 20:06:36 -0400
From:	Dave Jones <davej@redhat.com>
To:	Thomas Koeller <thomas@koeller.dyndns.org>
Cc:	wim@iguana.be, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060812000636.GB28540@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thomas Koeller <thomas@koeller.dyndns.org>, wim@iguana.be,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608120149.23380.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <davej@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davej@redhat.com
Precedence: bulk
X-list: linux-mips

On Sat, Aug 12, 2006 at 01:49:23AM +0200, Thomas Koeller wrote:
 > On Friday 11 August 2006 22:56, Dave Jones wrote:
 > > On Thu, Aug 10, 2006 at 11:19:13PM +0200, thomas@koeller.dyndns.org wrote:
 > >  > This is a driver for the on-chip watchdog device found on some
 > >  > MIPS RM9000 processors.
 > >  >
 > >  > Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
 > >
 > > Mostly same nit-picking comments as your other driver..
 > 
 > Which one?

The image capture driver.

 > >  > +#include <linux/config.h>
 > >
 > > not needed.
 > 
 > It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.

kbuild automatically includes it for you in the last few kernels.


 > > As in the previous driver, are these barriers strong enough?
 > > Or do they need explicit reads of the written addresses to flush the write?
 > 
 > I think they are. Remember, the entire device is integrated in the
 > processor. No external buses involved.

Ok.

		Dave

-- 
http://www.codemonkey.org.uk
