Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 19:55:27 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:46095 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133558AbVJFSzK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 19:55:10 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j96It4pu017418;
	Thu, 6 Oct 2005 19:55:04 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j96It4MF017417;
	Thu, 6 Oct 2005 19:55:04 +0100
Date:	Thu, 6 Oct 2005 19:55:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org, "Cooper, John" <john.cooper@timesys.com>
Subject: Re: PREEMPT
Message-ID: <20051006185504.GD15275@linux-mips.org>
References: <43456EA9.8020209@timesys.com> <20051006184656.GA12173@linux-mips.org> <43457266.3090208@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43457266.3090208@timesys.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 06, 2005 at 02:52:22PM -0400, Greg Weeks wrote:

> I'd remembered some problems ages ago, but had thought they'd been 
> fixed. John was just picking my brain about it so I thought I'd ask to 
> be sure.

The problems I recall were all related to being preempted just while
fiddling with the hardware FPU - can't happen on the fpu-less 4Kc.
Another issue fixesd recently even though more cosmetic were a bunch
of global variables.

  Ralf
