Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 10:32:28 +0000 (GMT)
Received: from r-bu.iij4u.or.jp ([IPv6:::ffff:210.130.0.89]:2273 "EHLO
	r-bu.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225200AbTBNKc1>;
	Fri, 14 Feb 2003 10:32:27 +0000
Received: from pudding.montavista.co.jp (gatekeeper.montavista.co.jp [202.232.97.130])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id h1EAWEN20009;
	Fri, 14 Feb 2003 19:32:14 +0900 (JST)
Date: Fri, 14 Feb 2003 19:26:37 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: yoichi_yuasa@montavista.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] Keep Machine selection alphabetically sorted
Message-Id: <20030214192637.255fbb2e.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <Pine.GSO.3.96.1030214102600.666B-100000@delta.ds2.pg.gda.pl>
References: <20030210212457.52128de1.yoichi_yuasa@montavista.co.jp>
	<Pine.GSO.3.96.1030214102600.666B-100000@delta.ds2.pg.gda.pl>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

On Fri, 14 Feb 2003 10:27:46 +0100 (MET)
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

> On Mon, 10 Feb 2003, Yoichi Yuasa wrote:
> 
> > Machine selection is sorted alphabetically by this patch.
> 
>  Hmm, it seems the patch does more than just this...

Oops, change which supports VR4100 series only by MIPS32 is also included in it.

Yoichi
