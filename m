Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 11:09:45 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:56472 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S28580150AbXARLJn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2007 11:09:43 +0000
Received: from lagash (88-106-179-150.dynamic.dsl.as9105.com [88.106.179.150])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 7385F84115;
	Thu, 18 Jan 2007 12:02:27 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1H7V3R-0001pY-64; Thu, 18 Jan 2007 11:03:37 +0000
Date:	Thu, 18 Jan 2007 11:03:37 +0000
To:	Anders Brogestam <anders.brogestam@avegasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: crt0.s for mips
Message-ID: <20070118110336.GB23469@networkno.de>
References: <1169094906.14832.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169094906.14832.3.camel@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Anders Brogestam wrote:
> Hi.
> 
> I am looking for a crt0.s file for the MIPS architecture. Included in
> all the Linux kernels that I downloaded and looked in there are only
> source for the PPC.

The Kernel has not much use for crt0.s, look in (userland) libc code
instead.


Thiemo
