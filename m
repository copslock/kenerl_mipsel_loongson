Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2003 14:34:02 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:1009 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224772AbTLVOd7>;
	Mon, 22 Dec 2003 14:33:59 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA26662;
	Mon, 22 Dec 2003 23:33:20 +0900 (JST)
Received: 4UMDO00 id hBMEXJX04704; Mon, 22 Dec 2003 23:33:19 +0900 (JST)
Received: 4UMRO00 id hBMEXH121490; Mon, 22 Dec 2003 23:33:18 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Mon, 22 Dec 2003 23:33:16 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: yuasa@hh.iij4u.or.jp, ppopov@mvista.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: defconfigs
Message-Id: <20031222233316.48e4c0b5.yuasa@hh.iij4u.or.jp>
In-Reply-To: <Pine.LNX.4.55.0312221420510.27237@jurand.ds.pg.gda.pl>
References: <1072069822.1927.9.camel@localhost.localdomain>
	<Pine.LNX.4.55.0312221420510.27237@jurand.ds.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Mon, 22 Dec 2003 14:22:55 +0100 (CET)
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

> On Mon, 21 Dec 2003, Pete Popov wrote:
> 
> > How about if I create an arch/mips/configs directory and move all
> > defconfig files there?  I know we've talked about this in the past and I
> > don't remember any good reasons for not doing it?
> 
>  Except the plain "defconfig" file wants to keep sitting in arch/mips to
> be picked up by configuration scripts.

I think it's means like arch/ppc/configs.

Yoichi
