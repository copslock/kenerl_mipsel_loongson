Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7JCsbRw006437
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 19 Aug 2002 05:54:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7JCsbZh006436
	for linux-mips-outgoing; Mon, 19 Aug 2002 05:54:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from irongate.swansea.linux.org.uk (pc2-cwma1-5-cust12.swa.cable.ntl.com [80.5.121.12])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7JCsXRw006398
	for <linux-mips@oss.sgi.com>; Mon, 19 Aug 2002 05:54:34 -0700
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.2/8.11.6) with ESMTP id g7JCv5u6019620;
	Mon, 19 Aug 2002 13:57:06 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.2/8.12.2/Submit) id g7JCv4RU019618;
	Mon, 19 Aug 2002 13:57:04 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: CVS Update@oss.sgi.com: linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1020819141201.14441C-100000@delta.ds2.pg.gda.pl>
References: <Pine.GSO.3.96.1020819141201.14441C-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 13:57:03 +0100
Message-Id: <1029761823.19375.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2002-08-19 at 13:35, Maciej W. Rozycki wrote:
>  Hmm, what's the intent of the change?  IDE, or more properly ATA, was
> originally an ISA-only device and is still only available as ISA-style
> implementations, AFAIK.  I'd prefer it to be available only if any of
> CONFIG_ISA, CONFIG_EISA, CONFIG_PCI (unsure about CONFIG_MCA) is set.

We support ATA devices attached to arbitary busses. The newest ATA code
supports arbitary mmio/pio addressing mechanisms. You don't need ISA or
an ISA like bus.
