Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2004 19:33:13 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:46659
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8226045AbUD0SdM>; Tue, 27 Apr 2004 19:33:12 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BIXOH-0000kX-00
	for <linux-mips@linux-mips.org>; Tue, 27 Apr 2004 20:33:09 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BIXOH-00021Y-00
	for <linux-mips@linux-mips.org>; Tue, 27 Apr 2004 20:33:09 +0200
Date: Tue, 27 Apr 2004 20:33:09 +0200
To: linux-mips@linux-mips.org
Subject: Re: TLB on R10k
Message-ID: <20040427183309.GR16797@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.4.10.10404272004460.14972-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404272004460.14972-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Stanislaw Skowronek wrote:
> Why, in tlb-andes.c, all exception handlers are prefixed with an
> ampersand (&) when copying them to main memory, only the r10k fill handler
> isn't?

Sloppiness, I guess. They resolve to function pointers anyway. But the
flush_icache_range should be fixed to cover all memcpy'ed memory.


Thiemo
