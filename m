Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 05:13:34 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:9261 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037715AbWHLENJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2006 05:13:09 +0100
Received: by mo.po.2iij.net (mo32) id k7C4CreH031790; Sat, 12 Aug 2006 13:12:53 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox31) id k7C4CoA0007077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 12 Aug 2006 13:12:50 +0900 (JST)
Date:	Sat, 12 Aug 2006 13:12:49 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, daniel@caiaq.de,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Au1200 OHCI/EHCI fixes
Message-Id: <20060812131249.0c70ddba.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <816d36d30608111945h13272401i31f988064181f099@mail.gmail.com>
References: <20060810065337.GA8889@roarinelk.homelinux.net>
	<78B291EC-774F-4FDF-AB9D-133F38A3215E@caiaq.de>
	<816d36d30608111945h13272401i31f988064181f099@mail.gmail.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, 11 Aug 2006 22:45:28 -0400
"Ricardo Mendoza" <mendoza.ricardo@gmail.com> wrote:

> On 8/10/06, Daniel Mack <daniel@caiaq.de> wrote:
> 
> > This has already been fixed - a similar patch went upstream to 2.6.18-
> > rc3.
> > Did you check out the latest git?
> 
> Actually I think a problem stood alive, there is a parent-less #endif
> in -rc4 that screwed up compile. I think it has been there since -rc2.

Try this git.
Some fixes are included in it after rc4.
Of course, #endif fix also.

git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.git/

Yoichi
