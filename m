Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 16:04:04 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:14374 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133524AbWFSPDz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jun 2006 16:03:55 +0100
Received: by mo.po.2iij.net (mo30) id k5JF3ptQ047104; Tue, 20 Jun 2006 00:03:51 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox30) id k5JF3lRa035274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Jun 2006 00:03:47 +0900 (JST)
Date:	Tue, 20 Jun 2006 00:03:46 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Merge window ...
Message-Id: <20060620000346.2b704b9b.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060619103653.GA4257@linux-mips.org>
References: <20060619103653.GA4257@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Mon, 19 Jun 2006 11:36:53 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> Just a reminder that 2.6.17 is out and as usual there is now a merge
> window of two weeks, so try anything that you wish to see to go to
> Linus to me asap ...

I think we should remove old boards support.
Cannot build the following boards now.

MIPS Atlas
MIPS Malta
MIPS SEAD
EV64120
ITE 8172G
Globespan IVR
Momentum Jaguar
Toshiba JMR-TX3927
Toshiba RBTX4938
Victor MP-C30X(I'm fixing it now)
Momentum Jaguar
Momentum Ocelot-3
Momentum Ocelot-C
Momentum Ocelot-G
MyCable XXS1500
RBHMA4500
SNI RM200
Sibyte BCM91250A-SWARM
Wind River PPMC(New one, It'll be fixed)

Also the folowing boards don't have config file.

4G Systems MTX-1
AMD Alchemy Bosporus
AMD Alchemy Mirage
Jazz family
Toshiba TBTX49[23]7

These boards are candidate for removal.
If there are none objection, we can add to feature-removal-schedule.txt.

Yoichi
