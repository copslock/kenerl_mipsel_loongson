Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 18:13:51 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:10704 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038971AbXBTSNt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Feb 2007 18:13:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1KIDmpq006093;
	Tue, 20 Feb 2007 18:13:48 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1KIDmxo006092;
	Tue, 20 Feb 2007 18:13:48 GMT
Date:	Tue, 20 Feb 2007 18:13:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	Andrew Sharp <tigerand@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Clean up serial console support on Sibyte 1250 duart
Message-ID: <20070220181348.GA6049@linux-mips.org>
References: <66910A579C9312469A7DF9ADB54A8B7D627017@exchange.ZeugmaSystems.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D627017@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 20, 2007 at 09:03:56AM -0800, Kaz Kylheku wrote:

> Andrew Sharp wrote:
> > Clean up the serial console support on the Sibyte 1250's
> > built in duart.
> 
> Hi Andrew,
> 
> Would it be too much trouble to split the patch into two: the whitespace
> changes, and the actual bugfix?

While that's strongly prefered I wasn't picky in this case because this
driver only has a single job left to do - as a stop gap until there is
a new driver for the drivers/serial subsystem.

  Ralf
