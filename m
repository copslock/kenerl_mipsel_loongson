Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 01:10:05 +0000 (GMT)
Received: from p508B796B.dip.t-dialin.net ([IPv6:::ffff:80.139.121.107]:40380
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225202AbTBUBKE>; Fri, 21 Feb 2003 01:10:04 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1L19pK16773;
	Fri, 21 Feb 2003 02:09:51 +0100
Date: Fri, 21 Feb 2003 02:09:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Kip Walker <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: __volatile__ for asms in unaligned.c
Message-ID: <20030221020950.E6463@linux-mips.org>
References: <3E555A2E.5920F387@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E555A2E.5920F387@broadcom.com>; from kwalker@broadcom.com on Thu, Feb 20, 2003 at 02:43:58PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 02:43:58PM -0800, Kip Walker wrote:

> Anyway, is there a reason these aren't marked as volatile?  The gcc docs
> have the scary comment "You can prevent an `asm' instruction from being
> deleted, MOVED SIGNIFICANTLY, or combined, by writing the keyword
> `volatile' after the`asm'."

It's a valid code movement by gcc's no longer really new basic block
reordering thing.  I admit I'm pretty surprised this wasn't found before.

So I just added the volatiles.

  Ralf
