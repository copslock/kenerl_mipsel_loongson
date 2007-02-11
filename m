Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2007 15:44:42 +0000 (GMT)
Received: from www.osadl.org ([213.239.205.134]:32741 "EHLO mail.tglx.de")
	by ftp.linux-mips.org with ESMTP id S20039033AbXBKPoh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2007 15:44:37 +0000
Received: from [IPv6:::1] (debian [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id 38C4F65C292;
	Sun, 11 Feb 2007 16:44:06 +0100 (CET)
Subject: Re: [PATCH] eXcite nand flash driver
From:	Thomas Gleixner <tglx@linutronix.de>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
In-Reply-To: <200702101122.05049.thomas.koeller@baslerweb.com>
References: <200702080157.25432.thomas.koeller@baslerweb.com>
	 <1170949737.3646.29.camel@chaos>
	 <200702101122.05049.thomas.koeller@baslerweb.com>
Content-Type: text/plain
Date:	Sun, 11 Feb 2007 16:44:12 +0100
Message-Id: <1171208652.3661.2.camel@chaos>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Sat, 2007-02-10 at 11:22 +0100, Thomas Koeller wrote:
> > So I expect an OOPS happens on a regular base.
> I guess it is the 'static void __iomem *tgt = NULL' part that worries
> you? Think about it, that value is never used.

True.

> However, I admit it is somewhat unclean, and therefore I am changing
> it. Updated patch follows.

Yes, it is confusing and looks horrible.

	tglx
