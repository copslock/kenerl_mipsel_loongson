Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 04:47:27 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:24343 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28603871AbYCRErZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2008 04:47:25 +0000
Received: by mo.po.2iij.net (mo31) id m2I4lLTk064335; Tue, 18 Mar 2008 13:47:21 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id m2I4lJ40005091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 18 Mar 2008 13:47:19 +0900
Message-Id: <200803180447.m2I4lJ40005091@po-mbox301.hop.2iij.net>
Date:	Tue, 18 Mar 2008 13:47:20 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2][MIPS] replace c0_compare acknowledge by
 c0_timer_ack()
In-Reply-To: <20080317161635.GA25549@linux-mips.org>
References: <20080317234740.705a8a34.yoichi_yuasa@tripeaks.co.jp>
	<20080317161635.GA25549@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Mon, 17 Mar 2008 16:16:35 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Mar 17, 2008 at 11:47:40PM +0900, Yoichi Yuasa wrote:
> 
> > VR41xx, CP0 hazard is necessary between read_c0_count() and write_c0_compare().
> 
> Interesting.  I wonder why you need this patch but nobody else?

Three NOP are necessary on the TB0287(VR4131 board).

Yoichi
