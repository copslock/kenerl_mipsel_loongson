Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2008 09:47:58 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:40502 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20034517AbYGLIrz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Jul 2008 09:47:55 +0100
Received: by mo.po.2iij.net (mo30) id m6C8lktO042032; Sat, 12 Jul 2008 17:47:46 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox300) id m6C8lfOf008125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 12 Jul 2008 17:47:41 +0900
Date:	Sat, 12 Jul 2008 17:47:41 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Cc:	yoichi_yuasa@tripeaks.co.jp, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] mips_machtype define as one group
Message-Id: <20080712174741.c4dd3149.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080711143235.GA9016@alpha.franken.de>
References: <20080711225717.cbf55ccc.yoichi_yuasa@tripeaks.co.jp>
	<20080711143235.GA9016@alpha.franken.de>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Fri, 11 Jul 2008 16:32:35 +0200
tsbogend@alpha.franken.de (Thomas Bogendoerfer) wrote:

> On Fri, Jul 11, 2008 at 10:57:17PM +0900, Yoichi Yuasa wrote:
> > mips_machtype define as one group.
> 
> wouldn't it make more sense to kill that completly ?

mips_machtype is still used in some places.
Should we check first whether it can be removed?

Yoichi
