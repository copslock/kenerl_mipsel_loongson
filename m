Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 23:39:32 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:18447 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038724AbXBVXj1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Feb 2007 23:39:27 +0000
Received: by mo.po.2iij.net (mo32) id l1MNc5fl063186; Fri, 23 Feb 2007 08:38:05 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id l1MNc2YP077756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 23 Feb 2007 08:38:02 +0900 (JST)
Date:	Fri, 23 Feb 2007 08:38:02 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: Questions on the procedure/policy for patch submission
Message-Id: <20070223083802.42222ae8.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <45DE21B1.3070309@pmc-sierra.com>
References: <45DE21B1.3070309@pmc-sierra.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Thu, 22 Feb 2007 15:05:21 -0800
Marc St-Jean <Marc_St-Jean@pmc-sierra.com> wrote:

> 1a. Do patches living completely in arch/mips and include/asm-mips only have to be submitted to the l-m.o?

You can see the general rules Documentation/SubmittingPatches in kernel source.
You should submit MIPS part to linux-mips mailing list.

> 1b. If so, does this imply that l-m.o will push them to kernel.org?

Yes.

> 2a. Do patches which are outside the above directories have the be submitted to the kernel.org list?

You will be able to find a suitable mailing list in MAINTAINERS in kernel source.

> 2b. If so, how are dependencies between the two sets of submission handled during the review process?

If they have dependency, you should add linux-mips mailing list to Cc:. 

Yoichi
