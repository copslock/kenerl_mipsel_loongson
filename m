Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2009 15:33:43 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56811 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493023AbZGQNdf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Jul 2009 15:33:35 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6HDXesm014206;
	Fri, 17 Jul 2009 14:33:40 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6HDXaVs014204;
	Fri, 17 Jul 2009 14:33:36 +0100
Date:	Fri, 17 Jul 2009 14:33:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] rbtx4939: Fix IOC pin-enable register updating
Message-ID: <20090717133335.GB7396@linux-mips.org>
References: <1247663036-4713-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1247663036-4713-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 15, 2009 at 10:03:56PM +0900, Atsushi Nemoto wrote:

> The rbtx4939_update_ioc_pen() expects txx9_ce_res[] already
> initialized.  Call it after tx4939_setup().
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, applied.

  Ralf
