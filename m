Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 23:41:47 +0000 (GMT)
Received: from p508B7F35.dip.t-dialin.net ([IPv6:::ffff:80.139.127.53]:19331
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226085AbULAXlm>; Wed, 1 Dec 2004 23:41:42 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iB1Ndfpt003120;
	Thu, 2 Dec 2004 00:39:41 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iB1Ndf3H003109;
	Thu, 2 Dec 2004 00:39:41 +0100
Date: Thu, 2 Dec 2004 00:39:41 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
Message-ID: <20041201233940.GA15116@linux-mips.org>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de> <16813.39660.948092.328493@doms-laptop.algor.co.uk> <20041201123336.GA5612@linux-mips.org> <Pine.LNX.4.58L.0412012136480.13579@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0412012136480.13579@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 01, 2004 at 09:50:45PM +0000, Maciej W. Rozycki wrote:

>  No surprise as the "o" constraint doesn't mean anything particular for
> MIPS.  All addresses are offsettable -- there is no addressing mode that
> would preclude it, so "o" is exactly the same as "m".

This is what the gcc docs say:

[...]
`o'
     A memory operand is allowed, but only if the address is
     "offsettable".  This means that adding a small integer (actually,
     the width in bytes of the operand, as determined by its machine
     mode) may be added to the address and the result is also a valid
     memory address.

     For example, an address which is constant is offsettable; so is an
     address that is the sum of a register and a constant (as long as a
     slightly larger constant is also within the range of
     address-offsets supported by the machine); but an autoincrement or
     autodecrement address is not offsettable.  More complicated
     indirect/indexed addresses may or may not be offsettable depending
     on the other addressing modes that the machine supports.
[...]

So it is not the same as "m".

  Ralf
