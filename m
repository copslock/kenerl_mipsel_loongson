Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:37:05 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:21515
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225397AbUDXHhE>; Sat, 24 Apr 2004 08:37:04 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BHHih-0003hs-00
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 09:37:03 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BHHih-00032O-00
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 09:37:03 +0200
Date: Sat, 24 Apr 2004 09:37:03 +0200
To: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
Message-ID: <20040424073703.GO22147@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.55.0404231849480.14494@jurand.ds.pg.gda.pl> <Pine.GSO.4.10.10404240825540.10762-100000@helios.et.put.poznan.pl> <20040424071751.GA561@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040424071751.GA561@linux-mips.org>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
[snip]
> A code model which I'm considering as alternative is -G optimization but
> that will require a good bit of work; we would have to free up $28 which
> right now we're already using for the current pointer.

Gas has currently not much support for non-PIC n64 GP optimizations. The
recent changes have simplified the task of implementing them, though.


Thiemo
