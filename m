Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2005 10:32:53 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:38421 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133467AbVKIKcf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Nov 2005 10:32:35 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA9AXmVP014388;
	Wed, 9 Nov 2005 10:33:53 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA8M3mVb003256;
	Tue, 8 Nov 2005 22:03:48 GMT
Date:	Tue, 8 Nov 2005 22:03:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexey Dobriyan <adobriyan@gmail.com>
Cc:	linux-mips@linux-mips.org, Andrew Morton <akpm@osdl.org>,
	Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] arch/mips/au1000/common/usbdev.c: don't concatenate __FUNCTION__ with strings
Message-ID: <20051108220348.GC2735@linux-mips.org>
References: <20051108174437.GB7631@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108174437.GB7631@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 08, 2005 at 08:44:37PM +0300, Alexey Dobriyan wrote:

> From: Clemens Buchacher <drizzd@aon.at>
> 
> It's deprecated. Use "%s", __FUNCTION__ instead.

Applied,

  Ralf
