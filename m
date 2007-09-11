Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 14:13:35 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:52402 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022304AbXIKNN0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2007 14:13:26 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 5C10DB84B1;
	Tue, 11 Sep 2007 14:54:52 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IV5G1-0001xh-IU; Tue, 11 Sep 2007 13:54:21 +0100
Date:	Tue, 11 Sep 2007 13:54:21 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Vlad Lungu <vlad@comsys.ro>
Cc:	qemu-devel@nongnu.org, linux-mips@linux-mips.org
Subject: Re: [Qemu-devel] Qemu and Linux 2.4
Message-ID: <20070911125421.GE10713@networkno.de>
References: <46E68AA3.2010907@comsys.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46E68AA3.2010907@comsys.ro>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Vlad Lungu wrote:
> I know some of you will laugh, but:
>
> - QEMU malta emulation is not really complete, to put it mildly

Out of curiosity, what parts did you miss?

> - the QEMU target is available only for Linux 2.6
> - despite popular opinion, 2.4 ain't dead yet, at least in the embedded 
> market
>
>
> I have a port of the QEMU target for Linux 2.4.34.4 (latest 2.4 kernel on 
> linux-mips.org), with NE2000 card working (in both BE and LE modes).
> Still rough at the edges, but it works on stock qemu-0.9.0 with -M mips.

I recommend to improve the Qemu Malta emulation, and make it work with
2.4 Malta kernels. (ISTR it used to work, so it shouldn't need a lot to
get there.)


Thiemo
