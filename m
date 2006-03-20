Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 15:50:39 +0000 (GMT)
Received: from mo01.po.2iij.Net ([210.130.202.205]:60408 "EHLO
	mo01.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8133390AbWCTPuS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 15:50:18 +0000
Received: NPO MO01 id k2KFxj8f025420; Tue, 21 Mar 2006 00:59:45 +0900 (JST)
Received: from localhost.localdomain (249.29.30.125.dy.iij4u.or.jp [125.30.29.249])
	by mbox.po.2iij.net (NPO-MR/mbox03) id k2KFxgLI029875
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 21 Mar 2006 00:59:44 +0900 (JST)
Date:	Tue, 21 Mar 2006 00:59:40 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	akpm@osdl.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 1/12] [MIPS] Improve description of VR41xx based
 machines
Message-Id: <20060321005940.35ce09f9.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060320131053.GA29434@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
	<20060320043902.GA20416@deprecation.cyrius.com>
	<20060320152646.1c5690e3.yoichi_yuasa@tripeaks.co.jp>
	<20060320131053.GA29434@deprecation.cyrius.com>
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
X-archive-position: 10883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 20 Mar 2006 13:10:53 +0000
Martin Michlmayr <tbm@cyrius.com> wrote:

> * Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> [2006-03-20 15:26]:
> > > MIPS supports various NEC VR41XX chips and not just the VR4100.
> > > Update Kconfig accordingly, thereby bringing the file in sync with
> > > the linux-mips tree.
> > The linux-mips tree is older than kernel.org about this part.
> 
> Have you looked at the exact change I sent (I know that linux-mips has
> some older stuff, but the patch I sent was against linux-mips+new).
> IOW, is it more correct to say "VR4100" in Kconfig rather than
> "VR41XX", even though more CPUs than the VR4100 are supported?
> 
> All my patch does is a a/VR4100/VR41XX/, really.

VR4131 and VR4133, .... are included in NEC VR4100 series.
These entry have no problem.

Yoichi

see:
http://www.necel.com/micro/english/product/vr/vr.html

> 
> 
> > > -	bool "Support for NEC VR4100 series based machines"
> > > +	bool "Support for NEC VR41XX-based machines"
> ...
> > > -	  The options selects support for the NEC VR4100 series of processors.
> > > +	  The options selects support for the NEC VR41xx series of processors.
> > >  	  Only choose this option if you have one of these processors as a
