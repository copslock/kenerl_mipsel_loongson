Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 16:32:41 +0100 (WEST)
Received: from elvis.franken.de ([193.175.24.41]:46586 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022946AbZFCPce (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Jun 2009 16:32:34 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1MBsS8-00045P-00; Wed, 03 Jun 2009 17:32:32 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 265FFC34F9; Wed,  3 Jun 2009 17:31:52 +0200 (CEST)
Date:	Wed, 3 Jun 2009 17:31:52 +0200
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add DMA declare coherent memory support
Message-ID: <20090603153151.GA4009@alpha.franken.de>
References: <20090604001604.9ced2997.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090604001604.9ced2997.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Jun 04, 2009 at 12:16:04AM +0900, Yoichi Yuasa wrote:
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

a little bit more description what this is all about would be quite
helpful. I also see a problem as there is at least one MIPS machine
(SGI IP28), which doesn't support coherent memory (at least not without
playing dirty games with the memory controller, which in return makes
the machine slow). 

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
