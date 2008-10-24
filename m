Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 18:18:26 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:2981 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22307407AbYJXRSR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 18:18:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9OHIBTP027697;
	Fri, 24 Oct 2008 18:18:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9OHIBLf027695;
	Fri, 24 Oct 2008 18:18:11 +0100
Date:	Fri, 24 Oct 2008 18:18:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>,
	Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH][MIPS] fix rb532 build error
Message-ID: <20081024171811.GE25297@linux-mips.org>
References: <20081025002124.de64b4f4.yoichi_yuasa@tripeaks.co.jp> <200810241725.12521.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200810241725.12521.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 24, 2008 at 05:25:12PM +0200, Florian Fainelli wrote:

> Hello Yoichi,
> 
> Le Friday 24 October 2008 17:21:24 Yoichi Yuasa, vous avez écrit :
> > arch/mips/pci/fixup-rc32434.c: In function 'pcibios_map_irq':
> > arch/mips/pci/fixup-rc32434.c:46: error: 'GROUP4_IRQ_BASE' undeclared
> > (first use in this function) arch/mips/pci/fixup-rc32434.c:46: error: (Each
> > undeclared identifier is reported only once
> > arch/mips/pci/fixup-rc32434.c:46: error: for each function it appears in.)
> > make[1]: *** [arch/mips/pci/fixup-rc32434.o] Error 1
> >
> 
> Adrian Bunk already submitted a similar patch few days before. This one or his 
> are fine. Thank you.
> 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> Acked-by: Florian Fainelli <florian@openwrt.org>

I applied Adrian's because he submitted it first with credits for
Yoichi added.

Thanks everybody,

  Ralf
