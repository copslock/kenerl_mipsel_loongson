Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 04:39:40 +0000 (GMT)
Received: from mo00.po.2iij.Net ([210.130.202.204]:48124 "EHLO
	mo00.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8133361AbWB1Eja (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 04:39:30 +0000
Received: NPO MO00 id k1S4l7wQ006792; Tue, 28 Feb 2006 13:47:07 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox02) id k1S4l64f029447
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 28 Feb 2006 13:47:06 +0900 (JST)
Message-Id: <200602280447.k1S4l64f029447@mbox02.po.2iij.net>
Date:	Tue, 28 Feb 2006 13:47:06 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: drivers!
In-Reply-To: <20060227191033.GB22383@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com>
	<20060220003439.GA18438@deprecation.cyrius.com>
	<20060227191033.GB22383@deprecation.cyrius.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 10669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 27 Feb 2006 19:10:33 +0000
Martin Michlmayr <tbm@cyrius.com> wrote:

> * Martin Michlmayr <tbm@cyrius.com> [2006-02-20 00:34]:
> > >  drivers/char/ibm_workpad_keymap.map        |  343 ++++
> > > Michael Klar <wyldfier@iname.com>
> 
> Yoichi, as the maintainre of the IBM z50 support, can you comment?

v2.6 don't include IBM z50(vr41xx) keyboard driver.
I think it can be removed.

Yoichi
