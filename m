Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 12:56:38 +0000 (GMT)
Received: from p3EE2BA30.dip.t-dialin.net ([IPv6:::ffff:62.226.186.48]:40743
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225228AbULPM4e>; Thu, 16 Dec 2004 12:56:34 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBGCuJPD013401;
	Thu, 16 Dec 2004 13:56:19 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBGCuElS013385;
	Thu, 16 Dec 2004 13:56:14 +0100
Date: Thu, 16 Dec 2004 13:56:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: macro@linux-mips.org, wlacey@goldenhindresearch.com,
	linux-mips@linux-mips.org
Subject: Re: No PCI_AUTO in 2.6...
Message-ID: <20041216125614.GA13355@linux-mips.org>
References: <20041215164036.GC30130@linux-mips.org> <Pine.LNX.4.58L.0412151648460.2706@blysk.ds.pg.gda.pl> <20041215184213.GB32491@linux-mips.org> <20041216.111746.25908722.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216.111746.25908722.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 16, 2004 at 11:17:46AM +0900, Atsushi Nemoto wrote:

> BTW, yenta_socket driver uses PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM, so
> these variables should be exported?

Yes.

  Ralf
