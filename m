Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 11:46:43 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:54809 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133713AbVLELqC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Dec 2005 11:46:02 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jB5Bix8S007381;
	Mon, 5 Dec 2005 11:44:59 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jB5BivKY007380;
	Mon, 5 Dec 2005 11:44:57 GMT
Date:	Mon, 5 Dec 2005 11:44:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Tulip RaQ2 64 Bit Fix
Message-ID: <20051205114456.GA2728@linux-mips.org>
References: <4393CD9F.3090305@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4393CD9F.3090305@jg555.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Dec 04, 2005 at 09:18:23PM -0800, Jim Gifford wrote:

> The attached patch allows the tulip driver to work with the RaQ2's 
> network adapter. Without the patch under a 64 bit build, it will never 
> negotiate and will drop packets. This driver is part of Linux Parisc, by 
> Grant Grundler. It's currently in -mm, but Jeff Garzick will not apply 
> it to the main tree.

Why?

  Ralf
