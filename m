Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2005 13:25:16 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:21011 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225272AbVIMMY4>; Tue, 13 Sep 2005 13:24:56 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8DCOgUh009720;
	Tue, 13 Sep 2005 13:24:42 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8DCOeX7009719;
	Tue, 13 Sep 2005 13:24:40 +0100
Date:	Tue, 13 Sep 2005 13:24:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: deletion of boards
Message-ID: <20050913122440.GA3224@linux-mips.org>
References: <1126575034.11755.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126575034.11755.85.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 12, 2005 at 06:30:34PM -0700, Pete Popov wrote:

> The AMD Pb1000, Pb1100, Pb1500, and Hydrogen3 boards are not up to date
> in 2.6 and seem to be of very little interest to anyone. Any objections
> if I remove them to reduce the clutter?

The inflation of evaluation boards is generally some sort of problem; in
many cases they are on the market only for a very short time before they're
replaced - we're talking about a time frame of like 6 months or so.  That
means the time that a Linux port is actually of interest if often just
as short.  Which means, we have quite a few candidates for deletion.

  Ralf
