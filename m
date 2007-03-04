Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Mar 2007 21:37:40 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:18111 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037832AbXCDVhi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Mar 2007 21:37:38 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l24LZj8i008185;
	Sun, 4 Mar 2007 21:35:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l24LZhet008184;
	Sun, 4 Mar 2007 21:35:43 GMT
Date:	Sun, 4 Mar 2007 21:35:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] fix Cobalt early printk
Message-ID: <20070304213543.GA8141@linux-mips.org>
References: <20070302124233.6b9f2c67.yoichi_yuasa@tripeaks.co.jp> <20070302133644.GB19957@linux-mips.org> <20070305054851.492386c8.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070305054851.492386c8.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 05, 2007 at 05:48:51AM +0900, Yoichi Yuasa wrote:

> On Fri, 2 Mar 2007 13:36:44 +0000
> Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> > On Fri, Mar 02, 2007 at 12:42:33PM +0900, Yoichi Yuasa wrote:
> > 
> > > This patch has fixed Cobalt early printk.
> > 
> > Applied.  Thanks,
> 
> It's only applied to 2.6.20-stable.
> Please apply to master too.

Indeed.  Worse, the patch happened to apply cleanly on 2.6.20-stable but
doesn't work there so I reverted it on 2.6.20 and applied it on master.

Thanks,

  Ralf
