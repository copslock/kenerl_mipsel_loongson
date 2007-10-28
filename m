Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 23:11:50 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:30279 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023992AbXJ1XLl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Oct 2007 23:11:41 +0000
Received: by mo.po.2iij.net (mo30) id l9SNBbUE045184; Mon, 29 Oct 2007 08:11:37 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l9SNBZ7S005135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 29 Oct 2007 08:11:35 +0900
Message-Id: <200710282311.l9SNBZ7S005135@po-mbox302.po.2iij.net>
Date:	Mon, 29 Oct 2007 08:11:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove unused mips_machtype
In-Reply-To: <20071028191906.GA7661@linux-mips.org>
References: <20071026224231.1aaddf3e.yoichi_yuasa@tripeaks.co.jp>
	<20071028191906.GA7661@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Sun, 28 Oct 2007 19:19:06 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Oct 26, 2007 at 10:42:31PM +0900, Yoichi Yuasa wrote:
> 
> > Removed unused mips_machtype.
> > These are only set though are not used.
> 
> I'm getting a large number of rejects on this patch.

Really? I have no problem to applly it on current git.

Yoichi
