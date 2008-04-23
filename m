Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2008 02:46:11 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:15109 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28581982AbYDWBqI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2008 02:46:08 +0100
Received: by mo.po.2iij.net (mo32) id m3N1k41f071052; Wed, 23 Apr 2008 10:46:04 +0900 (JST)
Received: from rally.tripeaks.co.jp (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id m3N1k3Bw015816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Apr 2008 10:46:03 +0900
Message-Id: <200804230146.m3N1k3Bw015816@po-mbox300.hop.2iij.net>
Date:	Wed, 23 Apr 2008 10:46:03 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] [MIPS] add DECstation I/O ASIC clocksource
In-Reply-To: <Pine.LNX.4.55.0804230135190.23679@cliff.in.clinika.pl>
References: <20080423085140.a693b2e5.yoichi_yuasa@tripeaks.co.jp>
	<Pine.LNX.4.55.0804230135190.23679@cliff.in.clinika.pl>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Maciej,

On Wed, 23 Apr 2008 01:46:16 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> On Wed, 23 Apr 2008, Yoichi Yuasa wrote:
> 
> > add DECstation I/O ASIC clocksource
> 
>  Thanks, I will have a look into it; reasonably soon I hope -- I'm
> updating my tree right now.  I am quite surprised you care about this 
> platform too.

I'm interested in the little endian systems ;)
 
> > +void __init dec_ioasic_clocksource_init(void)
> > +{
> > +	clocksource_dec.rating = 200;
> > +	clocksource_set_clock(&clocksource_dec, 25000000);
> > +
> > +	clocksource_register(&clocksource_dec);
> > +}
> 
>  This is not true for all systems -- the clock rate is based on the
> TURBOchannel clock and it varies across systems.  And some have no counter
> in the I/O ASIC at all (it has been added in a later revision of the 
> chip), which the old code handled albeit not in the prettiest way (by 
> chance actually, as originally I did know of the older revision).

Hmm, we should measure the clock rate.
OK, I'll update dec-ioasic clocksource.

Yoichi
