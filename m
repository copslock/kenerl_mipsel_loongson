Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2005 17:42:58 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:8466 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225931AbVEDQmm>; Wed, 4 May 2005 17:42:42 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j44GgSd4017803;
	Wed, 4 May 2005 17:42:28 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j44GgRe2017802;
	Wed, 4 May 2005 17:42:27 +0100
Date:	Wed, 4 May 2005 17:42:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	"'Alex Gonzalez'" <linux-mips@packetvision.com>,
	linux-mips@linux-mips.org
Subject: Re:
Message-ID: <20050504164227.GE5525@linux-mips.org>
References: <1115214949.13387.13.camel@euskadi.packetvision> <20050504142226Z8225804-1340+6519@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504142226Z8225804-1340+6519@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 04, 2005 at 10:22:08AM -0400, Bryan Althouse wrote:

> Thanks for your help.  Yes I do need SMP.  Jason Liu of PMC did a check on
> my serial number, and found that I have rev 1.1 silicon.  He says I need rev
> 1.2 in order to use a 2.6.x kernel.  I have shipped my hardware back to them
> for an upgrade.  Hopefully, I'll be back in business in a week or two.

That is correct.  Earlier revisions didn't implement some functionality
that is crucial to SMP.  Since only PMC and a small number outside parties
have pre-1.2 silicon I agreed with PMC to not try to support earlier
revisions.

  Ralf
