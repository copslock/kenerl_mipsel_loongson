Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 14:36:22 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:41486 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133647AbVLEOf7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Dec 2005 14:35:59 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jB5EZUhx014125;
	Mon, 5 Dec 2005 14:35:30 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jB5EZUUL014124;
	Mon, 5 Dec 2005 14:35:30 GMT
Date:	Mon, 5 Dec 2005 14:35:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix mdelay(1) for 64bit kernel with HZ == 1000
Message-ID: <20051205143530.GD2728@linux-mips.org>
References: <20051130.133326.126937941.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130.133326.126937941.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 30, 2005 at 01:33:26PM +0900, Atsushi Nemoto wrote:

> mdelay(1) (i.e. udelay(1000)) does not work correctly due to overflow.
> 
> 1000 * 0x004189374BC6A7f0 = 0x10000000000000180 (>= 2**64)
> 
> 0x004189374BC6A7ef (0x004189374BC6A7f0 - 1) is OK and it is exactly
> same as catchall case (0x8000000000000000UL / (500000 / HZ)).
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Applied.
