Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 10:13:12 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:5816
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023944AbYHGJMr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Aug 2008 10:12:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m779CYvg010436;
	Thu, 7 Aug 2008 10:12:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m779CXIw010434;
	Thu, 7 Aug 2008 10:12:33 +0100
Date:	Thu, 7 Aug 2008 10:12:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Alessandro Zummo <alessandro.zummo@towertech.it>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] DS1286: new RTC driver
Message-ID: <20080807091233.GA10389@linux-mips.org>
References: <20080803174137.AF8071DA6F4@solo.franken.de> <20080807105249.50d6e777@i1501.lan.towertech.it> <Pine.LNX.4.64.0808071102420.23641@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0808071102420.23641@anakin>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 07, 2008 at 11:03:07AM +0200, Geert Uytterhoeven wrote:

> > > +	priv = kzalloc(sizeof *priv, GFP_KERNEL);
> > 
> >  sizeof(struct ds1286_priv) is a little bit cleaner.
> 
> What if the type of priv changes?

Then this code will more changes anyway ...

  Ralf
