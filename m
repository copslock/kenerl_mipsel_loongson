Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 12:49:35 +0100 (BST)
Received: from [IPv6:::ffff:81.2.110.250] ([IPv6:::ffff:81.2.110.250]:46982
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8226142AbVGALtS>; Fri, 1 Jul 2005 12:49:18 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j61BkUju014755;
	Fri, 1 Jul 2005 12:46:30 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j61BkTeO014754;
	Fri, 1 Jul 2005 12:46:29 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: RFH:  What are the semantics of writeb() and friends?
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0507011002520.30138@blysk.ds.pg.gda.pl>
References: <01049E563C8ECC43AD6B53A5AF419B38098BD2@avtrex-server2.hq2.avtrex.com>
	 <Pine.LNX.4.61L.0507011002520.30138@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1120218385.12446.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Fri, 01 Jul 2005 12:46:28 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-07-01 at 10:33, Maciej W. Rozycki wrote:
> > al.?  I would assume that the effects of these must be in the same order 
> > that they were issued, and that any hardware write back queue cannot 
> > combine or merge them in any way.  Is that correct?
> 
>  No it's not.  You need to insert appropriate barriers, one of: wmb(), 
> mb() or rmb().  In rare cases you may need to use iob(), which is 
> currently non-portable (which reminds me I should really push it 
> upstream).

Its even more complicated than that 8)

writeb/writel may be merged in some cases (but not re-ordered) for I/O
devices but a simple mb() will only synchronize them as viewed from
cpu/memory interface. There are two other synchronization points. From
the bridge with the I/O device (typically the PCI root bridge) which is
not enforced automatically across processors on some large numa boxes
but is not usually a problem and on the PCI bus itself.

PCI permits posting (delaying writes) and some forms of merging (but not
re-ordering). Thus if you need an I/O to hit a device on the PCI bus and
know it arrived you must follow it by a read from the same device. So
for example if you want to shut down a DMA transfer and free the buffer
for a PCI device you
need to do

		writel(TURN_DMA_OFF, dev->control);
		readl(dev->something);
		/* Only now is the free safe */

Alan
