Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2006 03:40:49 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:12548 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133566AbWCGDkk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Mar 2006 03:40:40 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 626AD64D3D; Tue,  7 Mar 2006 03:49:01 +0000 (UTC)
Received: by unjust.cyrius.com (Postfix, from userid 1000)
	id 9C2C83EB2A; Tue,  7 Mar 2006 03:48:51 +0000 (GMT)
Resent-From: tbm@cyrius.com
Resent-Date: Tue, 7 Mar 2006 03:48:51 +0000
Resent-Message-ID: <20060307034851.GB29936@unjust.cyrius.com>
Resent-To: linux-mips@linux-mips.org
Date:	Mon, 6 Mar 2006 22:51:31 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH, RESEND] Add MWI workaround for Tulip DC21143
Message-ID: <20060306225131.GA23327@unjust.cyrius.com>
References: <20060129230816.GD4094@colonel-panic.org> <20060218220851.GA1601@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218220851.GA1601@colonel-panic.org>
User-Agent: Mutt/1.5.9i
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Peter Horton <pdh@colonel-panic.org> [2006-02-18 22:08]:
> This patch works around the MWI bug on the DC21143 rev 65 Tulip by
> ensuring that the receive buffers don't end on a cache line boundary (as
> documented in the errata).
> 
> This patch is required for the MIPs based Cobalt Qube/RaQ as supporting
> the extra PCI commands seems to reduce the chance of a hard lockup
> between the Tulip and the PCI bridge.

Does anyone have comments regarding this patch?  I received
confirmation from a number of Debian users that this patch
significantly improves the lockup situation on Cobalt, so
it would be nice if it could go in.
-- 
Martin Michlmayr
tbm@cyrius.com
