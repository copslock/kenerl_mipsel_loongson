Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 18:39:27 +0100 (BST)
Received: from bombadil.infradead.org ([18.85.46.34]:748 "EHLO
	bombadil.infradead.org") by ftp.linux-mips.org with ESMTP
	id S20032889AbYGKRjZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jul 2008 18:39:25 +0100
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by bombadil.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1KHMaX-0008RA-Nq; Fri, 11 Jul 2008 17:39:21 +0000
Subject: Re: [PATCH][MIPS] MTX-1 flash partition setup move to platform
	devices registration
From:	David Woodhouse <dwmw2@infradead.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>,
	linux-mtd <linux-mtd@lists.infradead.org>
In-Reply-To: <20080711141053.GD13593@linux-mips.org>
References: <20080711223448.f5826678.yoichi_yuasa@tripeaks.co.jp>
	 <20080711141053.GD13593@linux-mips.org>
Content-Type: text/plain
Date:	Fri, 11 Jul 2008 18:39:19 +0100
Message-Id: <1215797959.11567.448.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.2 (2.22.2-2.fc9) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+5134bcebce162bdfdbe0+1783+infradead.org+dwmw2@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwmw2@infradead.org
Precedence: bulk
X-list: linux-mips

On Fri, 2008-07-11 at 15:10 +0100, Ralf Baechle wrote:
> On Fri, Jul 11, 2008 at 10:34:48PM +0900, Yoichi Yuasa wrote:
> 
> > MTX-1 flash partition setup move to platform devices registration.
> 
> MTD guys, if you're ok with this patch I'd like to queue it for
> 2.6.27.

Acked-By: David Woodhouse <David.Woodhouse@intel.com>

-- 
dwmw2
