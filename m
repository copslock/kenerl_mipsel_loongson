Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2006 22:42:34 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:48924 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038892AbWJaWmc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2006 22:42:32 +0000
Received: by mo.po.2iij.net (mo31) id k9VMgSNr055701; Wed, 1 Nov 2006 07:42:28 +0900 (JST)
Received: from localhost.localdomain (133.25.30.125.dy.iij4u.or.jp [125.30.25.133])
	by mbox.po.2iij.net (mbox31) id k9VMgQYw081153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Nov 2006 07:42:26 +0900 (JST)
Date:	Wed, 1 Nov 2006 07:42:25 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] fix wrong prom_getcmdline() definition
Message-Id: <20061101074225.706b0637.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061031134516.GA7795@linux-mips.org>
References: <200610310445.k9V4jFXT012552@mbox33.po.2iij.net>
	<20061031134516.GA7795@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 31 Oct 2006 13:45:16 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Oct 31, 2006 at 01:40:07PM +0900, Yoichi Yuasa wrote:
> 
> > This patch has fixed wrong prom_getcmdline() definition.
> 
> Fortunately an __init declaration of a function leaves the compiler
> entirely unimpressed.  Your patch only scratched the surface of the
> problem; so I went for below patch.  Further cleanup should be done but
> that would be unsuitable for 2.6.19 now that -rc4 is out.

It's better.

Thanks,

Yoichi
