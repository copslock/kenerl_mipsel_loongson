Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2002 11:41:31 +0200 (CEST)
Received: from p508B682B.dip.t-dialin.net ([80.139.104.43]:59283 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123926AbSJCJla>; Thu, 3 Oct 2002 11:41:30 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g939fBN13750;
	Thu, 3 Oct 2002 11:41:11 +0200
Date: Thu, 3 Oct 2002 11:41:11 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@ftp.linux-mips.org: linux
Message-ID: <20021003114111.A13703@linux-mips.org>
References: <20020930165347Z1122169-9213+249@linux-mips.org> <20021003.121705.74756199.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021003.121705.74756199.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Thu, Oct 03, 2002 at 12:17:05PM +0900
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 03, 2002 at 12:17:05PM +0900, Atsushi Nemoto wrote:

> This commit contains following change.  It seems 'addr' argument is
> not used.  Isn't this a mistake?

Yes, it is.  Fixed,

  Ralf
