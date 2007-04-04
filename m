Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 12:42:33 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:24068 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021835AbXDDLmc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Apr 2007 12:42:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E5C01E1CB1;
	Wed,  4 Apr 2007 13:41:50 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KoYAnXcHhyhD; Wed,  4 Apr 2007 13:41:50 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 89EB5E1C9C;
	Wed,  4 Apr 2007 13:41:50 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l34BfwoG032386;
	Wed, 4 Apr 2007 13:41:59 +0200
Date:	Wed, 4 Apr 2007 12:41:55 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
cc:	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Fixed build error on zs serial driver
In-Reply-To: <20070404162934.2635ef95.yoichi_yuasa@tripeaks.co.jp>
Message-ID: <Pine.LNX.4.64N.0704041240410.19559@blysk.ds.pg.gda.pl>
References: <20070404162934.2635ef95.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.1/3011/Wed Apr  4 06:15:22 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 4 Apr 2007, Yoichi Yuasa wrote:

> This patch has fixed build error on zs serial driver.
> 
> drivers/tc/zs.c:73:24: error: asm/dec/tc.h: No such file or directory
> make[2]: *** [drivers/tc/zs.o] Error 1
> 
> Yoichi
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 The driver is on its way out though.

  Maciej
