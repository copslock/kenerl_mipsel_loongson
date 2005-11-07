Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2005 19:30:29 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:5907 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133815AbVKGTaL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Nov 2005 19:30:11 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA7JVJDM016853;
	Mon, 7 Nov 2005 19:31:19 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA7JVIrs016852;
	Mon, 7 Nov 2005 19:31:18 GMT
Date:	Mon, 7 Nov 2005 19:31:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Redefine outs[wl] for ide_outs[wl].
Message-ID: <20051107193118.GC2915@linux-mips.org>
References: <20051106.235821.108306460.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106.235821.108306460.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 06, 2005 at 11:58:21PM +0900, Atsushi Nemoto wrote:

> Add missing bits to fix D-cache aliasing problem in the PIO IDE driver.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, applied

  Ralf
