Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 14:14:42 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:7043 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20023388AbXLCOOe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Dec 2007 14:14:34 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 3931F48BE4;
	Mon,  3 Dec 2007 15:14:28 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1IzC42-0005OA-Uq; Mon, 03 Dec 2007 14:14:26 +0000
Date:	Mon, 3 Dec 2007 14:14:26 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: Rename Sibyte duart devices?
Message-ID: <20071203141426.GI617@networkno.de>
References: <20071203130818.GA6466@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071203130818.GA6466@linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Devices created by udev have been named duart? instead of the common
> ttyS?.  This is a nuisance because it requires changes to all sorts of
> config files such as /etc/inittab, /etc/securetty etc. to work.  I
> suggest to kill the problem by the root by something like the below
> patch.  Comments?

Debian uses such a patch since forever to avoid all the trouble.


Thiemo
